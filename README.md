# Grouping commands

Grouping commands can be very important to reduce the size of your container(s) due to how the layers work.

Each layer contains everything that changed in the filesystem based on its previous layer. So comparing two consecutive layers, we should obtain a delta that describes what changed in the filesystem.

Let's see how we cam improve an image such as the one below that ships [kubectl](https://github.com/kubernetes/kubectl):

```Dockerfile
FROM bitnami/minideb:buster

RUN install_packages ca-certificates curl
RUN curl -L --output /usr/local/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
RUN chmod +x /usr/local/bin/kubectl

ENTRYPOINT [ "kubectl" ]
CMD [ "--help" ]
```

If we build a `kubectl` image based on that Dockerfile, and we analyze its layers:

```console
$ docker history kubectl
IMAGE               CREATED              CREATED BY                                      SIZE                COMMENT
0d0c17dc554f        About a minute ago   CMD ["--help"]                                  0B                  buildkit.dockerfile.v0
<missing>           About a minute ago   ENTRYPOINT ["kubectl"]                          0B                  buildkit.dockerfile.v0
<missing>           About a minute ago   RUN /bin/sh -c chmod +x /usr/local/bin/kubec…   44MB                buildkit.dockerfile.v0
<missing>           About a minute ago   RUN /bin/sh -c curl -L --output /usr/local/b…   44MB                buildkit.dockerfile.v0
<missing>           About a minute ago   RUN /bin/sh -c install_packages ca-certifica…   12.8MB              buildkit.dockerfile.v0
<missing>           3 weeks ago                                                          67.5MB              from Bitnami with love
$ docker images
REPOSITORY                           TAG                 IMAGE ID            CREATED             SIZE
kubectl                              latest              0d0c17dc554f        2 minutes ago       168MB
```

We can see that there are two layers adding 44MB to the image size. However, one of these layers it's just changing the binary permissions, we're not adding new content to the image!!!
This is due to how the layers work. We can improve the final image by applying the change below:

```diff
FROM bitnami/minideb:buster

- RUN curl -L --output /usr/local/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
- RUN chmod +x /usr/local/bin/kubectl
+ RUN curl -L --output /usr/local/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && \
      chmod +x /usr/local/bin/kubectl

ENTRYPOINT [ "kubectl" ]
CMD [ "--help" ]
```

If we analyze the layers again...

```console
$ docker history kubectl
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
ff6fcfec2e48        1 second ago        CMD ["--help"]                                  0B                  buildkit.dockerfile.v0
<missing>           1 second ago        ENTRYPOINT ["kubectl"]                          0B                  buildkit.dockerfile.v0
<missing>           1 second ago        RUN /bin/sh -c curl -L --output /usr/local/b…   44MB                buildkit.dockerfile.v0
<missing>           6 minutes ago       RUN /bin/sh -c install_packages ca-certifica…   12.8MB              buildkit.dockerfile.v0
<missing>           3 weeks ago                                                         67.5MB              from Bitnami with love
$ docker images
REPOSITORY                           TAG                 IMAGE ID            CREATED             SIZE
kubectl                              latest              ff6fcfec2e48        1 second ago        124MB
```

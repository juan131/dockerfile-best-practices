# Best Practices writing a Dockerfile

Use multi-stage builds to separate build and runtime environments. This approach is extremely effective when building images for compiled applications.

Let's see how we cam improve an image such as the one below that builds [Kubeapps Tiller Proxy](https://github.com/kubeapps/kubeapps/tree/master/cmd/tiller-proxy), one of the core components of [Kubeapps](http://kubeapps.io/):

```Dockerfile
ARG VERSION

FROM bitnami/minideb:stretch
RUN install_packages ca-certificates curl git
RUN curl https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz | tar -xzf - -C /usr/local
ENV PATH="/usr/local/go/bin:$PATH" CGO_ENABLED=0
RUN go get -u github.com/golang/glog && go get -u github.com/kubeapps/kubeapps/cmd/tiller-proxy
RUN go build -a -installsuffix cgo -ldflags "-X main.version=$VERSION" github.com/kubeapps/kubeapps/cmd/tiller-proxy

EXPOSE 80
CMD ["/tiller-proxy"]
```

### Multi Stage approach

We can improve the final image by applying the changes below:

```diff
- ROM bitnami/minideb:stretch
+ FROM bitnami/minideb:stretch AS builder
...
+ FROM scratch
+ COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
+ COPY --from=builder /tiller-proxy /proxy
+
- CMD ["/tiller-proxy"]
+ CMD ["/proxy"]
```

As we can see, the final image uses scratch (which indicates that the next command in the Dockerfile is the first filesystem layer in the image) and it contains only what we need: the binary and the SSL certificates.

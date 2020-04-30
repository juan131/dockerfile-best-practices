FROM bitnami/minideb:buster

RUN install_packages ca-certificates curl
RUN curl -L --output /usr/local/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
RUN chmod +x /usr/local/bin/kubectl

ENTRYPOINT [ "kubectl" ]
CMD [ "--help" ]

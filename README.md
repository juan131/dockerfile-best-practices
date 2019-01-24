# Best Practices writing a Dockerfile

Reuse maintained images when possible

### Main changes

Use the `bitnami/node` image as base image:

```diff
- FROM bitnami/minideb
+ FROM bitnami/node:10-prod
- # Install required system packages
- RUN install_packages curl software-properties-common gnupg
- RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && install_packages nodejs
# Copy application files
...
```

Use the tag `10-prod` to ensure we the minimal packages:

```diff
- FROM bitnami/node
+ FROM bitnami/node:10-prod
# Copy application files
...
```

### Next step

- [5-multi-stage](https://github.com/juan131/dockerfile-best-practices/tree/5-multi-stage)

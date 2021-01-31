# Best Practices writing a Dockerfile

Reuse maintained images when possible!

## Main changes

Use the `bitnami/node` image as base image:

```diff
- FROM bitnami/minideb
+ FROM bitnami/node:12
- # Install required system packages
- RUN install_packages imagemagick curl software-properties-common gnupg
- RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && install_packages nodejs
# Copy application files
...
```

Use the tag `12-prod` to ensure minimal packages are shipped:

```diff
- FROM bitnami/node:12
+ FROM bitnami/node:12-prod
# Copy application files
...
```

## Next step

- [5-multi-stage](https://github.com/juan131/dockerfile-best-practices/tree/5-multi-stage)

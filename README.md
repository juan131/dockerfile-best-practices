# Best Practices writing a Dockerfile

Use Minideb, a minimalist Debian-based image built specifically to be used as a base image for containers.

### Main changes

Use Minideb:

```diff
- FROM debian
+ FROM bitnami/minideb
# Install required system packages
...
```

Replace the `apt-get` instructions with `install_packages`:

```diff
...
# Install required system packages
- RUN apt-get update && apt-get -y install --no-install-recommends curl software-properties-common gnupg
+ RUN install_packages curl software-properties-common gnupg
- RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get -y install --no-install-recommends nodejs && rm -rf /var/lib/apt/lists/*
+ RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && install_packages nodejs
# Copy application files
...
```

### Next step

- [4-maintained-images](https://github.com/juan131/dockerfile-best-practices/tree/4-maintained-images)


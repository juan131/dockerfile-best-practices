# Best Practices writing a Dockerfile

Avoid packaging dependencies you don't need

### Main changes

Remove debugging tools and add the flag `--no-install-recommends`:

```diff
...
RUN apt-get update
- RUN apt-get -y install imagemagick curl software-properties-common gnupg vim ssh
+ RUN apt-get -y install --no-install-recommends imagemagick curl software-properties-common gnupg
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
- RUN apt-get -y install nodejs
+ RUN apt-get -y install --no-install-recommends nodejs
# Install NPM dependencies
...
```

Join update/install system packages on a single build step:

```diff
...
- RUN apt-get update
- RUN apt-get install -y imagemagick curl software-properties-common gnupg
+ RUN apt-get update && apt-get -y install --no-install-recommends imagemagick curl software-properties-common gnupg
- RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
- RUN apt-get -y install --no-install-recommends nodejs
+ RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get -y install --no-install-recommends nodejs
# Install NPM dependencies
...
```

Remove the package manager cache:

```diff
...
RUN apt-get update && apt-get -y install --no-install-recommends imagemagick curl software-properties-common gnupg
- RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get -y install --no-install-recommends nodejs
+ RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get -y install --no-install-recommends nodejs && rm -rf /var/lib/apt/lists/*
# Install NPM dependencies
...
```

### Next step

- [3-minideb](https://github.com/juan131/dockerfile-best-practices/tree/3-minideb)

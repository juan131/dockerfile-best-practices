# Best Practices writing a Dockerfile

Take advantage of the build cache!

We can reduce the build time by reusing existing layers. To do so, layers that aren't likely to change should go first.

## Main changes

Switch the order so we avoid installing the system packages:

```diff
FROM debian
- # Copy application files
- COPY . /app
# Install required system packages
RUN apt-get update
...
RUN apt-get -y install nodejs
+ # Copy application files
+ COPY . /app
# Install NPM dependencies
...
```

Be more specific about the files we copy:

```diff
...
# Copy application files
- COPY . /app
+ COPY package.json server.js /app
# Install NPM dependencies
...
```

## Next step

- [2-unused-dependencies](https://github.com/juan131/dockerfile-best-practices/tree/2-unused-dependencies)

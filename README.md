# Best Practices writing a Dockerfile

Take advantage of the build cache

### Main changes

Switching the order so we avoid installing the system packages:

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

Being more specific about the files we copy:

```diff
...
# Copy application files
- COPY . /app
+ COPY package.json server.js /app
# Install NPM dependencies
...

### Next step

- [2-unused-dependencies](https://github.com/juan131/dockerfile-best-practices/blob/2-unused-dependencies)

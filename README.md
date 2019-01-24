# Best Practices writing a Dockerfile

This repository is a guide with a set of good practices when writting Dockerfiles.

Using a **Node.js** application as example, this guide will be a journey from a very basic Dockerfile to make it production ready, describing some of the best practices and common pitfalls that you are likely to encounter when developing Dockerfiles.

## Before we start...

On [this blog post]() you'll find detailed information about each of the steps we'll do to improve the Dockerfile. Please use it to follow this tutorial.

### Enable BuilKit

Use [BuildKit](https://github.com/moby/buildkit) to build your Docker images. It can be enabled on two different ways:

- Exporting the `DOCKER_BUILDKIT` environment variable:

```bash
$ export DOCKER_BUILDKIT=1
```

> TIP: add it to your ~/.bashrc file

- [Configuring the Docker Daemon](https://docs.docker.com/config/daemon/#configure-the-docker-daemon) to add the **Buildkit** feature:

```json
{
  "features": {
    "buildkit": true
  }
}
```

## How to use this tutorial

Starting from the 'master' branch, you'll find a branch with the files to use on each step of the tutorial.

It's only necessary to switch (checkout) to the proper branch. The available branches are:

- [1-cache-improvements](https://github.com/juan131/dockerfile-best-practices/tree/1-cache-improvements)
- [2-unused-dependencies](https://github.com/juan131/dockerfile-best-practices/tree/2-unused-dependencies)
- [3-minideb](https://github.com/juan131/dockerfile-best-practices/tree/3-minideb)
- [4-maintained-images](https://github.com/juan131/dockerfile-best-practices/tree/4-maintained-images)
- [5-multi-stage](https://github.com/juan131/dockerfile-best-practices/tree/5-multi-stage)
- [6-non-root](https://github.com/juan131/dockerfile-best-practices/tree/6-non-root)
- [7-workdir](https://github.com/juan131/dockerfile-best-practices/tree/7-workdir)
- [8-mounted-configuration](https://github.com/juan131/dockerfile-best-practices/tree/8-mounted-configuration)
- [9-logs](https://github.com/juan131/dockerfile-best-practices/tree/9-logs)
- [10-entrypoint](https://github.com/juan131/dockerfile-best-practices/tree/10-entrypoint)

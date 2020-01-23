# Best Practices writing a Dockerfile

Mount the application's configuration and the VOLUME instruction

### Main changes

Modify the application so the hostname and port to be used depends on a configuration file:

```diff
...
// Constants
- const serverHost = '127.0.0.1';
- const serverPort = 8080;
+ const settings = require('/settings/settings.json');
+ const serverHost = settings.host;
+ const serverPort = settings.port;
...
```

Create the **settings.json** file like shown below:

```bash
$ mkdir settings && cat > settings/settings.json<<'EOF'
{
  "host": "127.0.0.1",
  "port": "8080"
}
EOF
```

### The VOLUME instruction

The VOLUME directive is described as follows:

> The VOLUME instruction tells Docker to create a mount point with the specified path inside the container. This mount point is marked as holding an external volume from the host. The value for the VOLUME instruction can be a JSON array, `VOLUME ["/data/db/"]` or a string with one or more arguments, e.g. `VOLUME /var/log` or `VOLUME /var/log /data`.

And… And as stated in the [Docker Official Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/):

> The VOLUME instruction should be used to expose any database storage area, configuration storage, or files/folders created by your docker container. You are strongly encouraged to use VOLUME for any mutable and/or user-serviceable parts of your image.

However, using this directive in our *Dockerfile* has some implications:

If any build steps change the data within the volume after it has been declared, those changes will be discarded. E.g.:

```Dockerfile
VOLUME /data
RUN cat "Hello world!" /data/hello-world.txt # Warning: No 'hello-world.txt' file will be created!
```

When mounting a volume on a parent directory, that volume won't persist the data inside the mount point declared in the VOLUME directive. In this example the volume `my_data` won't persit data at `/foo/bar`:

```Dockerfile
VOLUME /foo/bar
```

```yaml
version: '2'
services:
  my-container:
    image: my-image
    volumes:
      - 'my_data:/foo'
volumes:
  my_data:
    driver: local
```

Based on this information, these are the standards we recommend to follow when using this directive:

- Every Docker image **must** use the VOLUME directive in the *Dockerfile* to persist any data created inside the container. Please note that we shouldn't use this directive for volumes used by users to mount its own data (e.g. an user who's using the NGINX container and mounts the static files of an app).
- Every *docker-compose.yml* must mount the volumes in the same mountPath declared in the VOLUME directive (e.g. if PostgreSQL container declares VOLUME `/bitnami/postgresql` every *docker-compose.yml* should mount the volumes at that path).


### Next step

- [9-logs](https://github.com/juan131/dockerfile-best-practices/tree/9-logs)

# Best Practices writing a Dockerfile

Mount the application's configuration and use the VOLUME instruction

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

Add the mount point to the Dockerfile:

```diff
...
EXPOSE 8080
+ VOLUME /settings
RUN groupadd -r -g 1001 nonroot && useradd -r -u 1001 -g nonroot nonroot
...
```

### Next step

- [9-logs](https://github.com/juan131/dockerfile-best-practices/tree/9-logs)

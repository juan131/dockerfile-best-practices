# Best Practices writing a Dockerfile

Redirect the application logs to stdout/stderr 

### Main changes

Redirect the apps' logs to stdout:

```diff
...
VOLUME /settings
+ RUN ln -sf /dev/stdout /var/log/app.log
RUN groupadd -r -g 1001 nonroot && useradd -r -u 1001 -g nonroot nonroot
...
```

### Next step

- [10-entrypoint](https://github.com/juan131/dockerfile-best-practices/tree/10-entrypoint)

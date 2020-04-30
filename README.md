# Best Practices writing a Dockerfile

Redirect the application logs to standar streams.

## Main changes

Redirect the apps' logs to stdout:

```diff
...
+ RUN ln -sf /dev/stdout /var/log/app.log
RUN useradd -r -u 1001 -g root nonroot
...
```

## Next step

- [10-entrypoint](https://github.com/juan131/dockerfile-best-practices/tree/10-entrypoint)

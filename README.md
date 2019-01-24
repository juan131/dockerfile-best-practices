# Best Practices writing a Dockerfile

Set the WORKDIR instruction

### Main changes

Adapt the working directory:

```diff
...
USER nonroot
+ WORKDIR /app
- CMD ["node", "/app/server.js"]
+ CMD ["node", "server.js"]
...
```

### Next step

- [8-mounted-configuration](https://github.com/juan131/dockerfile-best-practices/tree/8-mounted-configuration)

# Best Practices writing a Dockerfile

Use multi-stage builds to separate build and runtime environments!

Note: check [asset-syncer](https://github.com/juan131/dockerfile-best-practices/tree/asset-syncer) example for a better example.

## Main changes

Split the build process into different stages:

```diff
- FROM bitnami/node:12-prod
+ FROM bitnami/node:12 AS builder
COPY package.json server.js /app
RUN npm install --prefix /app

+ FROM bitnami/node:12-prod
+ COPY --from=builder /app/package.json /app/server.js /app
+ COPY --from=builder /app/node_modules /app/node_modules
- CMD ["npm", "start", "--prefix", "app"]
+ CMD ["node", "/app/server.js"]
...
```

### Next step

- [6-non-root](https://github.com/juan131/dockerfile-best-practices/tree/6-non-root)

# Best Practices writing a Dockerfile

Use non-root approach to enforce the container security

### Main changes

Change the default user from `root` to `nonroot`:

```diff
...
EXPOSE 80
+ RUN groupadd -r -g 1001 nonroot && useradd -r -u 1001 -g nonroot nonroot
+ USER nonroot
CMD ["node", "/app/server.js"]
...
```

Adapt the container to use alternative port such as `8080`:

- Dockerfile:

```dif
...
COPY --from=builder /tiller-proxy /proxy
- EXPOSE 80
+ EXPOSE 8080
USER nonroot
...
```

- server.js:

```diff
...
const serverHost = '127.0.0.1';
- const serverPort = 80;
+ const serverPort = 8080;
...
```

Give permissions to the `nonroot` user in the `/var/log/` directory:

```dif
...
RUN groupadd -r -g 1001 nonroot && useradd -r -u 1001 -g nonroot nonroot- EXPOSE 80
+ RUN chmod -R g+rwX /var/log && chown -R root:nonroot /var/log
USER nonroot
...
```

### Next step

- [7-workdir](https://github.com/juan131/dockerfile-best-practices/tree/7-workdir)
# Best Practices writing a Dockerfile

Define an entrypoint

## Main changes

Define entrypoint and use the `CMD` instruction to specify the arguments/flags of the command:

```diff
...
- CMD ["node", "server.js"]
+ ENTRYPOINT ["node"]
+ CMD ["server.js"]
```

FROM bitnami/node:12 AS builder
COPY package.json server.js /app/
RUN npm install --prefix /app

FROM bitnami/node:12-prod
COPY --from=builder /app/package.json /app/server.js /app/
COPY --from=builder /app/node_modules /app/node_modules
EXPOSE 80
CMD ["node", "/app/server.js"]

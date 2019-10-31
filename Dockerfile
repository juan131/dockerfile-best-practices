FROM bitnami/node:10 AS builder
COPY package.json server.js /app/
RUN npm install --prefix /app

FROM bitnami/node:10-prod
COPY --from=builder /app/package.json /app/server.js /app/
COPY --from=builder /app/node_modules /app/node_modules
EXPOSE 8080
VOLUME /settings
RUN useradd -r -u 1001 -g root nonroot
RUN chmod -R g+rwX /var/log
USER nonroot
WORKDIR /app
CMD ["node", "server.js"]

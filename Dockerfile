FROM bitnami/node:12-prod
# Copy application files
COPY package.json server.js /app/
# Install NPM dependencies
RUN npm install --prefix /app
EXPOSE 80
CMD ["npm", "start", "--prefix", "app"]

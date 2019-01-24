FROM debian
# Install required system packages
RUN apt-get update && apt-get -y install --no-install-recommends curl software-properties-common gnupg
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get -y install --no-install-recommends nodejs && rm -rf /var/lib/apt/lists/*
# Copy application files
COPY . /app
# Install NPM dependencies
RUN npm install --prefix /app
EXPOSE 80
CMD ["npm", "start", "--prefix", "app"]

FROM debian
# Install required system packages
RUN apt-get update
RUN apt-get -y install imagemagick curl software-properties-common gnupg vim ssh
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get -y install nodejs
# Copy application files
COPY package.json server.js /app
# Install NPM dependencies
RUN npm install --prefix /app
EXPOSE 80
CMD ["npm", "start", "--prefix", "app"]

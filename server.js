'use strict';

const express = require('express');
const fs = require('fs');

const myLogFileStream = fs.createWriteStream('/var/log/app.log');
const myConsole = new console.Console(myLogFileStream, myLogFileStream);

// Constants
const settings = require('/settings/settings.json');
const serverHost = settings.host;
const serverPort = settings.port;

// Express app
const app = express();
app.get('/', (req, res) => {
  res.send('Hello world\n');
});

app.listen(serverPort);
myConsole.log(`Running on http://${serverHost}:${serverPort}`);

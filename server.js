'use strict';

const express = require('express');
const fs = require('fs');

const myLogFileStream = fs.createWriteStream('/var/log/app.log');
const myConsole = new console.Console(myLogFileStream, myLogFileStream);

// Constants
const serverHost = '127.0.0.1';
const serverPort = 80;

// Express app
const app = express();
app.get('/', (req, res) => {
  res.send('Hello world\n');
});

app.listen(serverPort);
myConsole.log(`Running on http://${serverHost}:${serverPort}`);

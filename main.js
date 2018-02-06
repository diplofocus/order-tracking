'use strict'
const electron = require('electron');

const app = electron.app;
const BrowserWindow = electron.BrowserWindow;

let mainWindow;

app.on('ready', createWindow);

function createWindow () {
  mainWindow = new BrowserWindow({
    width: 1024,
    height: 768,
  });
  mainWindow.loadURL(`file://${__dirname}/src/static/index.html`);
  
  mainWindow.on('closed', function () {
    mainWindow = null;
  });
  mainWindow.setMenu(null);
  mainWindow.webContents.openDevTools();
}

app.on('activate', () => {
  if (mainWindow === null) { createWindow() }
});

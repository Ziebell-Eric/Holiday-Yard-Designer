const {app,BrowserWindow,shell}=require('electron');
const path=require('path');
function createWindow(){
 const win=new BrowserWindow({width:1480,height:920,minWidth:850,minHeight:580,backgroundColor:'#0d1420',webPreferences:{preload:path.join(__dirname,'preload.js'),nodeIntegration:false,contextIsolation:true,sandbox:true}});
 win.loadFile(path.join(__dirname,'index.html'));
 win.webContents.setWindowOpenHandler(({url})=>{if(/^https:\/\//.test(url))shell.openExternal(url);return {action:'deny'}});
 win.webContents.on('will-navigate',(event,url)=>{if(!url.startsWith('file:')){event.preventDefault();if(/^https:\/\//.test(url))shell.openExternal(url)}});
}
app.whenReady().then(()=>{createWindow();app.on('activate',()=>{if(BrowserWindow.getAllWindows().length===0)createWindow()})});
app.on('window-all-closed',()=>{if(process.platform!=='darwin')app.quit()});

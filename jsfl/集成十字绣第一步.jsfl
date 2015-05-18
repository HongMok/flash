var saveURL = fl.browseForFolderURL("请选择保存位置。")
var ele = fl.getDocumentDOM().getTimeline().layers[0].frames[0].elements;
var doc = fl.getDocumentDOM();
var prefix = "Plan";
var startIndex = Number(prompt("Enter startIndex", ""));
for(var i=0; i< ele.length; i++)
{
	doc.selectNone();
	doc.selection = [ele[i]];
	doc.convertToSymbol("movie clip", prefix + (startIndex + i), "top left");
}
doc.selectAll();
doc.deleteSelection();
var lib = fl.getDocumentDOM().library;
var itemArr = lib.items;
for(i=0; i< itemArr.length; i++)
{
	lib.addItemToDocument({x:300, y:300}, itemArr[i].name);
	doc.exportPNG(saveURL+'/'+itemArr[i].name,true,true);
	var originalFileURI=saveURL+'/'+itemArr[i].name+'img.png';
	var newFileURI=saveURL+'/'+itemArr[i].name+'.png';
	FLfile.copy(originalFileURI, newFileURI);
	FLfile.remove(originalFileURI);
	doc.selectAll();
	doc.deleteSelection();
}
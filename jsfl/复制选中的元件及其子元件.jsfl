var _doc = fl.getDocumentDOM();
var sel = _doc.selection;
var s = "", js = "", n = 0;
if(sel.length){
	fl.trace("你选择了" + sel.length + "个元件");
	_doc.clipCopy();
	fl.createDocument();
	var _temp = fl.getDocumentDOM();
	_temp.clipPaste(true);
	var index = fl.scriptURI.lastIndexOf("/");
	var path = fl.scriptURI.substring(0, index + 1);
	fl.runScript(path + "重命名库里的所有元件.jsfl");
	_temp.selectAll();
	_temp.clipCopy();
	fl.setActiveWindow(_doc);
	_doc.clipPaste();
	fl.closeDocument(_temp, false);
	fl.trace("完成");
}else if(sel.length == 0){
	alert("没有选中任何元件");
}else{
	alert("maybe未打开文档");
}

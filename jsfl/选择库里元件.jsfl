var doc = fl.getDocumentDOM()
var sel = doc.selection;
var s = "", js = "", n = 0;
if(sel.length){
	fl.trace("你选择了" + sel.length + "个元件");
	doc.library.selectNone();
	for(var i in sel){
		if(sel[i].libraryItem){
			n++;
			s = sel[i].libraryItem.name;
			js = s.substr(0, s.indexOf("/"));
			doc.library.expandFolder(true, true, js);
			doc.library.selectItem(s, false);
		}
	}
	if(n == sel.length){
		fl.trace("库里选中了" + n + "个元件");
	}else{
		fl.trace("" + Number(sel.length - n) + "个元件在库里没对应元件");
	}
}else if(sel.length == 0){
	alert("没有选中任何元件");
}else{
	alert("maybe未打开文档");
}
var folderURI = fl.browseForFolderURL("请选择家具文件所在文件夹");
var fileMask = "*.fla";
var fileList = FLfile.listFolder(folderURI + "/" + fileMask, "files");
var prefix = "mmo.ride.hcpeticon.";
var materialNoList = new Array();
var subName;
if(folderURI != null) 
{
	for(var i=0;i<fileList.length;i++)
	{
		var doc = fl.openDocument(folderURI + "/" + fileList[i]);
		subName = fileList[i].substr(0,fileList[i].length-4);
		getAllSelect();
		fl.closeDocument(doc,false);
	}
}

function getAllSelect()
{
	selectItem();
	var lib = doc.library;
	var selItems = lib.getSelectedItems();
	var sName;
	for (var i = 0; i < selItems.length; i++)
	{
		selItems[i].linkageExportForAS = true;
		// 将库项目的基类设置为"MovieClip"
		selItems[i].linkageBaseClass = "";
		selItems[i].linkageExportInFirstFrame = true;
		selItems[i].linkageClassName = prefix + subName;
		fl.trace("元件 " + selItems[i].name + " 加上绑定类:  " + "\"" +prefix + subName +"\"");
	}
	if(selItems.length > 0)
	{
		doc.deleteSelection();
		doc.selectNone();
		doc.saveAndCompact(); //保存并压缩文件；等效于选择"文件">"保存并压缩"。
	}
	else
	{
		fl.trace("执行失败：你还没有选择库里面的一个或多个元件");
	}
}


function selectItem()
{
	var doc = fl.getDocumentDOM();
	doc.selectAll();
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
}



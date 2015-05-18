var doc = fl.getDocumentDOM();
doc.selectAll();
var sel = doc.selection;
var lib = doc.library;
var n=0;
var prefix = "mmo.npc.icon.";
var subName =  prompt("输入Npc名字", "");
lib.selectNone();
for(var i in sel){
	if(sel[i].libraryItem){
		n++;
		s = sel[i].libraryItem.name;
		js = s.substr(0, s.indexOf("/"));
		doc.library.expandFolder(true, true, js);
		doc.library.selectItem(s, false);
	}
}
if(subName != "" && subName != null)
{
	getAllSelect();
	var filePath = "file:///D|/vstsworkspace/mmo/source/assets/npc/icon/"+subName.toLowerCase()+".fla";
	fl.trace(filePath);
	doc.deleteSelection();
	if(fl.saveDocument(fl.getDocumentDOM(), filePath))
	{
		alert("文件成功已保存到"+filePath);
	}
}

function getAllSelect()
{

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
		doc.saveAndCompact(); //保存并压缩文件；等效于选择"文件">"保存并压缩"。
	}
	else
	{
		fl.trace("执行失败：你还没有选择库里面的一个或多个元件");
	}
}
var doc = fl.getDocumentDOM();
var prefix = "mmo.playereffect.effect.Effect";
doc.selectAll();
var sel = doc.selection;
var lib = doc.library;
lib.selectNone();
var subName =  prompt("输入魔石光效id", "");
for(var i in sel){
	if(sel[i].libraryItem){
		s = sel[i].libraryItem.name;
		js = s.substr(0, s.indexOf("/"));
		doc.library.expandFolder(true, true, js);
		doc.library.selectItem(s, false);
	}
}
if(subName != "" && sel != null)
{
	doc.library.moveToFolder("Effect");
	getAllSelect();
	doc.deleteSelection();
}

function getAllSelect()
{

	var selItems = lib.getSelectedItems();
	var sName;
	for (var i = 0; i < selItems.length; i++)
	{
		selItems[i].name = "Effect" + subName;
		selItems[i].linkageExportForAS = true;
		selItems[i].linkageBaseClass = "";
		selItems[i].linkageExportInFirstFrame = true;
		selItems[i].linkageClassName = prefix + subName;
		fl.trace("元件 " + selItems[i].name + " 加上绑定类:  " + "\"" +prefix + subName +"\"");
	}
}
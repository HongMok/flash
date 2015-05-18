/*作用：删除库中未使用的美术元件以减小fla文件的大小，
原理：
1、将所有带导出类的元件添加到舞台
2、复制舞台所有元件
3、删除库中所有元件
4、粘贴元件

注意：类似scene1.fla（场景上使用元件且有多层）的文件不能使用该脚本。
      文件越大脚本执行消耗的内存也越大，容易造成IDE崩溃。
      斟酌使用。

author:liyu*/

fl.trace("整理中……");

var curDoc = fl.getDocumentDOM();
var curLib = curDoc.library;
var myItems = curLib.items;
var path = curDoc.pathURI;
for(var i = 0;i < myItems.length;i++)
{
	if (myItems[i].itemType == "folder") continue;
	if (myItems[i].linkageExportForAS)
	{
		curLib.addItemToDocument({x:0, y:0}, myItems[i].name);
	}
}

curDoc.selectAll();
curDoc.clipCut();
curLib.selectAll();
curLib.deleteItem();
curDoc.clipPaste();
curDoc.deleteSelection();
curDoc.saveAndCompact();

//整理
/*curDoc = fl.getDocumentDOM();
curLib = curDoc.library;
myItems = curLib.items;
var folder = "art";
if(folder != null)
{
	if(!curLib.itemExists(folder))
	{
		curLib.newFolder(folder);
	}

	for(var i = 0;i < myItems.length;i++){
		if((myItems[i].itemType != "folder")&& myItems[i].name.indexOf("/") == -1 
			&& myItems[i].linkageClassName == null && myItems[i].linkageExportForAS == false)
		{
			curLib.moveToFolder(folder, myItems[i].name, false);	
		}
	}
}

curDoc.saveAndCompact();*/

fl.trace("整理完毕……");
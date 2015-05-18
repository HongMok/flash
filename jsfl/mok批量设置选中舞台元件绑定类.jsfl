/*
用法：
	1. 选中舞台任务图标（左到右）
	2. 运行命令
	3. 输入开始任务ID
*/


var startID = Number(prompt("开始任务ID:"));

//var itemPrefix = "TaskIcon";
//var clsPrefix = "mmo.makecloth.config.taskres.";

var itemPrefix = "AchiIcon";
var clsPrefix = "mmo.makecloth.config.achires.";

var doc = fl.getDocumentDOM();
doc.clipCopy();

//var tempFile = "file:///C:/Documents and Settings/moxiong/桌面/学习笔记/jsfl学习/copy2new" + pId + ".fla";
//var tempFile = "file:///D:/vstsworkspace/mmo/source/assets/makecloth/mctaskicon.fla";
var tempFile = "file:///D:/vstsworkspace/mmo/source/assets/makecloth/mcachievementicon.fla";

var newDoc;
if(fl.fileExists(tempFile))
{
	fl.trace("file exist");
	newDoc = fl.openDocument(tempFile);
}
else
{
	fl.trace("no file:" + tempFile);
	newDoc = fl.createDocument();
}


var lib = newDoc.library;
//lib.selectAll(true);
//lib.deleteItem();

newDoc.clipPaste();



newDoc.selectAll();
var selectArr = newDoc.selection;
var tempArr = new Array();
for(var i = 0;i < selectArr.length;i++)
{
		for(var j = i + 1;j < selectArr.length;j++)
		{
			if(selectArr[i].x > selectArr[j].x)
			{
				var temp = selectArr[i];
				selectArr[i] = selectArr[j];
				selectArr[j] = temp;
			}
		}
	tempArr.push(selectArr[i]);
}


for(var i = 0;i < tempArr.length;i++)
{
	newDoc.selectNone();
	var childName = itemPrefix + (startID + i);
	newDoc.selection = [tempArr[i]];
	newDoc.convertToSymbol("movie clip", childName, "bottom center");
	var index = lib.findItemIndex(childName);
	var item = lib.items[index];
	var clsName = clsPrefix + childName;
	setItemPro(item, childName, clsName);
}

newDoc.selectAll();
newDoc.deleteSelection();

newDoc.publish();
fl.saveDocument(newDoc, tempFile);
//fl.closeDocument(newDoc, false);

function setItemPro(item, thisItemName, itemCls)
{
	item.name = thisItemName;
	item.linkageExportForAS = true;
	item.linkageBaseClass = "";
	item.linkageExportInFirstFrame = true;
	item.linkageClassName = itemCls;
}
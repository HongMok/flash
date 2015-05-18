var doc = fl.getDocumentDOM();
var lib = doc.library;
var prefix = prompt("输入以.结尾的类路径前缀;为空代表删除绑定类", "mmo.");
if(prefix == null)
{
}
else if( prefix == "" || prefix == " ")
{
	clearSelect();
}
else
{
	getAllSelect();
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
		sName = selItems[i].name;
		var subName = sName.substr(sName.lastIndexOf("/")+1);
		selItems[i].linkageClassName = prefix + subName;
		fl.trace("元件 " + selItems[i].name + " 加上绑定类:  " + "\"" +prefix + subName +"\"");
	}
	if(selItems.length > 0)
	{
		lib.newFolder("tempFloder");
		lib.deleteItem("tempFloder");
	}
	else
	{
		fl.trace("执行失败：你还没有选择库里面的一个或多个元件");
	}
}
function clearSelect()
{
	var selItems = lib.getSelectedItems();
	var sName;
	for (var i = 0; i < selItems.length; i++)
	{
		if(selItems[i].linkageClassName && selItems[i].linkageExportForAS)
		{
			selItems[i].linkageClassName = "";
			selItems[i].linkageExportForAS = false;
			fl.trace("元件：" + selItems[i].name + " 的绑定类被删除了");
		}
	}
	if(selItems.length > 0)
	{
		lib.newFolder("tempFloder");
		lib.deleteItem("tempFloder");
	}
	else
	{
		fl.trace("执行失败：你还没有选择库里面的一个或多个元件");
	}
}
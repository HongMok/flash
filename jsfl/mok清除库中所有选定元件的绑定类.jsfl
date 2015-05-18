/*
	选中库元件，批量删除元件绑定类
*/

var doc = fl.getDocumentDOM();
var lib = doc.library;
var itemList = lib.getSelectedItems();
if(itemList.length == 0)
{
	alert("还没选择库元件！");
}
else
{
	var count = 0;
	for(var i = 0; i < itemList.length; i++)
	{
		if(itemList[i].linkageExportForAS)
		{
			itemList[i].linkageClassName = "";
			itemList[i].linkageExportForAS = false;
			count++;
		}
	}
	doc.publish();
	doc.save();
	alert("选中个数：" + itemList.length + ", 清理个数：" + count);
}

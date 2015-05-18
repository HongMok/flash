var doc = fl.getDocumentDOM();
doc.selectAll();
var sel = doc.selection;
var lib = doc.library;
var n=0;
var prefix = "mmo.avatar.skin.";
var clsNameArr = ["SkinButton","SkinMain","SkinRight","SkinFold"];
var skinId =  prompt("输入皮肤id", "");
doc.library.selectNone();
if(skinId != "" && skinId != null)
{
	getAllSelect();
	var filePath = "file:///D|/vstsworkspace/mmo/source/assets/avatar/skin/customskin"+skinId+".fla";
	fl.trace(filePath);
	if(fl.saveDocument(fl.getDocumentDOM(), filePath))
	{
		alert("文件成功已保存到"+filePath);
	}
}

function getAllSelect()
{
	
	var selItems;

	for (var i = 0; i < clsNameArr.length; i++)
	{
		doc.library.selectItem(clsNameArr[i], false);
		selItems = lib.getSelectedItems();
		selItems[0].linkageExportForAS = true;
		// 将库项目的基类设置为"MovieClip"
		selItems[0].linkageBaseClass = "";
		selItems[0].linkageExportInFirstFrame = true;
		selItems[0].linkageClassName = prefix + clsNameArr[i] + skinId;
		fl.trace("元件 " + selItems[0].name + " 加上绑定类:  " + "\"" +prefix + clsNameArr[i] + skinId +"\"");
		doc.library.selectNone();
	}
}
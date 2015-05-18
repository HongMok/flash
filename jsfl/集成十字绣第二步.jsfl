var saveURL = fl.browseForFolderURL("请选择保存位置。");
var fileList = FLfile.listFolder(saveURL, "files");

var doc = fl.getDocumentDOM();
var lib = fl.getDocumentDOM().library;


for(var i=0; i<fileList.length; i++)
{
	//fl.trace(saveURL + "/" + fileList[i]);
	doc.importFile(saveURL + "/" + fileList[i], true);
}
var itemArr = lib.items;
fl.trace(itemArr.length);
for(i=0; i<itemArr.length; i++)
{

	if(itemArr[i].name.substr(-3,3) == "png")
	{
		itemArr[i].name = itemArr[i].name.substr(0, itemArr[i].name.length-4);
		fl.trace(itemArr[i].name);

		// 将库项目的基类设置为"Sprite"

		// 将库项目的基类设置为该项目类型的默认值


		itemArr[i].linkageExportForAS = true;
		itemArr[i].linkageExportForRS = false;		

		itemArr[i].linkageClassName = "mmo.app.needlework.plandata." + itemArr[i].name;
		itemArr[i].linkageBaseClass= "";
		itemArr[i].linkageExportInFirstFrame = true;
		lib.moveToFolder("设计图数据", itemArr[i].name, false);
	}
}
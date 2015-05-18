var doc = fl.getDocumentDOM();
var lib = doc.library;
var id = String(prompt("输入骑宠的收集品id", ""));

if(id != "" && id != null)
{
	lib.selectItem("Animal569_Back");
	var item = lib.getSelectedItems()[0];
	fl.trace(item.name);
	var animalName = "Animal"+id+"_Back";
	item.name = animalName;
	item.linkageClassName = "mmo.altarpet.ride.RidePet"+id+"_Back";
	renameAnimal();


lib.selectItem("Animal569_Front");
var item = lib.getSelectedItems()[0];
	fl.trace(item.name);
	var animalName = "Animal"+id+"_Front";
	item.name = animalName;
	item.linkageClassName = "mmo.altarpet.ride.RidePet"+id+"_Front";

renameAnimal();
var filePath = "file:///D|/vstsworkspace/mmo/source/assets/altarpet/ride/pet"+id+".fla";
if(fl.saveDocument(fl.getDocumentDOM(), filePath))
{
	alert("文件成功已保存到"+filePath);
}
}




function renameAnimal()
{
	var doc = fl.getDocumentDOM();
var lib = doc.library;
var item = lib.getSelectedItems()[0];
if(item == null || item.itemType != "movie clip")
{
	alert("需要选择一个movie clip!");
}
else
{
	fl.trace("开始重命名["+item.name+"]每一帧的元件");
	
	//var folder = "art";
	var folder = "art_"+item.name;
	if(!lib.itemExists(folder))
	{
		lib.newFolder(folder);
	}

	lib.editItem(item.name);
	var timeline = doc.getTimeline();
	while(timeline.layers[0].layerType != "normal")
	{
		timeline.reorderLayer(0,timeline.layerCount-1,false);
	}
	timeline.selectAllFrames();
	timeline.setFrameProperty('name', '');
	for(var i = 0;i < timeline.frameCount;i++)
	{
		//timeline.setSelectedFrames(i,i,true);
		timeline.currentFrame = i;
		doc.selectAll();
		var myElement = doc.selection[0];
		if(myElement == null)
		{
			alert("第"+(i+1)+"帧是空帧");
		}
		else if(myElement.elementType == "instance") 
		{
			var libItem = myElement.libraryItem;
			var itemName = libItem.name;
			lib.selectItem(itemName);
			if(itemName.indexOf(folder) == -1)
			{
				var newName = item.name+"_"+i;
				//fl.trace((i+1)+":"+itemName+"-->"+folder+"/"+newName);
				lib.renameItem(newName);
				lib.moveToFolder(folder);
				if(item.linkageExportForAS)
				{
					libItem.linkageExportForAS = true;
					libItem.linkageExportInFirstFrame = true;
					libItem.linkageClassName = item.linkageClassName+"_"+i;
				}				
			}
			else
			{
				//alert("第"+(i+1)+"帧使用了重复元件："+itemName);
				fl.trace("第"+(i+1)+"帧使用了重复元件："+itemName);
			}
		}
		else
		{
			fl.trace("帧"+(i+1)+"的第一个元素不是元件");
		}
	}
	fl.trace("END**"+item.name+"**");
}




}




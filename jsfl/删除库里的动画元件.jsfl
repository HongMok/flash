var doc = fl.getDocumentDOM();
var lib = doc.library;
lib.selectAll();
fl.trace("111");
var selItems = lib.getSelectedItems();
var oldSel = [];
var index = 0;
for(i = selItems.length-1;i>=0;i--)
{
	if(selItems[i].itemType == "movie clip" || selItems[i].itemType == "graphic")
	{
		oldSel[index] = selItems[i].name;
		index ++;
	}
}
for(i = oldSel.length-1;i>=0;i--)
{
	lib.selectItem(oldSel[i]);
	lib.editItem();
	var timeline = doc.getTimeline();
	if(timeline.frameCount > 1)
	{
		fl.trace("删除元件" + oldSel[i].name + "中的动画");
		for(var j=0; j<timeline.layers.length; j++)
		{
			timeline.currentLayer = j; 
			timeline.removeFrames(1,timeline.frameCount);
		}
	}
	fl.getDocumentDOM().exitEditMode();
}

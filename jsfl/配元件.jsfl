var prefix = prompt("大神你取啥名？", "");
var doc = fl.getDocumentDOM();
var lib = doc.library;
doc.selectAll();
var selItems = doc.selection;

var oldSel = [];
for(i = 0;i<selItems.length;i++)
{
	oldSel[i] = selItems[i];
}
var index = 0;
doc.selectNone();


lib.addNewItem("movie clip" ,prefix)
lib.editItem(prefix)
var timeline = doc.getTimeline();
	timeline.convertToBlankKeyframes(0,oldSel.length);

	doc.exitEditMode();



sort(oldSel);



for(j = 0;j<oldSel.length;j++)
{
			
		doc.selection = [oldSel[j]];
		doc.clipCopy();
		lib.editItem(prefix)
		
		
		var timeline = doc.getTimeline();
	
		timeline.setSelectedFrames(j, j+1);
		doc.clipPaste();
		
		doc.exitEditMode();
		doc.selectNone();
}

function sort(selItem)
{
	for(i = 0;i < selItem.length - 1;i++)
	{
		for(j = i+1;j < selItem.length;j++)
		{
		    
		    if(selItem[i].x > selItem[j].x)
		    {
			var temp = selItem[j];
			selItem[j] = selItem[i];
			selItem[i] = temp;
			
		    }
		 

		}
	}
 }
	
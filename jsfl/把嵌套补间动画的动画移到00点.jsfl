var doc = fl.getDocumentDOM();
var selItems = fl.getDocumentDOM().selection;
var oldX,oldY;
var stageHeigth = doc.height;
var stageWidth = doc.width;
doc.selectNone();


for(i = selItems.length-1;i>=0;i--)
{
	selItems[i].selected = true;

	

	selItems[i] = normal(selItems[i]);
	
	selItems[i].selected = true;
	oldX = selItems[i].x
	oldY = selItems[i].y
	fl.getDocumentDOM().moveSelectionBy({x:-oldX, y:-oldY});
	
	fl.trace("X:"+oldX+"Y:"+oldY)


	fl.getDocumentDOM().enterEditMode('inPlace');
	var timeline = doc.getTimeline();
	var layer = timeline.layers;

	for(var m = 0;m<layer.length;m++)
	{
		layer[m].locked = true;
	}

	for(var m = 0;m<layer.length;m++)
	{
		layer[m].locked = false;
		timeline.setSelectedLayers(m);
		for(var k = 0;k<layer[m].frameCount;k++)
		{
			timeline.setSelectedFrames(k,k+1);
			if(k==layer[m].frames[k].startFrame)
			{
   				doc.selectAll();
				for(var j = doc.selection.length-1;j>=0;j--)
				{
				   var element = doc.selection[j];
				 
				  element.x +=oldX;
				  element.y +=oldY;
				}	
				doc.selectNone();
			}
		}
		layer[m].locked = true;
	}

	
	for(var m = 0;m<layer.length;m++)
	{
		layer[m].locked = false;
	}

//	for(var k=0;k<timeline.frameCount;k++)
//	{
//   	 	timeline.setSelectedFrames(k,k+1);
//   		doc.selectAll();
//		for(var j = doc.selection.length-1;j>=0;j--)
//		{
//		   var element = doc.selection[j];
//		   element.x +=oldX;
//		   element.y +=oldY;
//		}
//	}
fl.getDocumentDOM().exitEditMode();
selItems[i].selected = false;
}

function normal(item)
{
	var mat = item.matrix; 
	mat.a = 1;
	mat.d = 1;
	mat.b = 0;
	mat.c = 0;
	item.matrix = mat;
	return item;
}


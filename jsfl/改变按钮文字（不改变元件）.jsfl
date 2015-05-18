a();

function a()
{
var prefix = prompt("输入你要的文字", "");
if(prefix==null)
{
    return;
  
}


var doc = fl.getDocumentDOM();
var selItems = doc.selection;
var lib = doc.library;
var oldSel = [];

var strArr = prefix.split(",");
var curStr;

sort(selItems)
for(var l = 0;l<selItems.length;l++)
{
   curStr = getStr(strArr,l);
   doc.selectNone();
   doc.selection = [selItems[l]];	

   if( selItems[l].elementType=="shape"&&selItems[l].isGroup&&isOnlyGroup(selItems[l]))
   {
	selectGroup(selItems[l]);
   }
   else if(selItems[l].elementType == "instance")
   {
	selectInstance(selItems[l])
   }
   else if(selItems[l].elementType == "text")
  {
	doc.setElementTextAttr('alignment', 'center');

	selItems[l].setTextString(curStr);
	
   }
 }

function setMCName(curItem)
{
	
	doc.enterEditMode("inPlace");

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
		for(var i = 0;i<timeline.frameCount;i++)
		{
		
			doc.getTimeline().setSelectedFrames(i,i+1);
			if(i!=layer[m].frames[i].startFrame)
			{
				continue;
			}
			doc.selectAll();
			var sels = doc.selection;
		
				
				
			for(var j = 0;j<sels.length;j++)
			{
				doc.selectNone();
				doc.selection = [sels[j]];
				
				if( sels[j].elementType=="shape"&&sels[j].isGroup&&isOnlyGroup(sels[j]))
				{
					selectGroup(sels[j]);
				}
				else if(sels[j].elementType == "instance")
				{
					selectInstance(sels[j])
				}
				else if(sels[j].elementType == "text")
				{
					doc.setElementTextAttr('alignment', 'center');

					sels[j].setTextString(curStr);
					break;
				}
			}
				    
		
			doc.selectNone();
		}
	}
	doc.exitEditMode();
}

function sort(selItems)
{
	for(i=selItems.length-1; i>=1; i--)
	{
		p = 0;
		for(j=0; j<i; j++)
		{
			if(compare(selItems[j], selItems[j+1]))
			{
				temp = selItems[j];
				selItems[j] = selItems[j+1];
				selItems[j+1] = temp;
			}
		}
	}
 }
 function compare(a, b)
{
	if(Math.abs(a.y-b.y)>5)
	{
		return a.y>b.y
	}
	return a.x > b.x;	
}


 function selectInstance(instance)
 {
		setMCName(doc.selection[0]);
 }

function selectGroup(group)
 {
		doc.enterEditMode("inPlace");
		doc.selectAll();
		var groupSelItems = doc.selection;
		for(var k = 0;k<groupSelItems.length;k++)
		{
			doc.selectNone();
			doc.selection = [groupSelItems[k]];
			
			if( groupSelItems[k].elementType=="shape"&&groupSelItems[k].isGroup&&isOnlyGroup(groupSelItems[k]))
			{
				selectGroup(groupSelItems[k]);
			}
			else if(groupSelItems[k].elementType == "instance")
			{
				selectInstance(groupSelItems[k])
			}
			else if(groupSelItems[k].elementType == "text")
			{
				doc.setElementTextAttr('alignment', 'center');
				groupSelItems[k].setTextString(curStr);
				break;
			}	
		}
		doc.selectNone();
		doc.exitEditMode();
 }

function isOnlyGroup(shape)
{
  return !shape.isDrawingObject && !shape.isOvalObject&&!shape.isRectangleObject;
}

function getStr(arr,index)
{
     if(index>arr.length - 1)
	{
		return arr[arr.length - 1]
	}
	
		return arr[index];
	

	}
}




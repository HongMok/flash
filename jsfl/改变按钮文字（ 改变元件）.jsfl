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

   lib.selectItem(fl.getDocumentDOM().selection[0].libraryItem.name);
   lib.duplicateItem();
      var sName = lib.getSelectedItems()[0].name; 
   doc.swapElement(sName);
	

   setMCName(doc.selection[0]);
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
					sels[j].setTextString(curStr);
					break;
				}
			}
				    
		
			doc.selectNone();
		}
	}
	doc.exitEditMode();
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

 function selectInstance(instance)
 {
		lib.selectItem(doc.selection[0].libraryItem.name);
		 lib.duplicateItem();
		var sName = lib.getSelectedItems()[0].name; 
		doc.swapElement(sName);
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




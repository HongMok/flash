a();
function a()
{
var prefix = prompt("Enter a prefix", "");
if(prefix==null)
{
    return;
  
}
else if(prefix=="")
{
  var isNum = confirm ("ȷ��(������)ȡ��(����������)");
  if(isNum)
  {
       prefix = "0,1,2,3,4,5,6,7,8,9";
  }
  else
  {
       prefix = "��,һ,��,��,��,��,��,��,��,��";
  }
}

var strArr = prefix.split(",");


var doc = fl.getDocumentDOM();
newMc = doc.convertToSymbol("movie clip", "", "top left"); 
doc.enterEditMode('inPlace');
for(i = 1;i<strArr.length;i++)
{
    doc.getTimeline().insertKeyframe(i);
}


for(i = 0;i<strArr.length;i++)
{
    doc.getTimeline().setSelectedFrames(i,i+1);
    doc.selectAll();
    doc.setTextSelection(0, 100);
    
    doc.setTextString(String(strArr[i]));
    doc.selectNone();
 }

}


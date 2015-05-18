
var preName = prompt("请输入重命名前缀", "haomovieclip_");
var items = fl.getDocumentDOM().library.getSelectedItems();
for(var i=0; i<items.length; i++)
{
	items[i].name = preName + i;
}
	
	

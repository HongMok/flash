var doc = fl.getDocumentDOM();
var lib = doc.library;
var selItems = lib.items
var index = 0;
var prefix = Math.round(Math.random() * 65535);
for(i = selItems.length-1;i>=0;i--)
{
	var item = selItems[i];
	item.name = item.name + "_" + prefix;
}

//功能：搜索库里含有指定字符串的元件(可能多个)，并选中
//主要用于，知道元件名字(或部分)，想在库里找出来，但库里元件比较多的情况
//有问题或发现有bug或有改进意见，可以联系我——张劲锋

var findName = prompt("输入元件名字:");
if(findName != "" && findName != null){
	var toLowerCase = confirm("不区分大小写？");
	var itemNameAry = findLibItem(findName, toLowerCase);
	fl.trace("搜索条件:" + (toLowerCase?"不区分大小写":"区分大小写") + "搜索“" + findName + "”;");
	if(itemNameAry.length > 0){
		fl.trace("找到" + itemNameAry.length + "个元件(已在库里选定):\n" + itemNameAry.join("\n"));
	}else{
		fl.trace("找不到元件!");
	}
}

function findLibItem(findName, toLowerCase){
	var itemNameAry = [];
	var doc = fl.getDocumentDOM();
	doc.library.selectNone();
	var items = doc.library.items;
	for(var i in items){
		if(items[i].itemType == "folder"){
			continue;
		}
		var itemFullName = items[i].name;
		
		var firstFoldName = itemFullName.substr(0, itemFullName.indexOf("/"));
		var indexOfPI = itemFullName.lastIndexOf("/");
		var itemName = itemFullName;
		if(indexOfPI != -1){
			itemName = itemFullName.substr(indexOfPI + 1, itemFullName.length);
		}
		
		if(checkSameName(itemName, findName, toLowerCase)){
			itemNameAry.push(itemFullName);
			doc.library.expandFolder(true, true, firstFoldName);
			doc.library.selectItem(itemFullName, false);
		}
	}
	return itemNameAry;
}

function checkSameName(name0, name1, toLowerCase){
	if(toLowerCase){
		return name0.toLowerCase().indexOf(name1.toLowerCase()) != -1;
	}else{
		return name0.indexOf(name1) != -1;
	}
}

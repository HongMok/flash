fl.outputPanel.clear();
main();

var doc;
var timeline;
var lib;
var faces;
var autoChange = false;
var commonDic;
var outputDic;
var $config;
function main(){
	fl.trace("\t警告");
	fl.trace("\t\t此工具会删除未使用元件，使用前请做好文件备份，防止误操作");
	fl.trace("\t功能");
	fl.trace("\t\t此工具找出未被使用的剪辑、按钮、图片。不包含声音、字体。未测试对上述以外格式对象的兼容性（比如视频）请慎用");
	fl.trace("\t原理");
	fl.trace("\t\t但凡出现在场景上的元件、有链接类名的元件，以及它们包含的所有元件是被使用的。");
	fl.trace("\t\t不满足上述条件的元件则被表示为未使用元件。");
	fl.trace("\t备注");
	fl.trace("\t\t此工具不会移除空文件夹");
	fl.trace("\t\t某些元件虽然库中显示使用次数不是0，但实际是被其它未被引用的元件使用着。");
	fl.trace("\t\t此工具使用标记法进行分析，能避免上述情况发生，因此看到库中引用次数非0元件被此工具标识出来并非错误");
	fl.trace("\t\t此工具计算出的元件数目已经舍去了文件夹，文件夹属于库项目但不属于元件，因此略小于系统给出的库项目数量并非错误");
	$config = {};
	
	$config.includeScene = confirm("主时间轴上的元件算作被使用的吗？");
	$config.deleteItem = confirm("是否在分析完毕后删除未使用的元件？");
	if($config.deleteItem){
		$config.deleteItem = confirm("警告！点击确定后将会删除所有未使用元件\n请确定这些元件是否真的已经没用了，并做好备份工作！");
	}
	
	faces = {};
	log = {};
	log2 = {};
	outputDic = {};
	
	
	doc = fl.getDocumentDOM();
	if(!doc){
		alert("错误，文档尚未打开");
		return -1;
	}
	
	lib = doc.library;
	
	if($config.includeScene){
		var scene_len = doc.timelines.length;
		for(var i = 0;i<scene_len;i++){
			iden(doc.timelines[i],"【场景】"+doc.timelines[i].name);
		}
	}
	
	var len = lib.items.length;
	for(var i = 0;i<len;i++){
		var item = lib.items[i];
		if(!item.linkageClassName){
			continue;
		}

		if(item.itemType == "movie clip"||item.itemType == "button"||item.itemType == "graphic"){
			iden(item.timeline,item.name);
		}
	}
	if($config.includeScene){
		fl.trace("\t-未使用的素材如下(已经计算了场景时间轴上的元件)");
	}else{
		fl.trace("\t-未使用的素材如下(没有计算场景时间轴上的元件)");
	}
	fl.trace("=====================================================");
	var numOutputs = 0;
	var numTotal = 0;
	var arr = [];
	arr = lib.items.concat();
	for(var i = 0;i<len;i++){
		var item = arr[i];
		if(item.itemType == "movie clip"||item.itemType == "button"||item.itemType == "graphic"||item.itemType == "bitmap"){
			numTotal++;
			if(!item.linkageClassName && !outputDic[item.name]){
				numOutputs++;
				fl.trace(item.name);
				if($config.deleteItem){
					lib.deleteItem(item.name);
				}
			}
		}
	}

	fl.trace("\t-无效单位共计"+numOutputs+"/"+numTotal+"个");
}

function iden(timeline, itemName){
	outputDic[itemName] = true;
	if(!timeline){
		return;//对象是位图会没有时间轴
	}
	var len_l = timeline.layers.length;
	
	for(var l = 0;l<len_l;l++){
		var layer = timeline.layers[l];
		var len_f = timeline.frameCount;
		for(var f = 0;f<len_f;f++){
			var frame = timeline.layers[l].frames[f];
			if(!frame){
				//只发生在图层是文件夹、特殊操作删除了全部帧等情况
				continue;
			}
			var len_e = frame.elements.length;
			for(var e = 0;e<len_e;e++){
				var elem = frame.elements[e];
				switch(elem.elementType){
					case "shape":
						if(elem.isGroup){
							idenGroup(elem, itemName);
						}else{
							for each(var tContour in elem.contours)
							{
								var tFill=tContour.fill;
								if(tFill.style=="bitmap"){
									outputDic[tFill.bitmapPath] = true;
                				}
        					}
						}
						break;
					case "instance":
						if(!outputDic[elem.libraryItem.name] && !elem.libraryItem.linkageClassName){
							iden(elem.libraryItem.timeline, elem.libraryItem.name);
						}
						break;
					default:
						//如果出现视频、组件之类将会出现在这，不过一般不会出现
						break
				}
			}
		}
		
	}
	return ;
}

function idenGroup(elem, itemName){
	var len_m = elem.members.length;
	for(var m = 0;m<len_m;m++){
		var mem = elem.members[m];
		switch(mem.elementType){
			case "shape":
				if(mem.isGroup){
					idenGroup(mem,itemName);
				}else{
					for each(var tContour in mem.contours)
					{
						var tFill=tContour.fill;
						if(tFill.style=="bitmap") {
							outputDic[tFill.bitmapPath] = true;
                		}
        			}
				}

				break;
			case "instance":
				if(!outputDic[mem.libraryItem.name] && !mem.libraryItem.linkageClassName){
					iden(mem.libraryItem.timeline, mem.libraryItem.name);
				}
				break;
			default:
				//如果出现视频、组件之类将会出现在这，不过一般不会出现
				break
		}
	}
	return;
}
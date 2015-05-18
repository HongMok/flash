//默认运行参数——是否删除原来的图层，位图临时文件存放处，开始帧, [结束帧](含)
var defaultArgs = "false,file:///D|/tem/,0";

var deleteOtherLayer;//是否删除原来的图层
var exprotBitmapTemFold;//临时文件夹
var needChangFrameAry = [];

var bitmapPath = [];//位图文件临时存放地址
var allRec = [];//元件位置
var hadKeyFrame = [];//是否有关键帧

main();

function main(args){
	var document = fl.getDocumentDOM();
	if(checkArgs(args, document) == false){
		return;
	}
	changeTimeLineItemAsBitmap(document);
}

function checkArgs(args, document){
	if(args == null){
		args = prompt("参数(删除原来,临时文件,开始帧[结束帧]):", defaultArgs);
		if(args == null){
			return false;
		}
	}
	
	argAry = args.split(",");
	deleteOtherLayer = Boolean(argAry[0] == "true");
	exprotBitmapTemFold = argAry[1];
	needChangFrameAry = [Number(argAry[2]), Number(argAry[3])];
	if(isNaN(needChangFrameAry[1])){
		needChangFrameAry[1] = Number(document.getTimeline().frameCount - 1);
	}
	return true;
}

function changeTimeLineItemAsBitmap(document){
	if(checkBlankFrame(document)){
		alert("所有帧都是空的，操作结束。");
		return;
	}
	
	checkSameFrames(document);
	
	var timeline = document.getTimeline();
	
	
	for(var i = needChangFrameAry[0];i <= needChangFrameAry[1];i++){
		if(bitmapPath[i] == ""){
			continue;
		}
		if(hadKeyFrame[i] == true || (i != 0 && bitmapPath[i - 1] == null)){
			//clearDocument(temDocument);
			var temDocument = fl.createDocument();//新建临时文件
			copyFrame(timeline, temDocument.getTimeline(), i);//把当前帧拷过去
			
			exprotBitMap(temDocument, i);//有关键帧的就导出位图
			temDocument.close(false);//关闭临时文件
		}else{
			bitmapPath[i] = bitmapPath[i - 1];//全部图层都不是关键帧的，用前一帧的位图
		}
	}
	
	rememberRec(document);//记住所有元件的位置，用于位图定位
	importBitmap(document);//导入位图，并定位
}

function checkBlankFrame(document){
	var allBlank = true;
	var timeline = document.getTimeline();
	for(var i = needChangFrameAry[0];i <= needChangFrameAry[1];i++){
		timeline.currentFrame = i;
		document.selectAll();
		if(document.getSelectionRect() == 0){
			bitmapPath[i] = "";
		}else{
			allBlank = false;
		}
	}
	return allBlank;
}

//记住当前位置
function rememberRec(document){
	var timeline = document.getTimeline();
	allRec = [];
	for(var i = needChangFrameAry[0];i <= needChangFrameAry[1];i++){
		timeline.currentFrame = i;
		document.selectAll();
		allRec[i] = document.getSelectionRect();
	}
}

//检查相同帧
function checkSameFrames(document){
	var timeline = document.getTimeline();
	hadKeyFrame = [];
	for(var i = needChangFrameAry[0];i <= needChangFrameAry[1];i++){
		hadKeyFrame[i] = false;
		for(var j = 0;j < timeline.layerCount;j++){
			if(timeline.layers[j].frames[i].startFrame == i){
				hadKeyFrame[i] = true;
				break;
			}
		}
	}
}

//导入位图，并定位
function importBitmap(document){
	var timeline = document.getTimeline();
	
	timeline.setSelectedLayers(0);//选中最上面的图层
	timeline.addNewLayer("位图层");//在最上面新建一个图层
	timeline.convertToBlankKeyframes(0, timeline.frameCount);//把第一层全转成关键帧
	
	//==导入bitmap到第一层==
	frames = timeline.layers[0].frames;
	for(var i = needChangFrameAry[0];i <= needChangFrameAry[1];i++){
		timeline.setSelectedLayers(0);//选中最上面的图层
		timeline.currentFrame = i;
		if(bitmapPath[i] == ""){
			//空白帧且前面也是空白帧，则清空
			if(i != 0 && bitmapPath[i - 1] == ""){
				timeline.clearKeyframes(i);
			}
		}else if(hadKeyFrame[i] == true || (i != 0 && bitmapPath[i - 1] == null)){
			//关键帧 或 前面那帧不需要转位图，则这帧导入位图
			document.importFile(bitmapPath[i], false);
			setLinkClass(bitmapPath[i],bitmapPath[i])
			frames[i].elements[0].scaleX = 0.83;
			frames[i].elements[0].scaleY = 0.83;
			frames[i].elements[0].x = allRec[i].left;
			frames[i].elements[0].y = allRec[i].top;
		}else{
			timeline.clearKeyframes(i);
		}
	}
	
	if(deleteOtherLayer == true){
		deleteAllLayerExceptTop(timeline);//删除所有图层(除了第一层)
	}
}


function deleteAllLayerExceptTop(timeline){
	while(timeline.layerCount > 1){
		timeline.deleteLayer(1);	
	}
}

function clearAllLayer(timeline){
	for(var i = 0;i < timeline.layerCount;i++){
		timeline.setSelectedLayers(i, true);
		timeline.clearFrames(0);	
	}
}

//导出位图
function exprotBitMap(temDocument, index){	
	temDocument.selectAll();
	scale120(temDocument)
	
	var rec = temDocument.getSelectionRect();
	
	if(rec == 0){
		return;
	}
	
	moveToTopleft(temDocument, rec);
	
	temDocument.width = Math.ceil(rec.right - rec.left);
	temDocument.height =  Math.ceil(rec.bottom - rec.top);
	
	bitmapPath[index] = getRandomFileName();
	
	temDocument.exportPNG(bitmapPath[index], true, false);
}

function getRandomFileName(){
	return exprotBitmapTemFold + "AsBitmap" + new Date().valueOf() + ".png";
}

function moveToTopleft(temDocument, rec){
	for(var i = 0;i < temDocument.selection.length;i++){
		 temDocument.selection[i].x -= rec.left;
		 temDocument.selection[i].y -= rec.top;
	}
}

function scale120(temDocument){
	temDocument.transformSelection(1.2, 0, 0, 1.2);
}

function copyFrame(fromTimeline, toTimeline, frame){
	for(var i = 0;i < fromTimeline.layerCount;i++){
		fromTimeline.setSelectedLayers(i, true);
		fromTimeline.copyFrames(frame);
		toTimeline.addNewLayer("新图层", "normal", false);
		toTimeline.setSelectedFrames(0,0);
		toTimeline.pasteFrames();
	}
}

//在范围内，或只转一帧
function isNeedCacheFrame(frame){
	return (frame >= needChangFrameAry[0] && frame < needChangFrameAry[1])
		|| (frame == needChangFrameAry[0] && frame == needChangFrameAry[1]);
}

function clearDocument(document){
	var timeline = document.getTimeline();
	clearAllLayer(timeline);
	//timeline.setSelectedLayers(0);//选中最上面的图层
	//deleteAllLayerExceptTop(timeline);//删除其他帧
	
	//删除库里元件
	document.library.selectAll();
	document.library.deleteItem();
}

function setLinkClass(pngName,className)
{
    var lib = fl.getDocumentDOM().library;
    lib.selectItem(pngName);
    lib.setItemProperty('linkageExportForAS', true);
    lib.setItemProperty('linkageExportInFirstFrame', true);
    lib.setItemProperty('linkageClassName', className);
    lib.selectNone();

}
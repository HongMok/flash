/*
	选中n帧，输入帧标签前缀，和开始下标，自动生成系列帧标签
*/
var labelPrefix = prompt("帧标签前缀：", "label");
var labelStartIndex = Number(prompt("开始下标: " , 0));

var sel = fl.getDocumentDOM().getTimeline().getSelectedFrames();
var layerIndex = Number(sel[0]);
var startIndex = Number(sel[1]);
var endIndex = Number(sel[2]);
fl.trace("选中第 " + sel[0] + " 层，" + (startIndex+1) + " 至 " + endIndex + " 帧");

var layerList = fl.getDocumentDOM().getTimeline().layers;

var count = 0;
	for(var i = startIndex; i < endIndex; i++)
	{
		layerList[layerIndex].frames[i].name = labelPrefix + (labelStartIndex++);
		count++;
	}
	alert("共处理：" + count);
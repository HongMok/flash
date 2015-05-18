var namePre = prompt("请输入名字", "hao");
var timeline = fl.getDocumentDOM().getTimeline(); 
var currentLayers = timeline.layers;
var layer = currentLayers[0];
var allFrames = layer.frames;
//fl.trace("all="+allFrames.length);
var index = 0;
for(var i=0; i<allFrames.length; i++)
{
	var frame = allFrames[i];
	if(frame.startFrame == i)
	{
		//fl.trace("关键帧="+i);
		frame.name = namePre+""+index;
		index ++;		
	}	
}
	

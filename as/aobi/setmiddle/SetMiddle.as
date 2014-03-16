package aobi.setmiddle
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;

	public class SetMiddle extends MovieClip
	{
		public function SetMiddle()
		{
			var mcParent:MovieClip = this.getChildByName("_mcFarther") as MovieClip;
			
			var mcSon:MovieClip = new MCSon() as MovieClip;
			setMiddle(mcSon, mcParent);
		}
		
		
		private function setMiddle(view:DisplayObject, container:DisplayObjectContainer, scale:Number = 1):void
		{
			var conWidth:Number = container.width;
			var conHeight:Number = container.height;
			
			view.scaleX = scale;
			view.scaleY = scale;
			
			
			var conRec:Rectangle = container.getRect(container.parent);
			var conOffsetX:Number = container.x - conRec.left;
			var conOffsetY:Number = container.y - conRec.top;
			
			
			container.addChild(view);
			
			
			var viewRec:Rectangle = view.getRect(view.parent);
			var viewOffsetX:Number = view.x - viewRec.left;
			var viewOffsetY:Number = view.y - viewRec.top;
			
			
			view.x = (conWidth - view.width) / 2 - conOffsetX + viewOffsetX;
			view.y = (conHeight - view.height) / 2 - conOffsetY + viewOffsetY;
			
			
			
		}
	}
}
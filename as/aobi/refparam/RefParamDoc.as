package aobi.refparam
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class RefParamDoc extends MovieClip
	{
		//mc
		private var itemList:Array = [];
		
		//data
		private var srcData:Array = [0];
		
		
		public function RefParamDoc()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onATS);
		}
		
		protected function onATS(event:Event):void
		{
			// TODO Auto-generated method stub
			this.removeEventListener(Event.ADDED_TO_STAGE, onATS);
			
			init();
		}
		
		private function init():void
		{
			// TODO Auto Generated method stub
			getMC();
		}
		
		private function getMC():void
		{
			// TODO Auto Generated method stub
			for(var i:int = 0; i < 2; i++)
			{
				itemList[i] = this.getChildByName("item" + i) as RPItem;
				RPItem(itemList[i]).setData(i, srcData, callBack);
			}
		}
		
		private function callBack(params:Object):void
		{
			// TODO Auto Generated method stub
			var clkIndex:int = params["index"];
			RPItem(itemList[clkIndex]).refreshData(srcData);
		}
		
	}
}
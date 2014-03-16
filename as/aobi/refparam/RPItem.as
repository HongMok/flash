package aobi.refparam
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class RPItem extends MovieClip
	{
		//mc
		private var txtNum:TextField;
		private var btnInc:SimpleButton;
		private var btnInc2:SimpleButton;
		
		//data
		private var index:int;
		private var defData:Array;
		
		private var callBack:Function;
		
		
		public function RPItem()
		{
			
			getMC();
		}
		
		private function getMC():void
		{
			// TODO Auto Generated method stub
			txtNum = this.getChildByName("_txtNum") as TextField;
			btnInc = this.getChildByName("_btnInc") as SimpleButton;
			btnInc.addEventListener(MouseEvent.CLICK, onClick);
			
			btnInc2 = this.getChildByName("_btnInc2") as SimpleButton;
			btnInc2.addEventListener(MouseEvent.CLICK, onClick2);
		}
		
		protected function onClick2(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(callBack != null)
			{
				callBack.apply(null, [{"index":index}]);
			}
		}
		
		public function setData(ind:int, val:Array, cb:Function = null):void
		{
			index = ind;
			callBack = cb;
			refreshData(val);
		}
			
			
		
		protected function onClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			defData[0]++;
			refreshData(defData);
		}
		
		public function refreshData(val:Array):void
		{
			// TODO Auto Generated method stub
			defData = val;
			txtNum.text = String(defData[0]);
		}
		
	}
}
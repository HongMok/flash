package aobi.IncDec
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.text.TextField;
	

	public class TestIncDec extends MovieClip
	{
		//mc
		private var _txtNum:TextField;
		private var _btnInc:SimpleButton;
		private var _btnDec:SimpleButton;
		private var _txtOutput:TextField;
		
		
		
		//temp
		private var idHelper:IncDec;
		
		
		
		public function TestIncDec()
		{
			init();
		}
		
		//ops
		private function init():void
		{
			getMC();
			
			idHelper = new IncDec(_txtNum, _btnInc, _btnDec, 0, 100, 1);
			
//			idHelper.changeVal(0);
			idHelper.addEventListener(IncDec.CHANGE_VAL, onChangeVal);
		}
		
		
		//mc
		private function getMC():void
		{
			_txtNum = getChildByName("txtNum") as TextField;
			_btnInc = getChildByName("btnInc") as SimpleButton;
			_btnDec = getChildByName("btnDec") as SimpleButton;
			_txtOutput = getChildByName("txtOutput") as TextField;
		}
		
		
		//listeners
		private function onChangeVal(evt:Event):void
		{
			_txtOutput.text = String(idHelper.iVal * 2);
		}
		
		
	}
}
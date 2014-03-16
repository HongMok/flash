package aobi.IncDec
{
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	

	public class IncDec extends EventDispatcher
	{
		//mc
		private var _btnInc:SimpleButton;
		private var _btnDec:SimpleButton;
		private var _txtVal:TextField;
		
		
		//param
		private var _iVal:int;
		private var _iMin:int;
		private var _iMax:int;
		private var _iStep:int;   //递增递减的步长，为1时可输入
		private var _iSpeed:int;  //长按鼠标改变速度，多少帧改变一次
		private var _iSpeed0:int;
		
		private var _iTimeCounter:int = 0;
		
		
		
		
		//const
		public static const CHANGE_VAL:String = "CHANGE_VAL";
		private static const MIN_SPEED:int = 1;
		private static const INC_SPEED_OFFSET:int = 5;
		
		/**
		 * 
		 * @param txtNum 数字文本
		 * @param btnInc 递增按钮
		 * @param btnDec 递减按钮
		 * @param iMin 区间最小值
		 * @param iMax 区间最大值
		 * @param iStep 递增递减步长
		 * @param speed 递增递减速度
		 * 
		 */
		public function IncDec(txtNum:TextField, btnInc:SimpleButton, btnDec:SimpleButton, iMin:int, iMax:int, iStep:int = 1, speed:int = 5)
		{
			_txtVal = txtNum;
			_btnInc = btnInc;
			_btnDec = btnDec;
			_iMin = iMin;
			_iMax = iMax;
			_iStep = iStep;
			_iSpeed0 = _iSpeed = speed;
			
			changeVal(_iMin);
			
			addListeners();
		}
		
		
		//ops

		public function get iVal():int
		{
			return _iVal;
		}

		private function changeVal(val:int):void
		{
			_iVal = val;
			_txtVal.text = _iVal.toString();
			
			dispatchEvent(new Event(CHANGE_VAL));
		}
		private function initSpeed():void
		{
			_iSpeed = _iSpeed0;
			_iTimeCounter = 0;
		}
		
		
		//listeners
		private function addListeners():void
		{
			_btnInc.addEventListener(MouseEvent.CLICK, onClickInc);
			_btnDec.addEventListener(MouseEvent.CLICK, onClickDec);
			
			_btnInc.addEventListener(MouseEvent.MOUSE_DOWN, onMDInc);
			_btnInc.addEventListener(MouseEvent.MOUSE_UP, onMUInc);
			
			_btnDec.addEventListener(MouseEvent.MOUSE_DOWN, onMDDec);
			_btnDec.addEventListener(MouseEvent.MOUSE_UP, onMUDec);
			
			if(_iStep == 1)
			{
				_txtVal.addEventListener(Event.CHANGE, onIPVal);
			}
			else
			{
				//禁止输入
			}
		}
		private function onClickInc(evt:MouseEvent):void
		{
			if(_iVal + _iStep <= _iMax)
			{
				changeVal(_iVal + _iStep);
			}
		}
		private function onClickDec(evt:MouseEvent):void
		{
			if(_iVal - _iStep >= _iMin)
			{
				changeVal(_iVal - _iStep);
			}
		}
		
		//inc
		private function onMDInc(evt:MouseEvent):void
		{
			_btnInc.addEventListener(Event.ENTER_FRAME, onEFInc);
		}
		private function onMUInc(evt:MouseEvent):void
		{
			initSpeed();
			_btnInc.removeEventListener(Event.ENTER_FRAME, onEFInc);
		}
		private function onEFInc(evt:Event):void
		{
			_iTimeCounter++;
			if(_iTimeCounter % _iSpeed == 0)
			{
				if(_iTimeCounter / 25 == INC_SPEED_OFFSET && _iSpeed >= MIN_SPEED)
				{
					_iSpeed--;
					_iTimeCounter = 0;
				}
				
				onClickInc(null);
			}
		}
		//dec
		private function onMDDec(evt:MouseEvent):void
		{
			_btnDec.addEventListener(Event.ENTER_FRAME, onEFDec);
		}
		private function onMUDec(evt:MouseEvent):void
		{
			initSpeed();
			_btnDec.removeEventListener(Event.ENTER_FRAME, onEFDec);
		}
		private function onEFDec(evt:Event):void
		{
			_iTimeCounter++;
			if(_iTimeCounter == _iSpeed)
			{
				_iTimeCounter = 0;
				onClickDec(null);
			}
		}
		
		//txt
		private function onIPVal(evt:Event):void
		{
			var iTemp:int = int(_txtVal.text);
			if(iTemp < _iMin)
				iTemp = _iMin;
			if(iTemp > _iMax)
				iTemp = _iMax;
			
			trace("input val: " + iTemp);
			
			changeVal(iTemp);
		}
		
	}
}
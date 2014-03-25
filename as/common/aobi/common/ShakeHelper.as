package aobi.common
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class ShakeHelper
	{
		public function ShakeHelper()
		{
		}
		
		//==============================================================
		//==============================================================
		private static var _shake_init_x:Number;
		private static var _shake_init_y:Number;
		private static var _target:DisplayObject;
		private static var _maxDis:Number;
		private static var _count:int = 0;
		private static var _rate:Number;
		
		private static var _nextFunc:Function;
		/**
		 * 震动显示对象
		 * @param        target                震动目标对象
		 * @param        time                        震动持续时长（秒）
		 * @param        rate                        震动频率(一秒震动多少次)
		 * @param        maxDis        震动最大距离
		 */
		public static function shakeObj(target:DisplayObject , time:Number ,rate:Number, maxDis:Number, nextFunc:Function):void
		{
			_target                         = target;
			_shake_init_x         = target.x;
			_shake_init_y         = target.y;
			_maxDis                         = maxDis;
			_count                                 = time * rate;
			_rate                                 = rate;
			_nextFunc = nextFunc;
			
			var timer:Timer = new Timer(1000 / rate, _count );
			timer.addEventListener(TimerEvent.TIMER, shaking);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, shakeComplete);
			timer.start();
		}
		
		static private function shaking(e:TimerEvent):void 
		{
			TweenLite.killTweensOf(_target);
			_target.x         = _shake_init_x + ( - _maxDis ) + Math.random() * 2 * _maxDis;
			_target.y        = _shake_init_y +( - _maxDis ) + Math.random() * 2 * _maxDis;
			TweenLite.to( _target,999 / _rate, { x : _shake_init_x, y:_shake_init_y } );
		}
		
		static private function shakeComplete(e:TimerEvent):void 
		{
			TweenLite.killTweensOf(_target);
			_target.x         = _shake_init_x;
			_target.y         = _shake_init_y;
			
			if( _nextFunc != null )
			{
				_nextFunc.apply();
			}
		}
		//==============================================================
		//==============================================================
	}
}
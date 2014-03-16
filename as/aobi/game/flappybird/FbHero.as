package aobi.game.flappybird
{
	import com.greensock.TweenLite;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;

	public class FbHero
	{
		private var _view:MovieClip;
		
		private var v_speed:Number;
		
		private static const g0:Number = 1;   //重力加速度
		
		public var bmd:BitmapData;
		
		public function FbHero(view:MovieClip)
		{
			this._view = view;
			
			reset();
			
			bmd = new BitmapData(view.width, view.height, true, 0);
			bmd.draw(view);
		}
		
		public function reset():void
		{
			v_speed = 0;
		}
		
		public function get view():MovieClip
		{
			return _view;
		}

		public function loop():Boolean
		{
			if( !isFlying )
			{
				v_speed += g0;
				_view.y += v_speed;
			}
			
			
			return checkDie();
		}
		
		private var isFlying:Boolean = false;
		public function jump():void
		{
			FbSoundManager.instance.playSoundFly();
			if( _view.y < 0 )
			{
				return;
			}
			
			isFlying = true;
			TweenLite.to(_view, 0.1, {"y":_view.y - 30, "onComplete":function(){
				v_speed = 0;
				isFlying = false;
			}});
		}
		
		public function checkDie():Boolean
		{
			if( _view.y >= 363 )
			{
				return true;
			}
			else
			{
				return false;
			}
		}
	}
}
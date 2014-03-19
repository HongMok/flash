package aobi.game.flappybird
{
	import aobi.common.HitTest;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;

	public class FbCube
	{
		public static var MIN_HEIGHT:Number = 0.0;
		public static var MAX_HEIGHT:Number = 50.0;
		
		private var _view:Sprite;
		private var bm_view:Bitmap;
		
		private var mc_bg:MovieClip;
		private var mc_front:MovieClip;
		
		private var bmd_bg:BitmapData;
		private var bmd_front:BitmapData;
		
		private var bmd_view:BitmapData;
		
		private var _canBeRemoved:Boolean;
		
		private var _canCount:Boolean;
		
		public function FbCube()
		{
			init();
		}
		
		public function get view():Sprite
		{
			return _view;
		}

		private function init():void
		{
			_view = new Sprite();
			
			var cls:Class;
			cls = getDefinitionByName("aobi.game.flappybird.res.FbBg") as Class;
			mc_bg = new cls();
			cls = getDefinitionByName("aobi.game.flappybird.res.FbFront") as Class;
			mc_front = new cls();
			
			MAX_HEIGHT = mc_bg.height - mc_front.height;
			
			bmd_bg = new BitmapData(mc_front.width, mc_bg.height, true, 0);
			var mat:Matrix = new Matrix();
			mat.tx = ( mc_front.width - mc_bg.width ) / 2;
			bmd_bg.draw(mc_bg, mat);
			bmd_front = new BitmapData(mc_front.width, mc_front.height, true, 0);
			bmd_front.draw(mc_front);
			
			bmd_view = bmd_bg.clone();
			bm_view = new Bitmap(bmd_view);
			_view.addChild(bm_view);
			
			_canBeRemoved = false;
			_canCount = true;
		}
		
		public function setHeight(height:Number):void
		{
			bmd_view = bmd_bg.clone();
			
			bmd_view.copyPixels(bmd_front, bmd_front.rect, new Point(0, height));
			
			bm_view.bitmapData = bmd_view;
			
			_canBeRemoved = false;
			_canCount = true;
		}
		
		
		public function hitTestHero(hero:DisplayObject):Boolean
		{
			if( HitTest.complexHitTestObject(hero, this.view) )
			{
				return true;
			}
			else
			{
				if( this._canCount == true)
				{
					
					if( view.x + view.width + view.parent.x <= hero.x )
					{
						trace("pass one cube");
						FbSoundManager.instance.playSoundPass();
						FbCubePassCounter.instance.count++;
						_canCount = false;
					}
					
				}
				return false;
			}
		}
		
		public function setCanRemove(val:Boolean):void
		{
			_canBeRemoved = val;
		}
		
		public function getCanRemove():Boolean
		{
			return _canBeRemoved;
		}
		
		public function recycle():void
		{
			FbCubePool.instance.pushCube(this);
		}
		
		
		
		public function dispose():void
		{
			bmd_bg = null;
			bmd_front = null;
			bmd_view = null;
		}
	}
}
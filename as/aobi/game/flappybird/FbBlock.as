package aobi.game.flappybird
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class FbBlock extends Sprite
	{
		public static const BLOCK_SIZE:int = 3;
		
		public static const CUBE_OFFSET:Number = 100;
		
		private var cube_list:Array = [];
		
		private var _canBeRemoved:Boolean = false;
		
		public function FbBlock()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			for( var i:int = 0; i < BLOCK_SIZE; i++ )
			{
				cube_list[i] = FbCubePool.instance.popCube();
				this.addChild(cube_list[i].view);
				cube_list[i].view.x = ( cube_list[i].view.width + CUBE_OFFSET ) * i;
			}
			
			randHeight();
		}
		
		public function randHeight():void
		{
			var rand:Number;
			for( var i:int = 0; i < BLOCK_SIZE; i++ )
			{
				rand = calRandHeight();
				FbCube(cube_list[i]).setHeight(rand);
			}
			
			_canBeRemoved = false;
		}
		
		private function calRandHeight():Number
		{
			var min_h:Number = FbCube.MIN_HEIGHT + 20;
			var max_h:Number = FbCube.MAX_HEIGHT - 20;
			var rand:Number = Math.random() * ( max_h - min_h ) + min_h;
			return rand;
		}
		
		public function hitTestHero(hero:DisplayObject):Boolean
		{
			for( var i:int = 0; i < BLOCK_SIZE; i++ )
			{
				if( FbCube(cube_list[i]).hitTestHero(hero) == true )
				{
					return true;
				}
			}
			return false;
		}
		
		public function getCanRemove():Boolean
		{
			return _canBeRemoved;
		}
		
		public function move(tx:Number, ty:Number = 0):void
		{
			this.x += tx;
			
			_canBeRemoved = checkCanRemove();
		}
		
		private function checkCanRemove():Boolean
		{
			if( this.x < (0 - this.width))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public function recycle():void
		{
			if( this.parent != null )
			{
				this.parent.removeChild(this);
			}
			FbBlockPool.instance.pushBlock(this);
		}
		
		public function dispose():void
		{
			for( var i:int = 0; i < BLOCK_SIZE; i++ )
			{
				FbCube( cube_list[i] ).dispose();
			}
		}
	}
}
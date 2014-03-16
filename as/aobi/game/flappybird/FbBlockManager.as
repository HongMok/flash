package aobi.game.flappybird
{
	import flash.display.DisplayObjectContainer;

	public class FbBlockManager
	{
		private var curr_block_list:Array = [];
		
		private static const first_block_pos:Number = 600;
		
		private var stage:DisplayObjectContainer;
		
		public function FbBlockManager(stage:DisplayObjectContainer)
		{
			this.stage = stage;
		}
		
		public function loop(hero:FbHero):Boolean
		{
			loopCreate();
			
			loopMove();
			
			loopRemove();
			
			return loopHitTest(hero);
		}
		
		private function loopHitTest(hero:FbHero):Boolean
		{
			var block:FbBlock;
			for( var i:int = 0; i < curr_block_list.length; i++ )
			{
				block = curr_block_list[i];
				if( block.x > ( hero.view.x + hero.view.width ))
				{
					continue;
				}
				if( block.x + block.width + FbSpeedManager.instance.speed < hero.view.x )
				{
					continue ;
				}
				if( block.hitTestHero( hero.view) )
				{
					return true;
				}
			}
			return false;
		}
		
		private function loopCreate():void
		{
			if( curr_block_list.length > 2 )
			{
				return ;
			}
			
			var appendX:Number = 0;
			for( var i:int = 0; i < curr_block_list.length; i++ )
			{
				if( curr_block_list[i].x > appendX )
				{
					appendX = curr_block_list[i].x;
				}
			}
			
			var newBlock:FbBlock = FbBlockPool.instance.popBlock();
			newBlock.x = appendX + newBlock.width + FbBlock.CUBE_OFFSET;
			if( curr_block_list.length == 0 )
			{
				newBlock.x = first_block_pos;
			}
//			newBlock.y = 30;
			this.stage.addChild(newBlock);
			curr_block_list.push(newBlock);
		}
		
		private function loopMove():void
		{
			for( var i:int = 0; i < curr_block_list.length; i++ )
			{
				FbBlock( curr_block_list[i] ).move( - FbSpeedManager.instance.speed );
			}
		}
		
		private function loopRemove():void
		{
			for( var i:int = 0; i < curr_block_list.length; i++ )
			{
				if( FbBlock ( curr_block_list[i] ).getCanRemove() )
				{
					FbBlock( curr_block_list[i] ).recycle();
					
					curr_block_list.splice(i, 1);
					
					i--;
					
					trace("curr block size:" + curr_block_list.length);
				}
			}
		}
		
		public function dispose():void
		{
			for( var i:int = 0; i < curr_block_list.length; i++ )
			{
				FbBlock( curr_block_list[i] ).recycle();
				
				curr_block_list.splice(i, 1);
				
				i--;
			}
		}
	}
}
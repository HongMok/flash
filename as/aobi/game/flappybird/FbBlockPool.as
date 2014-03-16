package aobi.game.flappybird
{
	public class FbBlockPool
	{
		private var _pool:Array = [];
		
		private static var _instance:FbBlockPool;
		
		public function FbBlockPool()
		{
		}
		
		public static function get instance():FbBlockPool
		{
			if( _instance == null )
			{
				_instance = new FbBlockPool();
			}
			return _instance;
		}

		public function popBlock():FbBlock
		{
			if( null == _pool || _pool.length == 0)
			{
				_pool = [];
				_pool.push(new FbBlock());
			}
			
			var ret:FbBlock = _pool.pop();
			ret.randHeight();
			return ret;
		}
		
		public function pushBlock(block:FbBlock):void
		{
			_pool.push(block);
		}
		
		public function dispose():void
		{
			for( var i:int = 0; i < _pool.length; i++ )
			{
				FbBlock( _pool[i] ).dispose();
			}
			
			_pool = null;
		}
			

	}
}
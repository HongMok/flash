package aobi.game.flappybird
{
	public class FbCubePool
	{
		private var _pool:Array = [];
		
		private static var _instance:FbCubePool;
		
		public function FbCubePool()
		{
		}

		public static function get instance():FbCubePool
		{
			if( _instance == null )
			{
				_instance = new FbCubePool();
			}
			return _instance;
		}
		
		public function popCube(height:Number = 0.0):FbCube
		{
			if( _pool == null || _pool.length == 0 )
			{
				_pool = [];
				_pool.push( new FbCube() );
			}
			
			var ret:FbCube = _pool.pop();
			ret.setHeight(height);
			return ret;
		}
		
		public function pushCube(cube:FbCube):void
		{
			_pool.push(cube);
		}
		
		public function dispose():void
		{
			for( var i:int = 0; i < _pool.length; i++ )
			{
				FbCube( _pool[i] ).dispose();
			}
			_pool = null;
			_instance = null;
		}

	}
}
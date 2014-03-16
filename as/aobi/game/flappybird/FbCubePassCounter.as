package aobi.game.flappybird
{
	public class FbCubePassCounter
	{
		private static var _instance:FbCubePassCounter;
		
		private var _count:int;
		
		public function FbCubePassCounter()
		{
			_count = 0;
		}

		public function get count():int
		{
			return _count;
		}

		public function set count(value:int):void
		{
			_count = value;
		}

		public static function get instance():FbCubePassCounter
		{
			if( _instance == null )
			{
				_instance = new FbCubePassCounter();
			}
			return _instance;
		}
		
		public function dispose():void
		{
			_count = 0;
			_instance = null;
		}

	}
}
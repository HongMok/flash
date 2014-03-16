package aobi.game.flappybird
{
	public class FbSpeedManager
	{
		private static const MAX_SPEED:Number = 6;
		
		private static const SPEED0:Number = 3;
		
		private static const CHANGE_OFFSET:int = 25 * 30;
		
		private var _speed:Number;
		
		private var iCount:int;
		
		private static var _instance:FbSpeedManager;
		
		public function FbSpeedManager()
		{
		}
		
		public static function get instance():FbSpeedManager
		{
			if( _instance == null )
			{
				_instance = new FbSpeedManager();
			}
			return _instance;
		}

		public function get speed():Number
		{
			return _speed;
		}

		public function reset():void
		{
			iCount = 0;
			_speed = SPEED0;
		}
		
		public function loop():void
		{
			iCount++;
			if( iCount == CHANGE_OFFSET )
			{
				iCount = 0;
				if( _speed < MAX_SPEED )
				{
					_speed++;
				}
			}
		}
		
		public function dispose():void
		{
			reset();
			_instance = null;
		}
	}
}
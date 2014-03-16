package aobi.game.flappybird
{
	import flash.media.Sound;
	import flash.net.URLRequest;

	public class FbSoundManager
	{
		private static var _instance:FbSoundManager;
		
		
		private var sound_die:Sound;
		private var sound_pass:Sound;
		private var sound_fly:Sound;
		
		public function FbSoundManager()
		{
			sound_die = new SoundDie();
			sound_fly = new SoundFly();
			sound_pass = new SoundPass();
		}
		
		public static function get instance():FbSoundManager
		{
			if( _instance == null )
			{
				_instance = new FbSoundManager();
			}
			return _instance;
		}

		public function playSoundDie():void
		{
			sound_die.play();
		}
		
		public function playSoundFly():void
		{
			sound_fly.play();
		}
		
		public function playSoundPass():void
		{
			sound_pass.play();
		}
		
		public function dispose():void
		{
			sound_die.close();
			sound_fly.close();
			sound_pass.close();
			
			_instance = null;
		}
	}
}
package aobi.game.pickpicture
{
	import flash.display.MovieClip;

	public class Icon extends MovieClip
	{
		private var number:int;
		
		private var canRemove:Boolean;
		
		public function Icon()
		{
		}
		
		public function init():void
		{
			canRemove = false;
		}
		
		public function setNumber(num:int):void
		{
			this.gotoAndStop(num);
		}
		
		public function setCanRemove(val:Boolean):void
		{
			canRemove = val;
		}
		
		public function getNumber():int
		{
			return number;
		}
		
		public function getCanRemove():Boolean
		{
			return canRemove;
		}
	}
}
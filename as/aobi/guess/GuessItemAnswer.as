package aobi.guess
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class GuessItemAnswer extends GuessItemBase
	{
		private var target:int;
		
		private var funcCheckDone:Function;
		private var funcResetKey:Function;
		
		public function GuessItemAnswer(view:MovieClip)
		{
			super(view);
		}
		
		public function init(check:Function, resetKey:Function):void
		{
			funcCheckDone = check;
			funcResetKey = resetKey;
			code = "";
			target = -1;
		}
		
		public function clearItem():void
		{
			code = "";
			target = -1;
			if(funcCheckDone != null)
			{
				funcCheckDone.apply(null, []);
			}
		}
		
		public function setItem(code:String, target:int):void
		{
			this.code = code;
			this.target = target;
			if(funcCheckDone != null)
			{
				funcCheckDone.apply(null, []);
			}
		}
		
		override protected function onClick(evt:MouseEvent):void
		{
			if(target != -1)
			{
				if(funcResetKey != null)
				{
					funcResetKey.apply(null, [target]);
				}
				clearItem();
			}
		}
	}
}
package aobi.guess
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class GuessItemKey extends GuessItemBase
	{
		private var flagShow:Boolean;
		private var keyIndex:int;
		
		private var funcSetAnswer:Function;
		
		private var canClick:Boolean;
		
		public function GuessItemKey(view:MovieClip)
		{
			super(view);
		}
		
		public function init(keyIndex:int, code:String, setAnswer:Function):void
		{
			canClick = true;
			this.keyIndex = keyIndex;
			this.code = code;
			this.funcSetAnswer = setAnswer;
			showItem();
		}
		
		public function showItem():void
		{
			txtCode.visible = true;
			flagShow = true;
		}
		
		public function hideItem():void
		{
			txtCode.visible = false;
			flagShow = false;
		}
		
		public function setCanClick(val:Boolean):void
		{
			canClick = val;
		}
		
		override protected function onClick(evt:MouseEvent):void
		{
			if(flagShow && canClick)
			{
				hideItem();
				if(funcSetAnswer != null)
				{
					funcSetAnswer.apply(null, [code, keyIndex]);
				}
			}
		}
	}
}
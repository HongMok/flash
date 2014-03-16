package aobi.guess
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class GuessItemBase
	{
		private var view:MovieClip;
		protected var txtCode:TextField;
		
		protected var _code:String;
		
		public function GuessItemBase(view:MovieClip)
		{
			this.view = view;
			this.view.mouseChildren = false;
			this.view.buttonMode = true;
			this.txtCode = view.getChildByName("_code") as TextField;
			this.view.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function get code():String
		{
			return _code;
		}

		public function set code(value:String):void
		{
			_code = value;
			txtCode.text = String(_code);
		}

		protected function onClick(evt:MouseEvent):void
		{
			
		}
		
		public function setItemVisible(val:Boolean):void
		{
			this.view.visible = val;
		}
	}
}
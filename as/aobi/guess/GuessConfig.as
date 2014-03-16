package aobi.guess
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class GuessConfig
	{
		private var questionList:Array = [];
		
		public function GuessConfig()
		{
		}
		
		public function getQuestionByLevel(level:int):GuessItemData
		{
			if(level < 1 || level > questionList.length)
			{
				return null;
			}
			return questionList[level-1];
		}
		
		public function getMaxLevel():int
		{
			return questionList.length;
		}
		
		private var callBack:Function;
		
		public function getData(cb:Function):void
		{
			callBack = cb;
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.load(new URLRequest("data/guessconfig.xml"));
			xmlLoader.addEventListener(Event.COMPLETE, onLoadComplete);
		}
		
		protected function onLoadComplete(event:Event):void
		{
			var config:XML = new XML(event.target.data);
			var questions:XMLList = config.questions.question;
			for(var i:int = 0; i < questions.length(); i++)
			{
				var newQ:GuessItemData = new GuessItemData();
				newQ.parse(questions[i]);
				questionList.push(newQ);
			}
			callBack.apply(null, []);
		}
	}
}
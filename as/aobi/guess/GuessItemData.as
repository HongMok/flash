package aobi.guess
{
	public class GuessItemData
	{
		private var _title:String;
		private var _answer:String;
		private var _keyword:String;
		
		public function GuessItemData()
		{
		}
		
		public function parse(obj:Object):void
		{
			_title = obj.title;
			_answer = obj.answer;
			_keyword = obj.keyword;
		}

		public function get title():String
		{
			return _title;
		}

		public function get answer():String
		{
			return _answer;
		}

		public function get keyword():String
		{
			return _keyword;
		}

	}
}
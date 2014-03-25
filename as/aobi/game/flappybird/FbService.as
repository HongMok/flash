package aobi.game.flappybird
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	public class FbService extends Sprite
	{
		public function FbService()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onATS);
		}
		
		private function loadCommon():void
		{
			var load:Loader = new Loader();
			var loaderContext:LoaderContext = new LoaderContext();
			load.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadDone);
			load.load(new URLRequest("../../as/common.swf"));
		}
		
		var loadGame:Loader;
		protected function onLoadDone(event:Event):void
		{
			trace("load common done");
			loadGame = new Loader();
			var loaderContext:LoaderContext = new LoaderContext();
			loadGame.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadGame);
			loadGame.load(new URLRequest("flappybird.swf"));
		}
		
		protected function onLoadGame(event:Event):void
		{
			this.addChild(loadGame.content);
		}
		
		protected function onATS(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onATS);
			
//			loadCommon();
			onLoadDone(null);
			
		}
	}
}
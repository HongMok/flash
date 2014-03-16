
package aobi.splice
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import aobi.splice.com.game.BitmapSplice;
	import aobi.splice.com.game.Control;

	public class Test extends Sprite
	{
		private var bit:BitmapSplice;
		private var Images:Array;
		private var sence:Sprite=new Sprite();//场景类，设计为容器
		private var mycontrol:Control;
		public function Test()
		{   sence.addChildAt(new Bitmap(new Sence1(0,0)),0);
			bit=new BitmapSplice(new player(0,0),9,8);//player 类为库链接的位图
			Images=bit.Splice();//分割二维数组
			mycontrol=new Control(stage,sence,Images,9);
			addChild(sence);//位图容器初始化	
			addEventListener(Event.ENTER_FRAME,Run);
		}
		private function Run(event:Event):void
		{

		}
	}
}
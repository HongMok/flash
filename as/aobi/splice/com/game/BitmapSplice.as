
package aobi.splice.com.game
{
	/* 切割位图类，返回一个二维数组*/
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	public class BitmapSplice extends Sprite
	{
		public var contain:Sprite=new Sprite();//容器
		//public var direction:uint;//方向
		private var titleWidth:uint;//图片元件分取的宽 
		private var titleHeight:uint;//图片元件分取的高 
		private var bitmapdata:BitmapData;//位图源图像
		private var Step:Array=new Array();//存取步数数组
		public function BitmapSplice(bitmapdata:BitmapData,titleWidth:uint,titleHeight:uint)
		{
			this.bitmapdata=bitmapdata;
			this.titleWidth=titleWidth;
			this.titleHeight=titleHeight;
		}
		//进行切割
		public function Splice():Array
		{
			var iWidth:int=this.bitmapdata.width /this.titleWidth;
			var iHeight:int=this.bitmapdata.height /this.titleHeight;
			for (var i:uint=0; i < titleHeight; i++)
			{
				var array:Array=new Array();
				for (var j:uint=0; j < titleWidth; j++)
				{
					var tempBMP:BitmapData=new BitmapData(iWidth,iHeight,true,0x00000000);
					tempBMP.copyPixels(bitmapdata,new Rectangle(j * iWidth,i * iHeight,iWidth,iHeight),new Point(0,0));
					array.push(tempBMP);
				}
				this.Step.push(array);
			}
			bitmapdata.dispose();
			 
          return this.Step;

		}
	}
}
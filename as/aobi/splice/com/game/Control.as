
package aobi.splice.com.game
{
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	public class Control extends EventDispatcher
	{
        private var sence:Sprite;
		private var Images:Array;
		private var direction:uint=1;//方向
		private var step:uint=1;//步数
		private var vx:int=0;
		private var vy:int=0;
		private var speed:int=10;
		private var n_step:uint;
		private var player:Sprite=new Sprite();
		public function Control(stage:Stage,sence:Sprite,Images:Array,n_step:uint)
		{
			KEY.init(stage);//键盘初始化			 
			this.sence=sence;//场景	
			this.Images=Images;
			this.n_step=n_step;	
			this.sence.addChild(player);
			player.x=250;
			player.y=150;
			stage.addEventListener(Event.ENTER_FRAME,Run);//使用stage才可以进行监听
		}	
		private function Run(event:Event):void
		{
            while (player.numChildren>0)
			{
				player.removeChildAt(0);
			}		
			player.addChild(new Bitmap(Images[direction][step]));
			keyboardListener();
		}
		private function keyboardListener():void
		{
          if (KEY.isDown(KEYID.VK_UP) && KEY.isDown(KEYID.VK_LEFT))
			{
				goLeftAndTop();
			}
			else if (KEY.isDown(KEYID.VK_UP) && KEY.isDown(KEYID.VK_RIGHT))
			{
				goRightAndTop();
				trace("d");
			}
			else if (KEY.isDown(KEYID.VK_DOWN) &&  KEY.isDown(KEYID.VK_LEFT))
			{
				goLeftAndDown();
			}
			else if (KEY.isDown(KEYID.VK_DOWN) &&  KEY.isDown(KEYID.VK_RIGHT))
			{
				goRightAndDown();
			}
			else if (KEY.isDown(KEYID.VK_UP))
			{
				goUP();
			}
			else if (KEY.isDown(KEYID.VK_DOWN))
			{
				goDown();
			}
			else if (KEY.isDown(KEYID.VK_LEFT))
			{
				goLeft();
			}
			else if (KEY.isDown(KEYID.VK_RIGHT))
			{
				goRight();
			}
			else if (!KEY.isDown(KEYID.VK_LEFT) && !KEY.isDown(KEYID.VK_UP) && !KEY.isDown(KEYID.VK_RIGHT) && !KEY.isDown(KEYID.VK_DOWN))
			{
				stand();
			}

		}
		
		private function goLeftAndTop():void
		{
			go(-1,-1,3);
		}
		private function goRightAndTop():void
		{
			go(1,-1,6);

		}
		private function goLeftAndDown():void
		{
			go(-1,1,4);

		}
		private function goRightAndDown():void
		{
			go(1,1,7);

		}
		private function goUP():void
		{
			go(0,-1,0);

		}
		public function goDown():void
		{
			go(0,1,1);
		}
		private function goLeft():void
		{
			go(-1,0,2);
		}
		private function goRight():void
		{
			go(1,0,5);

		}
		private function stand():void
		{
			vx=0;
			vy=0;
			step=0;
		}
		private function go(_xv:int,_yv:int,direction:uint):void
		{
			this.direction=direction;
			vx = _xv*speed;
			vy = _yv*speed;
			step++;
			if (step>n_step-1)
			{
				step=1;
			}
			player.x+=vx;
			player.y+=vy;
			sence.x -=  vx;
			sence.y -=  vy;
		}	
			
	}
}
package aobi.game.flappybird
{
	import aobi.common.ShakeHelper;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.ui.Keyboard;

	public class FbGame extends MovieClip
	{
		private var blockMan:FbBlockManager;
		
		private var mcChoose:MovieClip;
		
		private var hero:FbHero;
		private var hero_start_pos:Point;
		private var iHeroView:int;
		
		private var mcGameOver:MovieClip;
		
		private var txtScore:TextField;
		
		
		public function FbGame()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onATS);
			
		}
		
		protected function onATS(event:Event):void
		{
			init();
		}
		
		private function init():void
		{
			
			iHeroView = 1;
			blockMan = new FbBlockManager(this.getChildByName("_mcContainer") as MovieClip);
			
			FbSpeedManager.instance.reset();
			
			var mcHero:MovieClip = this.getChildByName("_mcHero") as MovieClip;
			hero_start_pos = new Point(mcHero.x, mcHero.y);
			hero = new FbHero( mcHero );
			
			mcChoose = this.getChildByName("_mcChoosePlayer") as MovieClip;
			mcChoose.addEventListener(MouseEvent.CLICK, onClickChoose);
			
			
			
			this.addEventListener(Event.ENTER_FRAME, onGameLoop);
			
			
			mcGameOver = this.getChildByName("_mcGameOver") as MovieClip;
			mcGameOver.buttonMode = true;
			mcGameOver.visible = false;
			mcGameOver.addEventListener(MouseEvent.CLICK, onClickGameOver);
			
			txtScore = this.getChildByName("_txtScore") as TextField;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKD);
			
			stage.addEventListener(MouseEvent.CLICK, onClickStage);
			
			(this.getChildByName("_btnPause") as SimpleButton).addEventListener(MouseEvent.CLICK, onClickPause);
			
			pause();
			
			setHeroView();
			
		}
		
		protected function onClickStage(event:MouseEvent):void
		{
			hero.jump();
		}
		
		protected function onClickChoose(event:MouseEvent):void
		{
			var clkName:String = event.target.name;
			
			if( clkName.indexOf("player") != -1 )
			{
				var clkIndex:int = getNumFromStr(clkName);
				
				iHeroView = clkIndex;
				setHeroView();
				
				mcChoose.visible = false;
				
				restart();
			}
		}
		
		private function setHeroView():void
		{
			trace("choose player :" + iHeroView);
			hero.view.gotoAndStop(iHeroView);
		}
		
		private function getNumFromStr(str:String):int
		{
			var i:int;
			for( i = 0; i < str.length; i++ )
			{
				if( str.charCodeAt(i) >= 48 && str.charCodeAt(i) <= 57 )
				{
					break;
				}
			}
			
			var numStr:String = str.substr(i);
			return int(numStr);
		}
		
		protected function onClickPause(event:MouseEvent):void
		{
			if( isPlayingGame )
			{
				pause();
			}
			else
			{
				goon();
			}
		}
		
		private function goon():void
		{
			isPlayingGame = true;
			this.addEventListener(Event.ENTER_FRAME, onGameLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKD);
			stage.addEventListener(MouseEvent.CLICK, onClickStage);
		}
		
		private var speed:Number = 6;
		protected function onKD(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
//				case Keyboard.UP:
//					hero.view.y -= speed;
//					break;
//				case Keyboard.DOWN:
//					hero.view.y += speed;
//					break;
				case Keyboard.SPACE:
					hero.jump();
					break;
			}
		}
		
		protected function onClickGameOver(event:MouseEvent):void
		{
			pause();
			var clkName:String = event.target.name;
			switch(clkName)
			{
				case "btnRestart":
					restart();
					break;
				case "btnExit":
					onExit();
					break;
			}
			
			if( clkName.indexOf("player") != -1 )
			{
				var clkIndex:int = getNumFromStr(clkName);
				
				iHeroView = clkIndex;
				setHeroView();
				
				mcChoose.visible = false;
				
				restart();
			}
		}
		
		private function updateScore():void
		{
			txtScore.text = String( FbCubePassCounter.instance.count );
		}
		
		private var isPlayingGame:Boolean = true;
		private function pause():void
		{
			isPlayingGame = false;
			this.removeEventListener(Event.ENTER_FRAME, onGameLoop);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKD);
			stage.removeEventListener(MouseEvent.CLICK, onClickStage);
		}
		
		private function restart():void
		{
			goon();
			
			hero.view.x = hero_start_pos.x;
			hero.view.y = hero_start_pos.y;
			
			mcGameOver.visible = false;
			
			blockMan.dispose();
			
			hero.reset();
			
			FbSpeedManager.instance.reset();
			
			FbCubePassCounter.instance.count = 0;
		}
		
		protected function onGameLoop(event:Event):void
		{
			FbSpeedManager.instance.loop();
			
			if( blockMan.loop(hero) )
			{
				trace("hit cube");
				heroDie();
				return ;
			}
			
			if( hero.loop() )
			{
				heroDie();
			}
			
			updateScore();
		}
		
		private function heroDie():void
		{
			FbSoundManager.instance.playSoundDie();
			trace("hero die");
			pause();
			
			ShakeHelper.shakeObj(this, 0.2, 200, 3, showGameOver);
		}
		
		private function showGameOver():void
		{
			mcGameOver.visible = true;
			mcGameOver.parent.setChildIndex(mcGameOver, mcGameOver.parent.numChildren - 1);
			
			(mcGameOver.getChildByName("_txtMyScore") as TextField).text = String(FbCubePassCounter.instance.count);
			
			(mcGameOver.getChildByName("_mcHero") as MovieClip).gotoAndStop(iHeroView);
		}
		
		protected function onExit():void
		{
			FbSpeedManager.instance.dispose();
			
			blockMan.dispose();
			
			FbBlockPool.instance.dispose();
			
			FbCubePool.instance.dispose();
			
			FbCubePassCounter.instance.dispose();
			
			this.removeEventListener(Event.ENTER_FRAME, onGameLoop);
			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKD);
			
			stage.removeEventListener(MouseEvent.CLICK, onClickStage);
			
			FbSoundManager.instance.dispose();
			
			this.parent.removeChild(this);
		}
	}
}
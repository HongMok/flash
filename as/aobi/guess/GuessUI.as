package aobi.guess
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;

	public class GuessUI extends MovieClip
	{
		private var itemAnswerList:Array = [];
		private var itemKeyList:Array = [];
		
		private var codeAnswerList:Array = [];
		private var codeKeyList:Array = [];
		
		private var numAnswer:int;
		private var numKey:int;
		
		private static const MAX_ANSWER_NUM:int = 10;
		private static const MAX_KEY_NUM:int = 20;
		
		private var questionConfig:GuessConfig;
		
		private var level:int;
		private var maxLevel:int;
		
		private var numTip:int;
		
		private var btnTip:SimpleButton;
		private var conPic:MovieClip;
		private var mcAllDone:MovieClip;
		private var txtLevel:TextField;
		
		private var txtQuestion:TextField;
		
		public function GuessUI()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onATS);
		}
		
		protected function onATS(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onATS);
			
			init();
		}
		
		private function init():void
		{
			level = 1;
			
			getMC();
			
			questionConfig = new GuessConfig();
			questionConfig.getData(afGetData);
		}
		
		private function afGetData():void
		{
			maxLevel = questionConfig.getMaxLevel();
			trace("max level"  + maxLevel);
			getData();
		}
		
		private function getData():void
		{
			var levelData:GuessItemData = questionConfig.getQuestionByLevel(level);
			
			numAnswer = levelData.answer.length;
			numKey = MAX_KEY_NUM;
			
			numTip = 1;
			btnTip.visible = true;
			
			parseAnswer(levelData.answer);
			parseKey(levelData.answer, levelData.keyword);
			
			txtQuestion.text = levelData.title;
			
			setData();
		}
		
		private function setData():void
		{
			txtLevel.text = "Question " + level;
			
			loadPic();
			
			setAnswerList();
			
			setKeyList();
		}
		
		private function setAnswerList():void
		{
			var itemAnswer:GuessItemAnswer;
			for(var i:int = 0; i < MAX_ANSWER_NUM; i++)
			{
				itemAnswer = itemAnswerList[i];
				if(i < numAnswer)
				{
					itemAnswer.setItemVisible(true);
					itemAnswer.init(onCheckDone, onResetKey);
				}
				else
				{
					itemAnswer.setItemVisible(false);
				}
			}
		}
		
		private function onCheckDone():void
		{
			trace("checking");
			if(isAllDone())
			{
				nextLevel();
			}
			else
			{
				
			}
		}
		
		private function nextLevel():void
		{
			level++;
			if(level > maxLevel)
			{
				trace("all done");
				overGame();
			}
			else
			{
				trace("next level");
				getData();
			}
		}
		
		private function isFull():Boolean
		{
			for(var i:int = 0; i < numAnswer; i++)
			{
				if(GuessItemAnswer(itemAnswerList[i]).code == "")
				{
					setKeyPanel(true)
					return false;
				}
			}
			
			setKeyPanel(false);
			return true;
		}
		
		private function setKeyPanel(val:Boolean):void
		{
			for(var i:int = 0; i < itemKeyList.length; i++)
			{
				GuessItemKey(itemKeyList[i]).setCanClick(val);
			}
		}
		
		private function isAllDone():Boolean
		{
			if( ! isFull())
			{
				return false;
			}
			for(var i:int = 0; i < numAnswer; i++)
			{
				if(GuessItemAnswer(itemAnswerList[i]).code != codeAnswerList[i])
				{
					return false;
				}
			}
			return true;
		}
		
		private function onResetKey(target:int):void
		{
			GuessItemKey(itemKeyList[target]).showItem();
		}
		
		private function setKeyList():void
		{
			var itemKey:GuessItemKey;
			for(var i:int = 0; i < MAX_KEY_NUM; i++)
			{
				itemKey = itemKeyList[i];
				if(i < numKey)
				{
					itemKey.setItemVisible(true);
					itemKey.init(i, codeKeyList[i], onSetAnswer);
				}
				else
				{
					itemKey.setItemVisible(false);
				}
			}
		}
		
		private function onSetAnswer(code:String, keyIndex:int):void
		{
			var ePos:int = findEmptyPos();
			GuessItemAnswer(itemAnswerList[ePos]).setItem(code, keyIndex);
		}
		
		private function findEmptyPos():int
		{
			for(var i:int = 0; i < numAnswer; i++)
			{
				if(GuessItemAnswer(itemAnswerList[i]).code == "")
					return i;
			}
			return -1;
		}
		
		private function parseKey(answer:String, key:String):void
		{
			var totalStr:String = answer + key;
			totalStr = totalStr.substr(0, numKey);
			
			codeKeyList = [];
			var thisCode:String;
			var randIndex:int;
			for(var i:int = 0; i < numKey; i++)
			{
				if(totalStr.length > 0)
				{
					randIndex = int(Math.random() * totalStr.length);
					thisCode = totalStr.charAt(randIndex);
					codeKeyList.push(thisCode);
					totalStr = totalStr.substring(0, randIndex) + totalStr.substr(randIndex+1);
				}
				else
				{
					codeKeyList.push("的");
				}
			}
		}
		
		private function parseAnswer(answer:String):void
		{
			codeAnswerList = [];
			tipFlagList = [];
			for(var i:int = 0; i < answer.length; i++)
			{
				codeAnswerList.push(answer.charAt(i));
				tipFlagList.push(0);
			}
		}
		
		private function getMC():void
		{
			var i:int;
			for(i = 0; i < MAX_ANSWER_NUM; i++)
			{
				itemAnswerList[i] = new GuessItemAnswer(this.getChildByName("answer" + i) as MovieClip);
			}
			
			for(i = 0; i < MAX_KEY_NUM; i++)
			{
				itemKeyList[i] = new GuessItemKey(this.getChildByName("key" + i) as MovieClip);
			}
			
			btnTip = this.getChildByName("_btnTip") as SimpleButton;
			btnTip.addEventListener(MouseEvent.CLICK, onClickTip);
			
			conPic = this.getChildByName("_conPic") as MovieClip;
			
			mcAllDone = this.getChildByName("_mcAllDone") as MovieClip;
			mcAllDone.visible = false;
			
			txtLevel = this.getChildByName("_txtLevel") as TextField;
			
			txtQuestion = this.getChildByName("_txtQuestion") as TextField;
		}
		
		private function loadPic():void
		{
			var picLoader:Loader = new Loader();
			picLoader.load(new URLRequest( "data/" + level + ".jpg"));
			while(conPic.numChildren > 1)
			{
				conPic.removeChildAt(1);
			}
			
//			picLoader.scaleX = 0.03;
//			picLoader.scaleY = 0.03;
			conPic.addChild(picLoader);
		}
		
		protected function onClickTip(event:MouseEvent):void
		{
			numTip--;
			if(numTip == 0)
			{
				btnTip.visible = false;
			}
			
			var tipPos:int = randTipPos();
			var keyPos:int = getKeyPosByCode(codeAnswerList[tipPos]);
			GuessItemKey(itemKeyList[keyPos]).hideItem();
			GuessItemAnswer(itemAnswerList[tipPos]).setItem(GuessItemKey(itemKeyList[keyPos]).code, keyPos);
		}
		
		private var tipFlagList:Array = [];
		
		private function randTipPos():int
		{
			trace("tip list" + tipFlagList);
			var randPos:int = int(Math.random() * tipFlagList.length);
			while(tipFlagList[randPos] == 1)
			{
				randPos = (randPos + 1) % tipFlagList.length;
			}
			tipFlagList[randPos] = 1;
			return randPos;
		}
		
		private function getKeyPosByCode(code:String):int
		{
			for(var i:int = 0; i < codeKeyList.length; i++)
			{
				if(codeKeyList[i] == code)
				{
					return i;
				}
			}
			return -1;
		}
		
		private function hideAllItem():void
		{
			var i:int;
			for(i = 0; i < MAX_ANSWER_NUM; i++)
			{
				GuessItemAnswer(itemAnswerList[i]).setItemVisible(false);
			}
			for(i = 0; i < MAX_KEY_NUM; i++)
			{
				GuessItemKey(itemKeyList[i]).setItemVisible(false);
			}
			
			mcAllDone.visible = true;
		}
		
		private function overGame():void
		{
			hideAllItem();
			btnTip.removeEventListener(MouseEvent.CLICK, onClickTip);
		}
	}
}
package aobi.game.pickpicture
{
	
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	

	public class PickPicture extends MovieClip
	{
		private var mcArea:MovieClip;
		private var mcTarget:Icon;
		private var txtScore:TextField;
		
		private var pool_icon:Array = [];
		
		private var curr_icon_list:Array = [];
		
		private const create_step:int = 25 * 1;
		private var frame_count:int = 0;
		
		private var min_x:Number;
		private var max_x:Number;
		private var start_y:Number;
		
		private var speed:int = 1;
		
		private var currTargetNumber:int;
		
		private const score_step:int = 10;
		
		private const create_target_step:int = 25 * 3;
		
		private var iMyScore:int;
		
		
		public function PickPicture()
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
			
			getMC();
			
			updateScore(0);
			
			min_x = mcArea.x + 10;
			max_x = mcArea.x + mcArea.width - mcTarget.width - 10;
			start_y = mcArea.y;
			
			createTarget();
			
			this.addEventListener(Event.ENTER_FRAME, onEF);
		}
		
		protected function onEF(event:Event):void
		{
			frame_count++;
			if(frame_count % create_step == 0)
			{
				
				createIcon();
			}
			
			if( frame_count % create_target_step == 0 )
			{
				createTarget();
			}
			
			loop();
		}
		
		private function createTarget():void
		{
			currTargetNumber = int( Math.random() * 10 + 1 );
			
			mcTarget.setNumber(currTargetNumber);
		}
		
		private function loop():void
		{
			checkOut();
			
			clear();
		}
		
		private function checkOut():void
		{
			for(var i:int = 0; i < curr_icon_list.length; i++)
			{
				Icon(curr_icon_list[i]).y += speed;
				
				if( ! mcArea.hitTestObject( curr_icon_list[i]) )
				{
					Icon(curr_icon_list[i]).setCanRemove(true);
				}
				
				Icon( curr_icon_list[i] ).addEventListener(MouseEvent.CLICK, onClickIcon);
			}
		}
		
		protected function onClickIcon(event:MouseEvent):void
		{
			var icon:Icon = event.currentTarget as Icon;
			var iconName:String = icon.name;
			trace("click name:" + iconName);
			
//			icon.setCanRemove(true);
			
			TweenLite.to(icon, 0.6, {"x" : mcTarget.x, "y" : mcTarget.y});
			
			if( int(iconName) == currTargetNumber )
			{
				trace("yes");
				
				createTarget();
				
				updateScore(iMyScore + score_step);
			}
			else
			{
				trace("no");
			}
		}
		
		private function clear():void
		{
			for(var i:int = 0; i < curr_icon_list.length; i++)
			{
				
				if( Icon(curr_icon_list[i]).getCanRemove() )
				{
					Icon(curr_icon_list[i]).parent.removeChild(curr_icon_list[i]);
					
					pushIcon(curr_icon_list[i]);
					
					curr_icon_list.splice(i, 1);
					
					i--;
				}
			}
		}
		
		private function createIcon():void
		{
			var randX:Number = Math.random() * (max_x - min_x) + min_x;
			
			var randIndex:int = int( Math.random() * 10 + 1);
		
			var icon:MovieClip = popIcon(randIndex);
			
			icon.x = randX;
			icon.y = start_y;
			
			icon.name = "" + randIndex;
			
			this.addChild(icon);
			curr_icon_list.push(icon);
		}
		
		private function getMC():void
		{
			mcArea = this.getChildByName("_mcArea") as MovieClip;
			
			mcTarget = this.getChildByName("_mcTarget") as Icon;
			
			txtScore = this.getChildByName("_txtScore") as TextField;
		}
		
		private function updateScore(val:int):void
		{
			iMyScore = val;
			txtScore.text = String(iMyScore);
		}
		
		private function popIcon(index:int):Icon
		{
			trace("poping");
			trace("current length:" + pool_icon.length);
			if(pool_icon.length == 0)
			{
				var newIcon:Icon = new Icon();
				pool_icon.push(newIcon);
			}
			
			var ret:Icon = pool_icon.pop();
			ret.init();
			ret.setNumber(index);
			return ret;
		}
		
		private function pushIcon(icon:Icon):void
		{
			trace("pushing");
			trace("current length:" + pool_icon.length);
			pool_icon.push(icon);
		}
	}
}
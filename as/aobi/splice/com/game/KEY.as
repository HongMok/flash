
package aobi.splice.com.game
{
	/*键盘按键判断类.
	使用时先初始化要监听的对象.再判断哪个键被按下了.
	KEY.init(stage);
	KEY.isDown(40);返回true或false
	*/
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	public class KEY {
        private static  var keyObj:KEY = null;
        private static  var keys:Object;
        public static function init(_stage:DisplayObject):void {
            if (keyObj == null) {
                keys = {};
                _stage.addEventListener(KeyboardEvent.KEY_DOWN, KEY.keyDownHandler);
                _stage.addEventListener(KeyboardEvent.KEY_UP, KEY.keyUpHandler);
            }
        }
        public static function isDown( keyCode:uint ):Boolean {
            return keys[keyCode];
			 
        }
        private static function keyDownHandler( e:KeyboardEvent ):void {
            keys[e.keyCode] = true;
			trace( keys[e.keyCode]);
        }
        private static function keyUpHandler( e:KeyboardEvent ):void {
            delete keys[e.keyCode];
        }
    }

}
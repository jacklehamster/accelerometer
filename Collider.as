package  {
	
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.display.DisplayObject;
	
	
	public class Collider extends Element implements ICollider {
		private var collisionWidth:int = 50, collisionHeight:int = 50;
		
		public function Collider():void {
			var collisionBox:DisplayObject = getChildByName("collisionBox");
			if(collisionBox) {
				collisionWidth = collisionBox.width;
				collisionHeight = collisionBox.height;
				collisionBox.visible = false;
			}
		}
		
		public function get dimensions():Rectangle {
			return new Rectangle(x,y,bodyWidth(),bodyHeight());
		}
		
		protected function bodyWidth():int {
			return collisionWidth;
		}
		
		protected function bodyHeight():int {
			return collisionHeight;
		}
		
		public function splashDamage(bomb:Bomb):void {
			
		}
		
	}
	
}

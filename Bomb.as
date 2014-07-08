package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	
	public class Bomb extends Body {
		
		static private const RANGE:Number = 25;
		
		override public function initialize():void {
			stop();
		}
		
		public function onFire():Boolean {
			return currentFrame>1;
		}
		
		public function booming():Boolean {
			return currentLabel=="BOOM";
		}
		
		override public function splashDamage(bomb:Bomb):void {
			super.splashDamage(bomb);
			if(currentFrame==1) {
				gotoAndPlay(2);
			}
		}
		
		override protected function onFrame(e:Event):void {
			super.onFrame(e);
			if(booming()) {
				mov.x = mov.y = 0;
				if(currentFrameLabel=="BOOM") {
					boom();
				}
			}
			if(currentFrame==totalFrames) {
				destroy(true);
			}
		}
		
		override protected function get gravity():Number {
			return booming()?0:GRAVITY;
		}
		
		private function boom():void {
			var p:Array = colliders;
			var rect:Rectangle = new Rectangle(x-RANGE*scaleX,y-RANGE*scaleY,bodyWidth()+RANGE*2*scaleX,bodyHeight()+RANGE*2*scaleY);
			for each(var collider:Collider in p) {
				if(collider!=this && rect.intersects(collider.dimensions)) {
					collider.splashDamage(this);
				}
			}
		}
	}
	
}

package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Dolphino extends Body {
		
		private var orgY:Number = 0, swim:int = 0;
		public function Dolphino():void {
			orgY = y;
			mov.x = 2;
		}
		
		override protected function hitWall():void {
			mov.x = -mov.x;
		}
		
		override protected function slowDown():void {
		}
		
		override protected function onFrame(e:Event):void {
			super.onFrame(e);
			if(y>orgY) {
				y = orgY;
				mov.y = 0;
			}
			else if(y==orgY) {
				swim++;
				if(swim>100) {
					swim = 0;
					mov.y = -10;
				}
			}
			updateAnimation();
		}
		
		override protected function get gravity():Number {
			return y==orgY?0:super.gravity;
		}
		
		private function updateAnimation():void {
			var label:String = (mov.x<0?"LEFT":"RIGHT");
			if(label!=currentLabel) {
				gotoAndPlay(label);
			}
		}
	}
}

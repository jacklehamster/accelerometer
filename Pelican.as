package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	
	public class Pelican extends Body {

		private var orgY:Number = 0;
		public function Pelican():void {
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
			if(mov.y>3) {
				mov.y = -Math.abs(mov.y)-(y>orgY?2:1.5)*Math.random();
			}
			updateAnimation();
		}
		
		private function updateAnimation():void {
			var label:String = "FLY" + (mov.x<0?"LEFT":"RIGHT");
			if(label!=currentLabel) {
				gotoAndPlay(label);
			}
		}
	}
	
}

package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	
	public class RainbowDuck extends Body {
		
		private var direction:int = 1;
		
		public function RainbowDuck() {
			// constructor code
		}
		
		override protected function onFrame(e:Event):void {
			super.onFrame(e);
			if(mov.x<0)
				direction = -1;
			else if(mov.x>0)
				direction = 1;
			updateAnimation();
		}
		
		override protected function slowDown():void {
			mov.normalize(mov.length<.3?0:mov.length*.95);
		}
				
		private function updateAnimation():void {
			var label:String = (mov.x==0?"STAND":"RUN") + (direction<0?"LEFT":"RIGHT");
			if(label!=currentLabel) {
				gotoAndPlay(label);
			}
		}
		
		override public function splashDamage(bomb:Bomb):void {
			ko();
		}
		
		public function ko():void {
			if(master) {
				var koDuck:KODuck = Element.create(KODuck) as KODuck;
				koDuck.mov.y = -10*Math.random();
				var point:Point = localToGlobal(new Point());
				koDuck.x = point.x;
				koDuck.y = point.y;
				project.addChild(koDuck);
				destroy(false);
			}
		}
		
	}
	
}

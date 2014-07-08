package  {
	import flash.geom.Point;
	import flash.events.Event;
	
	public class Etincelle extends Element {

		public var mov:Point = new Point(), life:int = 0;
		
		public function Etincelle():void {
			graphics.clear();
			graphics.beginFill(uint(Math.random()*uint.MAX_VALUE)&0xFFAA44);
			graphics.drawRect(-1.5,-1.5,3,3);
		}
		
		override public function initialize():void {
			life = 0;
		}
		
		override protected function onStage(e:Event):void {
			super.onStage(e);
			addEventListener(Event.ENTER_FRAME,onFrame);
		}
		
		override protected function offStage(e:Event):void {
			removeEventListener(Event.ENTER_FRAME,onFrame);
			super.offStage(e);
		}
		
		protected function onFrame(e:Event):void {
			x += mov.x;
			y += mov.y;
			mov.y ++;
			life++;
			if(life>5) {
				destroy(true);
			}
		}

	}
	
}

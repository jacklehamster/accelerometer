package  {
	import flash.events.Event;
	import flash.geom.Point;
	
	public class KOElement extends Element {

		public var mov:Point = new Point(), life:int = 0;
		
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
			if(life>50) {
				destroy(false);
			}
		}
	}
	
}

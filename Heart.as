package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Heart extends Element {
		
		private var life:int = 0;
		
		override protected function onStage(e:Event):void {
			super.onStage(e);
			addEventListener(Event.ENTER_FRAME,onFrame);
		}
		
		override public function initialize():void {
			life = 0;
		}
		
		override protected function offStage(e:Event):void {
			removeEventListener(Event.ENTER_FRAME,onFrame);
			super.offStage(e);
		}
		
		protected function onFrame(e:Event):void {
			y --;
			life++;
			if(life>5) {
				destroy(true);
			}
		}
	}
	
}

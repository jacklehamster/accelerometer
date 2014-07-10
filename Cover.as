package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	
	public class Cover extends Element {
		
		
		public function Cover() {
			addEventListener(Event.ENTER_FRAME,onFrame);
		}
		
		override protected function onStage(e:Event):void {
			super.onStage(e);
			addEventListener(Event.ENTER_FRAME,onFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKey);
		}
		
		override protected function offStage(e:Event):void {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKey);
			removeEventListener(Event.ENTER_FRAME,onFrame);
			super.offStage(e);
		}
		
		private function onKey(e:KeyboardEvent):void {
			play();
		}
		
		private function onFrame(e:Event):void {
			if(currentFrame==totalFrames) {
				gotoAndStop(1);
				destroy(false);
				Element.resumeGame();
			}
		}
	}
	
}

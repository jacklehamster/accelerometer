package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	
	public class Cloud extends Element {
		
		static private var stageRect:Rectangle = null;
		
		public function Cloud():void {
			y = Math.random()*200;
			baby.visible = Math.random()<.1;
		}
		
		override protected function onStage(e:Event):void {
			super.onStage(e);
			if(!stageRect) {
				stageRect = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
			}
			addEventListener(Event.ENTER_FRAME,onFrame);
		}
		
		override protected function offStage(e:Event):void {
			removeEventListener(Event.ENTER_FRAME,onFrame);
			super.offStage(e);
		}
		
		private function onFrame(e:Event):void {
			x--;
			var rect:Rectangle = getRect(parent);
			if(!stageRect.intersects(rect)) {
				x = stageRect.right;
				y = Math.random()*200;
				baby.visible = Math.random()<.1;
			}
		}
	}
	
}

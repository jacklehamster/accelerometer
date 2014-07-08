package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	
	public class HeartGenerator extends Element {
		override protected function onStage(e:Event):void {
			super.onStage(e);
			visible = false;
			addEventListener(Event.ENTER_FRAME,onFrame);
		}
		
		override protected function offStage(e:Event):void {
			removeEventListener(Event.ENTER_FRAME,onFrame);
			super.offStage(e);
		}
		
		protected function onFrame(e:Event):void {
			var heart:Heart = Element.create(Heart) as Heart;
			var point:Point = localToGlobal(new Point());
			heart.x = point.x+(Math.random()-.5)*10;
			heart.y = point.y+(Math.random()-.5)*10;
			project.addChild(heart);
		}
	}
	
}

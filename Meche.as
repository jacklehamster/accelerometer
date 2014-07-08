package  {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;
	
	
	public class Meche extends Element {
		
		override protected function onStage(e:Event):void {
			super.onStage(e);
			addEventListener(Event.ENTER_FRAME,onFrame);
		}
		
		override protected function offStage(e:Event):void {
			removeEventListener(Event.ENTER_FRAME,onFrame);
			super.offStage(e);
		}
		
		protected function onFrame(e:Event):void {
			var etincelle:Etincelle = Element.create(Etincelle) as Etincelle;
			etincelle.mov.x = 10*(Math.random()-.5)
			etincelle.mov.y = -5*Math.random();
			var point:Point = localToGlobal(new Point());
			etincelle.x = point.x;
			etincelle.y = point.y;
			project.addChild(etincelle);
		}
	}
	
}

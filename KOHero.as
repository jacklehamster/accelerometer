package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	
	public class KOHero extends KOElement {
		
		
		
		override public function destroy(recycle:Boolean):void {
			project.prevScene();
		}

	}
	
}

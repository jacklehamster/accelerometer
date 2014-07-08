package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Barrel extends Body {
		
		private var direction:int = 1;
		
		override protected function onFrame(e:Event):void {
			super.onFrame(e);
			if(mov.x<0)
				direction = -1;
			else if(mov.x>0)
				direction = 1;
			updateAnimation();
		}
		
		override protected function hitWall():void {
			mov.x = -mov.x;
		}
		
		private function updateAnimation():void {
			var label:String = (mov.x==0?"SIT":"SLIDE") + (direction<0?"LEFT":"RIGHT");
			if(label!=currentLabel) {
				gotoAndPlay(label);
			}
		}
	}
	
}

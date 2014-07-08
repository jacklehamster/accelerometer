package  {
	
	import flash.display.MovieClip;
	
	
	public class RainbowHair extends Element {
		
		
		override public function initialize():void {
			gotoAndPlay(int(Math.random()*totalFrames)+1);
		}
	}
	
}

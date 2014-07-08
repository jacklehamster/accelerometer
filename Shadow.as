package  {
	
	import flash.display.MovieClip;
	import flash.sensors.Accelerometer;
	import flash.events.AccelerometerEvent;
	import flash.display.DisplayObject;
	
	
	public class Shadow extends MovieClip {
		
		static private var accel:Accelerometer = new Accelerometer();
		public function Shadow() {
			accel.addEventListener(AccelerometerEvent.UPDATE,onAccel);
		}
		
		private function onAccel(e:AccelerometerEvent):void {
			var child:DisplayObject = getChildAt(0);
			child.x = e.accelerationX*50;
			child.y = e.accelerationY*50;
			trace(child.x,child.y);
		}
	}
	
}

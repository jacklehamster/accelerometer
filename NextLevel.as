package  {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.text.TextField;
	import flash.display.Scene;
	
	
	public class NextLevel extends Element {
		
		static var maxScene:int = 0, level:int = 0;
		
		override protected function onStage(e:Event):void {
			super.onStage(e);
			cleanUp();
			for(var scene:int=0; scene<master.scenes.length; scene++) {
				if(master.scenes[scene].name==master.currentScene.name) {
					break;
				}
			}
			if(scene>maxScene) {
				level++;
				maxScene = scene;
			}
			tf.text = tf.text.split("%level").join(level);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKey);
		}
		
		override protected function offStage(e:Event):void {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKey);
			super.offStage(e);
		}

		private function onKey(e:KeyboardEvent):void {
			if(e.keyCode==Keyboard.SPACE) {
				master.nextScene();
			}
		}
	}
	
}

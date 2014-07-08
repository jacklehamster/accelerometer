package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	public class Element extends MovieClip {

		static private var recycler:Dictionary = new Dictionary();
		public var sceneName:String = null;
		
		static public function create(classObj:Class):Element {
			var bin:Array = recycler[classObj];
			var elem:Element = bin ? bin.pop() : null;
			if(!elem) {
				elem = new classObj();
			}
			else {
				elem.initialize();
			}
			return elem;
		}
		
		static private function trash(elem:Element):void {
			var classObj:Class = Object(elem).constructor;
			var bin:Array = recycler[classObj];
		}
		
		public function Element() {
			addEventListener(Event.ADDED_TO_STAGE,onStage);
			addEventListener(Event.REMOVED_FROM_STAGE,offStage);
			initialize();
		}
		
		public function initialize():void {
		}
		
		protected function get self():Element {
			return this;
		}

		protected function onStage(e:Event):void {
			sceneName = project.currentScene.name;
			project.stop();
		}
		
		protected function offStage(e:Event):void {
		}
		
		protected function get master():MovieClip {
			return parent as MovieClip;
		}
		
		protected function get project():MovieClip {
			return root as MovieClip;
		}
		
		public function destroy(recycle:Boolean):void {
			if(master)
				master.removeChild(this);
			if(recycle) {
				trash(this);
			}
		}
		
		public function cleanUp():void {
			for(var i:int=project.numChildren-1;i>=0;i--) {
				var element:Element = project.getChildAt(i) as Element;
				if(element && element.sceneName!=project.currentScene.name) {
					element.master.removeChild(element);
					if(!project)
						break;
				}
			}
		}
	}
	
}

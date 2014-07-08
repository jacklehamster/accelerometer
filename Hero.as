package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	
	public class Hero extends Body {
		
		private var keyboard:Object = {};
		
		public function Hero() {
		}

		override public function initialize():void {
			bomb.visible = false;
			mov.x = 5;
		}

		override protected function bodyWidth():int {
			return 20;
		}
		
		override protected function bodyHeight():int {
			return 30;
		}
		
		override protected function onStage(e:Event):void {
			super.onStage(e);
			addEventListener(Event.ENTER_FRAME,onFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKey);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKey);
		}
		
		override protected function offStage(e:Event):void {
			removeEventListener(Event.ENTER_FRAME,onFrame);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKey);
			stage.removeEventListener(KeyboardEvent.KEY_UP,onKey);
			super.offStage(e);
		}
		
		private function onKey(e:KeyboardEvent):void {
			keyboard[e.keyCode] = e.type==KeyboardEvent.KEY_DOWN;
		}
		
		override protected function hitWall():void {
			if(grounded) {
				mov.x = -mov.x;
			}
			else if(keyboard[Keyboard.SPACE]) {
				if(bomb.visible) {
					var b:Bomb = Element.create(Bomb) as Bomb;
					b.gotoAndPlay(bomb.currentFrame==1?2:bomb.currentFrame);
					b.mov.y = -4;
					b.mov.x = mov.x*2.5;
					b.x = x;
					b.y = y-10;
					master.addChild(b);
					bomb.visible = false;
					bomb.gotoAndStop(1);
				}
				else {
					mov.x = -mov.x;
					mov.y = -7;
					keyboard[Keyboard.SPACE] = false;
				}
			}
		}
		
		override protected function slowDown():void {
		}
		
		override protected function onFrame(e:Event):void {
			super.onFrame(e);
			
			if(grounded && jumping) {
				jumping = false;
				bounce = false;
			}
			
			if(exited) {
				project.nextScene();
				return;
			}
			
			if(grounded && keyboard[Keyboard.SPACE]) {
				if(bomb.visible) {
					var b:Bomb = Element.create(Bomb) as Bomb;
					b.gotoAndPlay(bomb.currentFrame==1?2:bomb.currentFrame);
					b.mov.y = -4;
					b.mov.x = mov.x*2.5;
					b.x = x;
					b.y = y-10;
					master.addChild(b);
					bomb.visible = false;
					bomb.gotoAndStop(1);
				}
				else {
					mov.y = -10;
					jumping = true;
				}
				keyboard[Keyboard.SPACE] = false;
			}
			if(keyboard[Keyboard.ESCAPE]) {
				project.prevScene();
			}
			if(keyboard[Keyboard.N]) {
				project.nextScene();
			}
			if(inwater || spiked) {
				ko();
			}
			if(bomb.visible && bomb.currentFrameLabel=="BOOM") {
				b = Element.create(Bomb) as Bomb;
				b.gotoAndPlay(bomb.currentFrame==1?2:bomb.currentFrame);
				b.x = x;
				b.y = y-10;
				master.addChild(b);
				bomb.visible = false;
				bomb.gotoAndStop(1);
			}
			updateAnimation();
		}
		
		override public function splashDamage(bomb:Bomb):void {
			ko();
		}
		
		public function ko():void {
			if(master) {
				var koHero:KOHero = Element.create(KOHero) as KOHero;
				koHero.mov.y = -10*Math.random();
				var point:Point = localToGlobal(new Point());
				koHero.x = point.x;
				koHero.y = point.y;
				project.addChild(koHero);
				destroy(false);
			}
		}
		
		private function updateAnimation():void {
			var label:String = (jumping?"JUMP":"WALK") + (mov.x<0?"LEFT":"RIGHT");
			if(label!=currentLabel) {
				gotoAndPlay(label);
			}
		}
		
	}
	
}

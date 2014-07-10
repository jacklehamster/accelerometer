package  {
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Body extends Collider {
		
		static const GRAVITY:Number = .9;		
		public var mov:Point = new Point();
		public var grounded:Boolean, bounce:Boolean;
		static protected var boundaries:Platform = new Platform();
		public var exited:Boolean = false, inwater:Boolean;
		protected var jumping:Boolean = false, spiked:Boolean;

		override protected function onStage(e:Event):void {
			super.onStage(e);
			addEventListener(Event.ENTER_FRAME,onFrame);
		}
		
		override protected function offStage(e:Event):void {
			removeEventListener(Event.ENTER_FRAME,onFrame);
			super.offStage(e);
		}
		
		override public function splashDamage(bomb:Bomb):void {
			var diffX:Number = x-bomb.x;
			var diffY:Number = y-bomb.y;
			var dist:Number = Math.sqrt(diffX*diffX+diffY*diffY);
			mov.x = diffX/dist*10;
			mov.y = diffY/dist*10;
		}
		
		protected function get gravity():Number {
			return GRAVITY;
		}
		
		protected function onFrame(e:Event):void {
			if(!Element.paused) {
				mov.y += gravity;
				var nextPos:Point = new Point(x+mov.x*scaleX,y+mov.y*scaleY);
				grounded = false;
				bounce = false;
				
				if(collide(nextPos.x,nextPos.y,bodyWidth()*scaleX,bodyHeight()*scaleY)) {
					if(!collide(nextPos.x,y,bodyWidth()*scaleX,bodyHeight()*scaleY)) {
						hitGround();
						nextPos.y = y;
					}
					else if(!collide(x,nextPos.y,bodyWidth()*scaleX,bodyHeight()*scaleY)) {
						hitWall();
						nextPos.x = x;
					}
					else {
						hitWall();
						hitGround();
						nextPos.x = x;
						nextPos.y = y;
					}
					slowDown();
				}
				x = nextPos.x;
				y = nextPos.y;
				
				if(bounce) {
					bounce = false;
					mov.y = -18;
					grounded = false;
					jumping = true;
				}
			}
		}
		
		protected function slowDown():void {
			mov.normalize(mov.length<.3?0:mov.length*.9);
		}
		
		protected function hitGround():void {
			mov.y /=4;
		}
		
		protected function hitWall():void {
			mov.x /=4;
		}
		
		protected function get colliders():Array {
			var array:Array = [];
			for(var i:int=0;i<parent.numChildren;i++) {
				var child:Collider = parent.getChildAt(i) as Collider;
				if(child && child!=this)
					array.push(child);
			}
			return array;
		}
		
		private function collide(x:Number,y:Number,width:Number,height:Number):Collider {
			var p:Array = colliders;
			var rect:Rectangle = new Rectangle(x,y,width,height);
			for each(var collider:Collider in p) {
				if(rect.intersects(collider.dimensions)) {
					if((this is Brick) && !(collider is Platform)) {
						continue;
					}
					else if(collider is Water) {
						inwater = true;
						if(!(this is Barrel)) {
							continue;
						}
					}
					else if(collider is Hedgehog) {
						spiked = true;
					}
					else if(collider is Exit) {
						exited = true;
					}
					else if((collider is Bomb) && (collider as Bomb).onFire() && !(collider as Bomb).grounded) {
						continue;
					}
					else if((collider is Bomb) && (this is Hero) && !(this as Hero).bomb.visible) {
						(this as Hero).bomb.visible = true;
						if(collider.currentFrame==1) {
							(this as Hero).bomb.gotoAndStop(1);
						}
						else {
							(this as Hero).bomb.gotoAndPlay(collider.currentFrame);
						}
						(collider.destroy(true))
						continue;
					}
					else if((collider is Carrot) && collider.y>=this.y+bodyHeight()*scaleX) {
						collider.play();
						if(collider.currentLabel=="UP") {
							bounce = true;
						}
					}
					else if(collider is Barrel && collider.y<this.y+bodyHeight()*scaleY) {
						if((collider as Barrel).inwater) {
							(collider as Barrel).mov.x = mov.x;
						}
						else {
							(collider as Barrel).mov.x = mov.x;
							(collider as Barrel).mov.y = mov.y;
						}
					}
					else if(collider is Branch && (collider.y<this.y+bodyHeight()*scaleY)) {
						continue;
					}
					else if(collider is RainbowDuck && (this is Hero) && collider.y<this.y+bodyHeight()*scaleY) {
						(collider as RainbowDuck).mov.x = -mov.x*3;
					}
					else if((collider is Hero) && (this is Bomb) && (this as Bomb).onFire()) {
						continue;
					}
					
					if(collider.y >= this.y+bodyHeight()) {
						grounded = true;
					}
					
					
					return collider;
				}
			}
			var bounds:Rectangle = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
			if(!bounds.containsRect(rect)) {
				if(rect.bottom>stage.stageHeight) {
					grounded = true;
				}
				return boundaries;
			}
			return null;
		}
	}
}

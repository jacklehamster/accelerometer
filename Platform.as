package  {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	public class Platform extends Collider {
		
		
		override public function splashDamage(bomb:Bomb):void {
			var dim:Rectangle = dimensions;
			var center:Point = new Point((dim.left+dim.right)/2,(dim.top+dim.bottom)/2);
			for(var i:int=0;i<5;i++) {
				var brick:Brick = Element.create(Brick) as Brick;
				brick.mov.x = 10*(Math.random()-.5)
				brick.mov.y = -5*Math.random();
				brick.x = center.x + brick.mov.x*scaleX;
				brick.y = center.y + brick.mov.y*scaleY;
				master.addChild(brick);
			}
			destroy(false);
		}
	}
	
}

package entities 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import worlds.GameWorld;
	
	/**
	 * Copyright 2011 The Game Studio (http://www.thegamestudio.net). All rights reserved.
	 * @author Zachary Weston Lewis
	 */
	public class Player extends TickableEntity 
	{
		protected var _image:Image;
		protected var _gridLocation:Point;
		
		public function Player(location:Point) 
		{
			_image = new Image(new BitmapData(16, 16));
			_image.color = 0xABD149;
			
			graphic = _image;
			
			_gridLocation = new Point(location.x, location.y);
			
			x = _gridLocation.x * 16;
			y = _gridLocation.y * 16;
			layer = -1;
			
			setHitbox(16, 16);
		}
		
		override public function update():void 
		{
			super.update();
			if (collide(C.TYPE_ENEMY, x, y) != null)
			{
				for (var i:uint = 0; i < 20; i++)
				{
					GameWorld(world).playRandomNote(C.SCALE_A_MINOR, 10);
					world.remove(this);
				}
			}
		}
		
		public function move(p:Point):void
		{
			var xLoc:int = _gridLocation.x + p.x;
			var yLoc:int = _gridLocation.y + p.y;
			
			var collidingArea:uint = GameWorld(world).Tiles[xLoc][yLoc];
			trace(p, _gridLocation, "Player at:", xLoc, yLoc, "tile value:", collidingArea);
			if (collidingArea == 1)
			{
				// Collided into a wall...
			}
			else 
			{
				if (collidingArea == 3)
				{
					trace("WINNAR!");
				}
				_gridLocation.x = xLoc;
				_gridLocation.y = yLoc;
				
				x = _gridLocation.x * 16;
				y = _gridLocation.y * 16;
			}
			
		}
		
	}

}
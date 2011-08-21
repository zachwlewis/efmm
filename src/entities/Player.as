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
	public class Player extends Entity 
	{
		protected var playerImage:Image;
		
		public function Player() 
		{
			playerImage = new Image(new BitmapData(16, 16));
			playerImage.color = 0xABD149;
			
			graphic = playerImage;
		}
		
		public function move(p:Point):void
		{
			trace(x, y);
			var xLoc:uint = x / 16;
			var yLoc:uint = y / 16;
			trace(xLoc, yLoc);
			var collidingArea:uint = GameWorld(world).Tiles.getIndex(xLoc + p.x, yLoc + p.y)
			trace(collidingArea);
			/*if (collidingArea == 0)
			{
				// Collided into a wall...
			}
			else if (collidingArea == 2)
			{
				trace("WINNAR!");
			}
			else
			{*/
				x += p.x * 16;
				y += p.y * 16;	
			//}
			
		}
		
	}

}
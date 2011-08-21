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
	public class Mover extends TickableEntity 
	{
		
		protected var _image:Image;
		protected var _gridLocation:Point;
		protected var _direction:Point;
		
		public function Mover(p:Point, m:Point) 
		{
			_image = new Image(new BitmapData(16, 16));
			_image.color = 0xD26400;
			
			graphic = _image;
			setHitbox(16, 16);
			
			_direction = m.clone();
			_gridLocation = p.clone();
			
			x = _gridLocation.x * 16;
			y = _gridLocation.y * 16;
			
			type = C.TYPE_ENEMY;
		}
		
		override public function tick():void 
		{
			super.tick();
			
			// Handle x-movement.
			if (GameWorld(world).Tiles[_gridLocation.x + _direction.x][_gridLocation.y] == 0 && !collide(C.TYPE_DOOR,(_gridLocation.x + _direction.x)*16,_gridLocation.y*16))
			{
				_gridLocation.x = _gridLocation.x + _direction.x
			}
			else
			{
				_direction.x *= -1;
			}
			
			// Handle y-movement.
			if (GameWorld(world).Tiles[_gridLocation.x][_gridLocation.y + _direction.y] == 0 && !collide(C.TYPE_DOOR,(_gridLocation.x )*16,(_gridLocation.y+ _direction.y)*16))
			{
				_gridLocation.y = _gridLocation.y + _direction.y
			}
			else
			{
				_direction.y *= -1;
			}
			
			x = _gridLocation.x * 16;
			y = _gridLocation.y * 16;
		}
		
		
		
		
		
	}

}
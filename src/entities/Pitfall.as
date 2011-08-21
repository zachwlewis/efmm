package entities 
{
	import flash.geom.Point;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * Copyright 2011 The Game Studio (http://www.thegamestudio.net). All rights reserved.
	 * @author Zachary Weston Lewis
	 */
	public class Pitfall extends TickableEntity 
	{
		
		protected var _image:Spritemap;
		protected var _openDuration:uint;
		protected var _closedDuration:uint;
		protected var _timer:uint;
		protected var _isOpen:Boolean;
		
		public function Pitfall(p:Point, openDuration:uint, closedDuration:uint, initialDelay:uint, startOpen:Boolean) 
		{
			x = p.x * 16;
			y = p.y * 16;
			setHitbox(16, 16);
			
			_openDuration = openDuration;
			_closedDuration = closedDuration;
			_timer = initialDelay + 1;
			_isOpen = startOpen;
			
			_image = new Spritemap(Assets.GFX_PITFALL, 16, 16);
			
			
			if (_isOpen)
			{
				_image.setFrame(1, 0);
				collidable = true;
			}
			else
			{
				_image.setFrame(0, 0);
				collidable = false;
			}
			
			graphic = _image;
			
			type = C.TYPE_ENEMY;
		}
		
		override public function tick():void 
		{
			super.tick();
			_timer--;
			if (_timer <= 0)
			{
				_isOpen = !_isOpen;
				if (_isOpen)
				{
					collidable = true;
					_image.setFrame(1, 0);
					_timer = _openDuration;
				}
				else
				{
					collidable = false;
					_image.setFrame(0, 0);
					_timer = _closedDuration;
				}
			}	
		}
		
	}

}
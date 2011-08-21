package entities 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * Copyright 2011 The Game Studio (http://www.thegamestudio.net). All rights reserved.
	 * @author Zachary Weston Lewis
	 */
	public class Arrow extends Entity 
	{		
		public function get Direction():Point
		{
			return _direction.clone();
		}
		
		public function get NextArrow():Arrow
		{
			return _nextArrow;
		}
		
		public function set NextArrow(a:Arrow):void
		{
			_nextArrow = a;
		}
		
		public static var LastArrow:Arrow;
		
		protected var _nextArrow:Arrow;
		protected var _direction:Point;
		protected var _image:Image;
		protected var _attachPoint:int;
		protected var _blockType:uint;
		public var Position:Point;
		
		public function get BlockType():uint
		{
			return _blockType;
		}
		
		public function Arrow(ap:int)
		{
			if (LastArrow == null)
			{
				LastArrow = this;
			}
			else
			{
				LastArrow.NextArrow = this;
				LastArrow = this;
			}
			var d:uint;
			var r:Number = Math.random();
			_attachPoint = ap;
			var color:uint = 0xffffff;
			
			// Alright. Let's let all the blocks have a 90% spawn rate.
			
			if (r < 0.9)
			{
				d = FP.rand(4);
				color = C["COLOR_" + d];
				switch(d)
				{
					case 0:
						// up
						_direction = new Point(0, -1);
						break;
					case 1:
						// right
						_direction = new Point(1, 0);
						break;
					case 2:
						// down
						_direction = new Point(0, 1);
						break;
					case 3:
						// left
						_direction = new Point( -1, 0);
						break;
					default:
						// what the fuck
						break;
				}
			}
			else
			{
				// All other blocks.
				d = FP.rand(4) + 4;
			}
			
			_blockType = d;
			
			_image = new Image(Assets.GFX_ARROWS, new Rectangle(d * 12, 0, 12, 12));
			graphic = _image;
			_image.color = color;
			_image.x = 2;
			_image.y = 2;
			
			Position = new Point(_attachPoint + V.ArrowLocation, FP.screen.height - 16);
			
			x = Position.x;
			y = Position.y;
			type = C.TYPE_ARROW;
			setHitbox(12, 12, -2, -2);
		}
		
		public function used():void
		{
			_image.alpha = 0.6;
		}
		
		override public function update():void 
		{
			super.update();
			Position.x = _attachPoint + V.ArrowLocation;
			this.x = Math.floor(Position.x);
			if (this.x < -32)
			{
				world.remove(this);
			}
		}
		
	}

}
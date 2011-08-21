package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * Copyright 2011 The Game Studio (http://www.thegamestudio.net). All rights reserved.
	 * @author Zachary Weston Lewis 
	 */
	public class Door extends Entity
	{
		protected var _id:uint;
		protected var _image:Image;
		
		public function get ID():uint { return _id; }
		
		public function Door(x:int, y:int, id:uint) 
		{
			this.x = x;
			this.y = y;
			_id = id;
			_image = new Image(Assets.GFX_DOOR);
			setHitbox(16, 16);
			_image.color = C["COLOR_" + _id];
			graphic = _image;
			
			type = C.TYPE_DOOR;
		}
		
	}

}
package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * Copyright 2011 The Game Studio (http://www.thegamestudio.net). All rights reserved.
	 * @author Zachary Weston Lewis
	 */
	public class KeyPickup extends Entity 
	{
		protected var _id:uint;
		protected var _image:Image;
		
		public function get ID():uint { return _id; }
		
		public function KeyPickup(x:int, y:int, id:uint) 
		{
			_image = new Image(Assets.GFX_KEY);
			_id = id;
			this.x = x;
			this.y = y;
			
			_image.color = C["COLOR_" + _id];
			
			graphic = _image;
			setHitbox(16, 16);
			
			type = C.TYPE_KEY;
		}
		
	}

}
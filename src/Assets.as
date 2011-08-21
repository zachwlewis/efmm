package  
{
	/**
	 * Copyright 2011 The Game Studio (http://www.thegamestudio.net). All rights reserved.
	 * @author Zachary Weston Lewis
	 */
	public class Assets 
	{
		[Embed(source = '../gfx/arrows.png')] public static const GFX_ARROWS:Class;
		[Embed(source = '../gfx/cursor.png')] public static const GFX_CURSOR:Class;
		[Embed(source = '../gfx/tiles.png')] public static const GFX_TILES:Class;
		[Embed(source = '../gfx/animated-pitfall.png')] public static const GFX_PITFALL:Class;
		[Embed(source = '../gfx/key.png')] public static const GFX_KEY:Class;
		[Embed(source = '../gfx/door.png')] public static const GFX_DOOR:Class;
		
		// Levels
		[Embed(source = '../lvl/t.oel', mimeType = 'application/octet-stream')] public static const LVL_T:Class;
		[Embed(source = '../lvl/1.oel', mimeType = 'application/octet-stream')] public static const LVL_1:Class;
		[Embed(source = '../lvl/2.oel', mimeType = 'application/octet-stream')] public static const LVL_2:Class;
		[Embed(source = '../lvl/3.oel', mimeType = 'application/octet-stream')] public static const LVL_3:Class;
		[Embed(source = '../lvl/4.oel', mimeType = 'application/octet-stream')] public static const LVL_4:Class;
		[Embed(source = '../lvl/5.oel', mimeType = 'application/octet-stream')] public static const LVL_5:Class;
		
		// Level List
		public static const LEVEL:Array = [LVL_T, LVL_1, LVL_2, LVL_3, LVL_4, LVL_5];
	}

}
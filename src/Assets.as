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
		
		// Levels
		[Embed(source = '../lvl/t.oel', mimeType = 'application/octet-stream')] public static const LVL_T:Class;
	}

}
package  
{
	import net.flashpunk.FP;
	import sounds.Note;
	import worlds.GameWorld;
	/**
	 * Copyright 2011 The Game Studio (http://www.thegamestudio.net). All rights reserved.
	 * @author Zachary Weston Lewis
	 */
	public final class V 
	{
		public static var ArrowLocation:Number;
		public static var CurrentLevel:uint;
		
		public static function NextLevel():void
		{
			CurrentLevel++;
			if (CurrentLevel >= Assets.LEVEL.length)
			{
				CurrentLevel = 0;
			}
			FP.world = new GameWorld(Assets.LEVEL[CurrentLevel]);
		}
	}

}
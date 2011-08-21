package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import worlds.GameWorld;

	/**
	 * Copyright 2011 The Game Studio (http://www.thegamestudio.net). All rights reserved.
	 * @author Zachary Weston Lewis
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Engine 
	{

		public function Main():void 
		{
			super(320, 240);
			FP.screen.scale = 2;
		}
		
		override public function init():void 
		{
			super.init();
			trace("FlashPunk " + FP.VERSION + " has started.");
			//FP.console.enable();
			FP.world = new GameWorld(Assets.LVL_2);
		}

	}

}
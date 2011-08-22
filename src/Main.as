package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import worlds.EndWorld;
	import worlds.GameWorld;
	import worlds.TitleWorld;

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
			V.CurrentLevel = 0;
			
		}
		
		override public function init():void 
		{
			super.init();
			trace("FlashPunk " + FP.VERSION + " has started.");
			V.LoadLocalData();
			//FP.console.enable();
			FP.world = new TitleWorld();
			
		}

	}

}
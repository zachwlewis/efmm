package  
{
	import net.flashpunk.FP;
	import net.flashpunk.utils.Data;
	import sounds.Note;
	import worlds.EndWorld;
	import worlds.GameWorld;
	/**
	 * Copyright 2011 The Game Studio (http://www.thegamestudio.net). All rights reserved.
	 * @author Zachary Weston Lewis
	 */
	public final class V 
	{
		public static var ArrowLocation:Number;
		public static var CurrentLevel:uint;
		
		public static var TotalBeats:uint;
		public static var TotalMoves:uint;
		public static var TotalDeaths:uint;
		
		public static function LoadLocalData():void
		{
			trace("Loading local data...");
			
			Data.load("efmm");
			CurrentLevel = Data.readUint("currentLevel", 0);
			TotalBeats = Data.readUint("totalBeats", 0);
			TotalMoves = Data.readUint("totalMoves", 0);
			TotalDeaths = Data.readUint("totalDeaths", 0);
			
			trace("...data loaded: [", CurrentLevel, TotalBeats, TotalMoves, TotalDeaths, "]");
		}
		
		public static function CanContinue():Boolean
		{
			if (CurrentLevel != 0 || TotalBeats != 0 || TotalMoves != 0 || TotalDeaths != 0) return true;
			else return false;
		}
		
		public static function SaveLocalData():void
		{
			trace("Saving local data...");
			Data.writeUint("currentLevel", CurrentLevel);
			Data.writeUint("totalBeats", TotalBeats);
			Data.writeUint("totalMoves", TotalMoves);
			Data.writeUint("totalDeaths", TotalDeaths);
			Data.save("efmm");
			trace("...data saved: [", CurrentLevel, TotalBeats, TotalMoves, TotalDeaths, "]");
		}
		
		public static function ResetData():void
		{
			TotalBeats = 0;
			TotalMoves = 0;
			TotalDeaths = 0;
		}
		
		public static function SubmitData():void
		{
			
		}
		
		public static function NextLevel():void
		{
			CurrentLevel++;
			var levelString:String;
			if (CurrentLevel == 0)
			{
				levelString = "T"
			}
			else
			{
				levelString = CurrentLevel.toString();
			}
			if (Assets["LVL_" + levelString] == null)
			{
				FP.world = new EndWorld();
			}
			else
			{
				FP.world = new GameWorld(Assets["LVL_" + levelString]);
			}
		}
		
		public static function SetLevel(level:int):void
		{
			CurrentLevel = level - 1;
			NextLevel();
		}
	}

}
package worlds 
{
	import entities.SoundEntity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * Copyright 2011 The Game Studio (http://www.thegamestudio.net). All rights reserved.
	 * @author Zachary Weston Lewis
	 */
	public class EndWorld extends World 
	{
		protected var _timer:Number;
		public function EndWorld() 
		{
			_timer = 0.8;
		}
		
		override public function begin():void 
		{
			addGraphic(new Text("You have escaped Music Manor!\nTotal Deaths: " + V.TotalDeaths + "\nTotal Moves: " + V.TotalMoves + "\nTotal Beats: " + V.TotalBeats + "\n\n\nEscape to Continue", 0, 80, { align:"center", width:320, size:8 } ));
			V.SubmitData();
			V.ResetData();
			V.SaveLocalData();
			super.begin();
		}
		
		override public function update():void 
		{
			soundLoop();
			if (Input.pressed(Key.ESCAPE))
			{
				FP.world = new TitleWorld();
				clickSound();
			}
			super.update();
		}
		
		protected function soundLoop():void
		{
			_timer -= FP.elapsed;
			if (_timer < 0)
			{
				_timer += 0.8;
				playRandomNote(C.SCALE_A_MAJOR);				
			}
		}
		
		public function playRandomNote(scale:Array = null, duration:Number = 0):void
		{
			add(new SoundEntity(FP.choose(scale) * Math.pow(2, FP.rand(3)), duration, 0.5));
		}
		
		public function clickSound():void
		{
			add(new SoundEntity(C.SCALE_A_MAJOR[0], 0, 0.5));
			add(new SoundEntity(C.SCALE_A_MAJOR[1], 0, 0.5));
			add(new SoundEntity(C.SCALE_A_MAJOR[2], 0, 0.5));
		}
		
		override public function end():void 
		{
			removeAll();
			super.end();
		}
		
	}

}
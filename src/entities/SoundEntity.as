package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import sounds.Note;
	
	/**
	 * Copyright 2011 The Game Studio (http://www.thegamestudio.net). All rights reserved.
	 * @author Zachary Weston Lewis
	 */
	public class SoundEntity extends Entity 
	{
		protected var _note:Note;
		protected var _duration:Number;
		
		public function SoundEntity(p:Number, t:Number, v:Number) 
		{
			_note = new Note(p);
			
			_duration = t;
			_note.Volume = v;
		}
		
		override public function added():void 
		{
			_note.play();
			super.added();
		}
		
		override public function update():void 
		{
			_duration -= FP.elapsed;
			if (_duration <= 0)
			{
				world.remove(this);
			}
			super.update();
			
		}
		
		override public function removed():void 
		{
			_note.stop();
			super.removed();
		}
		
	}

}
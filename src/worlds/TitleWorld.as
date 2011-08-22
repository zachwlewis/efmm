package worlds 
{
	import entities.SoundEntity;
	import flash.net.URLRequest;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	import flash.net.navigateToURL;
	
	/**
	 * Copyright 2011 The Game Studio (http://www.thegamestudio.net). All rights reserved.
	 * @author Zachary Weston Lewis
	 */
	public class TitleWorld extends World 
	{
		
		protected var _new:Entity;
		protected var _title:Entity;
		protected var _continue:Entity;
		protected var _url:Entity;
		protected var _note:Entity;
		protected var _timer:Number;
		
		public function TitleWorld() 
		{
			
		}
		
		override public function begin():void 
		{
			_url = addGraphic(new Text("Created by Zachary Lewis for Ludum Dare 21\nCopyright The Game Studio 2011", 0, FP.screen.height - 19, { width:320, size:8, align:"center" } ));
			_new = addGraphic(new Image(Assets.GFX_NEW));
			_continue = addGraphic(new Image(Assets.GFX_CONTINUE));
			_continue.setHitboxTo(_continue.graphic);
			_note = addGraphic(new Image(Assets.GFX_NOTE));
			_new.setHitboxTo(_new.graphic);
			
			_url.setHitboxTo(_url.graphic);
			
			_title = addGraphic(new Image(Assets.GFX_TITLE));
			_title.setHitboxTo(_title.graphic);
			_title.graphic.x = -226/2;
			_title.graphic.y = -15;
			
			
			_title.x = FP.screen.width / 2;
			_title.y = 40;
			
			
			_new.x = FP.screen.width / 2 - _new.halfWidth;
			_new.y = 120;
			
			_continue.x = FP.screen.width / 2 - _continue.halfWidth;
			_continue.y = _new.y + 16;
			
			_timer = 0.8;
			
			_continue.visible = V.CanContinue();
			_note.y = 10000;
			super.begin();
		}
		
		protected function soundLoop():void
		{
			_timer -= FP.elapsed;
			if (_timer < 0)
			{
				_timer += 0.8;
				playRandomNote(C.SCALE_A_MINOR);				
			}
		}
		
		public function playRandomNote(scale:Array = null, duration:Number = 0):void
		{
			add(new SoundEntity(FP.choose(scale) * Math.pow(2,FP.rand(3)), duration, 0.5));
		}
		
		public function clickSound():void
		{
			add(new SoundEntity(C.SCALE_A_MINOR[0], 0, 0.5));
			add(new SoundEntity(C.SCALE_A_MINOR[1], 0, 0.5));
			add(new SoundEntity(C.SCALE_A_MINOR[2], 0, 0.5));
		}
		
		override public function update():void 
		{
			soundLoop();
			_note.y = 10000;
			Text(_url.graphic).alpha = 0.5;
			if (_new.collidePoint(_new.x, _new.y, Input.mouseX, Input.mouseY))
			{
				_note.x = _new.x - 10;
				_note.y = _new.y - 1;
			}
			
			if (_continue.visible && _continue.collidePoint(_continue.x, _continue.y, Input.mouseX, Input.mouseY))
			{
				_note.x = _continue.x - 10;
				_note.y = _continue.y - 1;
			}
			
			if ( _url.collidePoint(_url.x, _url.y, Input.mouseX, Input.mouseY))
			{
				Text(_url.graphic).alpha = 1;
			}
			
			if (Input.mouseDown)
			{
				// We've clicked.
				if (_continue.visible && _continue.collidePoint(_continue.x, _continue.y, Input.mouseX, Input.mouseY))
				{
					V.LoadLocalData();
					V.SetLevel(V.CurrentLevel);
					clickSound();
				}
				
				if (_new.collidePoint(_new.x, _new.y, Input.mouseX, Input.mouseY))
				{
					V.ResetData();
					V.SetLevel(0);
					clickSound();
				}
				
				if ( _url.collidePoint(_url.x, _url.y, Input.mouseX, Input.mouseY))
				{
					var request:URLRequest = new URLRequest("http://www.thegamestudio.net");
					try
					{
						navigateToURL(request, '_blank');
					} catch (e:Error) { }
					clickSound();
				}
			}
			super.update();
		}
		
		override public function end():void 
		{
			removeAll();
			super.end();
		}
		
	}

}
package worlds 
{
	import entities.Arrow;
	import entities.Mover;
	import entities.Player;
	import entities.TickableEntity;
	import flash.filters.ConvolutionFilter;
	import flash.geom.Point;
	import flash.media.Sound;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import sounds.Note;
	
	/**
	 * Copyright 2011 The Game Studio (http://www.thegamestudio.net). All rights reserved.
	 * @author Zachary Weston Lewis
	 */
	public class GameWorld extends World 
	{
		protected var _lastNote:Number;
		protected var _currentScale:Array;
		protected var _currentTime:Number;
		protected var _bpm:Number;
		protected var _bassline:Note;
		protected var _player:Player;
		protected var _cursor:Image;
		protected var _cursorArmed:Boolean;
		protected var _arrowCount:uint;
		protected var _tiles:Tilemap;
		protected var _grid:Vector.<Vector.<uint>>;
		
		public function get Tiles():Vector.<Vector.<uint>>
		{
			return _grid;
		}
		
		public function GameWorld(map:Class) 
		{
			_bpm = 120;
			_currentTime = 0;
			_currentScale = C.SCALE_A_MINOR;
			_cursorArmed = false;
			_lastNote = 0;
			_bassline = new Note(_currentScale[0]);
			_bassline.Volume = 0.2;
			_cursor = new Image(Assets.GFX_CURSOR);
			_cursor.alpha = 0.8;
			Input.define(C.KEY_ACTION, [Key.ESCAPE]);
			loadLevel(map);
			V.ArrowLocation = 0;
			_arrowCount = 0;
		}
		
		override public function begin():void 
		{
			super.begin();
			add(_player);
			for (var i:uint = 0; i <= FP.screen.width; i += 16)
			{
				var a:Arrow = Arrow(add(new Arrow(GetNextArrowLocation())));				
			}
			addGraphic(_tiles,0,0,0);
			addGraphic(_cursor, -1, 64, FP.screen.height - 16);
		}
		
		override public function update():void 
		{
			super.update();
			
			_currentTime += FP.elapsed;
			V.ArrowLocation -= FP.elapsed * ArrowSpeed;
			if (_currentTime > SecondsPerBeat)
			{
				tick();
				_currentTime -= SecondsPerBeat;
			}
			
			if (Input.pressed(C.KEY_ACTION))
			{
				// Arm our zapper.
				_cursor.color = 0xE12DDD;
				_cursor.alpha = 1;
				_cursorArmed = true;				
			}
		}
		
		protected function tick():void
		{
			var arrows:Vector.<Arrow> = new Vector.<Arrow>();
			_bassline.play(SecondsPerBeat * 0.1);
			addArrow();
			var ta:Vector.<TickableEntity> = new Vector.<TickableEntity>();
			getClass(TickableEntity, ta);
			for each(var e:TickableEntity in ta)
			{
				e.tick()
			}
			// We need to update our enemies.
			if (_cursorArmed)
			{
				// Alright! We're going to fire off the move command, and play a note.
				playRandomNote(_currentScale);
				_cursor.color = 0xffffff;
				_cursor.alpha = 0.8;
				_cursorArmed = false;
				
				
				
				// Get the fired thing.
				var a:Arrow = Arrow(this.collidePoint(C.TYPE_ARROW, 72, FP.screen.height - 8));
				if (a != null)
				{
					a.used();
					_player.move(a.Direction);
				}
			}
		}
		
		public function playRandomNote(scale:Array, duration:Number = 0.25):void
		{
			var keypressSound:Note;
			keypressSound = new Note(FP.choose(scale));
			keypressSound.play(duration);
		}
		
		protected function get SecondsPerBeat():Number
		{
			return 60 / _bpm;
		}
		
		protected function get ArrowSpeed():Number
		{
			return 16 / SecondsPerBeat;
		}
		
		protected function addArrow():void
		{
			add(new Arrow(GetNextArrowLocation()));
		}
		
		protected function GetNextArrowLocation():int
		{
			return _arrowCount++ * 16;
		}
		
		protected function loadLevel(map:Class):void
		{
			var xml:XML = FP.getXML(map);
			var o:XML;
			_tiles = new Tilemap(Assets.GFX_TILES, uint(xml.width), uint(xml.height), 16, 16);
			_grid = new Vector.<Vector.<uint>>();
			for (var i:uint = 0; i < 20; i++)
			{
				_grid[i] = new Vector.<uint>();
				for (var j:uint = 0; j < 14; j++)
				{
					_grid[i][j] = 0;
				}
			}
			for each(o in xml.tiles.tile)
			{
				var tileCol:uint = uint(o.@x)/16;
				var tileRow:uint = uint(o.@y)/16;
				var tileType:uint = uint(o.@tx / 16);
				if (tileCol >= 0 && tileCol < 20 && tileRow >= 0 && tileRow < 14)
				{
					_tiles.setTile(tileCol, tileRow, tileType);
					_grid[tileCol][tileRow] = tileType + 1;
				}
			}
			
			for each(o in xml.actors.mover)
			{
				add(new Mover(new Point(uint(o.@x) / 16, uint(o.@y) / 16), new Point(int(o.@horizontal), int(o.@vertical))));
			}
			
			_player = new Player(new Point(uint(xml.actors.player.@x)/16, uint(xml.actors.player.@y)/16));
		}		
	}

}
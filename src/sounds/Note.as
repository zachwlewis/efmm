package sounds
{
	import flash.events.EventDispatcher;
	import flash.events.SampleDataEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.Event;
	import flash.utils.Timer;
	
	public class Note {
		
		static public var C5:Number = 523.25;
		static public var D5:Number = 587.33;
		static public var E5:Number = 659.26;
		static public var F5:Number = 698.46;
		static public var G5:Number = 783.99;
		static public var A5:Number = 880.00;
		static public var B5:Number = 987.77;
		static public var C6:Number = 1046.50;
		static public var D6:Number = 1174.66;
		static public var E6:Number = 1318.51;
		static public var F6:Number = 1396.91;
		
		static public const SAMPLE_RATE:int    = 44100;
		static public const BUFFER_SIZE:int    = 4096;
		static public const WAVELET_SIZE:int   = 2048;
		static public const BASE_FREQ:Number   = ( SAMPLE_RATE / WAVELET_SIZE );
		static public const PI_2:Number        = Math.PI * 2;
		static public const PI_2_OVR_SR:Number = PI_2 / SAMPLE_RATE;
		
		protected var _sound:Sound;
		protected static var _channel:SoundChannel;
		
		protected var _frequency:Number = 240;
		protected var _mainVolume:Number;
		protected var _step:Number;
		protected var _wavelet:Vector.<Number>;
		
		protected var _amplitude      :Number = 1;
		protected var _pulsewidthlow  :Number = Math.PI + .9;
		protected var _pwmamp         :Number = 0;
		protected var _pulsewidthhigh :Number = Math.PI - .9;
		protected var _pwmspeed       :Number = 0x1200 * .5;
		protected var _ampmodspeed    :Number = 0x1000 * 1;
		protected var _pwmphase       :Number = 0;
		protected var _sqrphase       :Number = 0;
		protected var _sqramp         :Number = 0;
		protected var _sineamp        :Number = 0.5;
		protected var _distortion     :Number = 0;
		protected var _sawamp         :Number = 0;
		protected var _sawphase       :Number = 0;
		protected var _triangleamp    :Number = 0;
		protected var _trianglephase  :Number = 0;
		protected var _noiseamp       :Number = 0;
		protected var pa              :Number = 0; 
		
		public function set Volume(value:Number):void
		{
			_mainVolume = value;
		}
		
		public function get Volume():Number
		{
			return _mainVolume;
		}
		
		public function Note(frequency:Number = 523.25):void {
			_frequency = frequency;
			_sound = new Sound();
			_mainVolume = 0.8;
			_wavelet = new Vector.<Number>(WAVELET_SIZE);
			updateStep();
			updateWavelet();	
		}
		
		public function play():void {
			_sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			_channel = _sound.play();
		}
		
		public function stop():void
		{
			_sound.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData );
			_channel = null;
		}
		
		protected function updateStep():void {
			_step = ( _frequency / SAMPLE_RATE ) * WAVELET_SIZE;
		}
		
		protected function updateWavelet( ):void {
			var xpos:Number = 5;
			var ypos:Number = 210;
			var renderw:int = 610;
			var linesize:Number = renderw / WAVELET_SIZE;
			var waveheight:Number = 50;
			
			_wavelet.slice( 0 );
			
			var i:int = 0;
			
			for ( i; i < WAVELET_SIZE; i++ ) {
				var sample:Number;
				var sinewave:Number = sine(i);
				var pwm:Number = pulseWaveMod(i);
				
				sample = sinewave + saw() + square() + pwm + triangle() + noise();
				
				sample = distort( sample );
				
				sample = sample > 1  ? 1 : sample;
				sample = sample < -1 ? -1 : sample;
				
				_wavelet[i] = sample;
				sample = _wavelet[i];
			}
		}
		
		protected function pulseWaveMod( index:Number ):Number {
			var pulsewidth:Number;
			var ampmod:Number;
			var sample:Number;
			
			pulsewidth = Math.sin ( index / 0x5 ) * _pulsewidthhigh + _pulsewidthlow;
			sample = 1 + ( _pwmphase < pulsewidth ? _amplitude : -_amplitude );
			_pwmphase = _pwmphase + ( PI_2_OVR_SR * BASE_FREQ );
			_pwmphase = _pwmphase > ( PI_2 ) ? _pwmphase - ( PI_2 ) : _pwmphase;
			ampmod = Math.sin ( index / ( 10 +_ampmodspeed ) );
			
			return sample * ampmod * _pwmamp;
		}
		
		protected function sine( index:int ):Number {
			return Math.sin( Math.PI * 2 * BASE_FREQ * ( index ) / SAMPLE_RATE ) * _sineamp;
		}
		
		
		private function square():Number {
			var sample:Number = _sqrphase < Math.PI ? _sqramp : -_sqramp;
			
			_sqrphase += (PI_2 * BASE_FREQ ) / SAMPLE_RATE;
			_sqrphase = _sqrphase > PI_2 ? _sqrphase - PI_2 : _sqrphase;
			
			return sample * _sqramp;
		}
		
		protected function distort( sample:Number ):Number {
			sample = 1 * sample - _distortion * sample * sample * sample;
			return sample;
		}
		
		private function saw():Number {
			var amp:Number = 1;
			var sample:Number;
			
			sample = amp - (amp / Math.PI) * _sawphase;
			_sawphase = _sawphase + ( ( PI_2 * BASE_FREQ) / SAMPLE_RATE );
			_sawphase =  _sawphase < PI_2 ? _sawphase : _sawphase - PI_2; 
			
			return sample * _sawamp;
		}
		
		protected function triangle():Number {
			var amp:Number = 1;
			var sample:Number;
			
			if( _trianglephase < Math.PI ) {
					sample = -amp + ( 2 * amp / Math.PI ) * _trianglephase;
			} else {
					sample = ( 3 * amp ) - ( 2 * amp / Math.PI ) * _trianglephase;
			}
			
			_trianglephase = _trianglephase + ( ( PI_2 * BASE_FREQ ) / SAMPLE_RATE );
			_trianglephase = _trianglephase > ( PI_2 )  ? _trianglephase - PI_2 : _trianglephase;
			
			return sample * _triangleamp;
		}
		
		private function noise():Number {
			var n:Number = -1 + 2 * Math.random();
			return Math.random() * _noiseamp * .2;
		}
		
		protected function onSampleData( event:SampleDataEvent ):void {
			var i:int;
			for ( i = 0; i < BUFFER_SIZE; i++) {
				var sample:Number = _wavelet[ pa ];
				sample *= _mainVolume;
				event.data.writeFloat( sample );
				event.data.writeFloat( sample );
				pa = Math.round( pa + _step < _wavelet.length - 1 ? pa + _step : 0 );
			}
		}
	}
}
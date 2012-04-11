package
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.VideoLoader;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.SampleDataEvent;
	import flash.events.StatusEvent;
	import flash.media.Microphone;
	import flash.system.Security;
	
	public class FrozingGame extends MovieClip
	{
		protected var _bg:background_mc =  new background_mc();
		protected var _boutle:BoutleMovie =  new BoutleMovie();
		protected var _thermometer:Thermometer =  new Thermometer();
		
		private var _intensity:Number = .2;
		protected var _mic:Microphone;
		
		private static var _instance:FrozingGame =  new FrozingGame();
		
		public function FrozingGame()
		{
			super();
		}
		public function startMicrofon():void{
			_mic = Microphone.getMicrophone();
			//						_mic.setLoopBack();
			Security.showSettings("2");
			_mic.addEventListener(StatusEvent.STATUS, microfonStatus);
		}
		public function init():void{
			addChild(_bg)
			addChild(_boutle)
			_boutle.init();
			addChild(_thermometer);
			startMicrofon();
			startRecord();
			
		}
		private function startRecord():void{
			trace("start microfon");
			_mic.addEventListener(SampleDataEvent.SAMPLE_DATA, micSampleDataHandler);
		}
		private function micSampleDataHandler(event:SampleDataEvent):void
		{
//			trace(event.data.readFloat());
			var loud:Number = event.data.readFloat();
			if(loud > _intensity || loud < (_intensity*(-1))){
				_boutle.playAnimation();
				_thermometer.moveThermometr(_boutle.getProgress());
				if(_boutle.getProgress()>=1){
					trace("koniec");
					_mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, micSampleDataHandler);
				}
			}
			else
				_boutle.pauseAnimation();
		}
		private function microfonStatus(e:StatusEvent):void{
			if(e.code == "Microphone.Unmuted"){
				trace("unmunted");
			}
			else{
				trace("unmunted");}
			trace(e.code);
		}
		public static function instance():FrozingGame
		{
			return _instance;
		}
		
		
	}
}
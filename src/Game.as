package
{
	import com.greensock.TweenLite;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.VideoLoader;
	
	import controllers.Data;
	
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.events.StatusEvent;
	import flash.media.Microphone;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Security;
	
	public class Game extends MovieClip
	{
		protected var _bg:background_mc =  new background_mc();
		protected var _boutle:Boutle =  new Boutle();
		protected var _thermometer:Thermometer =  new Thermometer();
		
		private var _intensity:Number = .2;
		protected var _mic:Microphone;
		protected var _froze_over:Boolean =  false;
		
		private static var _instance:Game =  new Game();
		protected var _data:Data =  new Data();
		
		public function Game()
		{
			super();
		}
		
		public function init():void{
			getFlashvars();
			addObjects();
		}
		private function getFlashvars():void{
			root.loaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
		}
		private function loaderComplete(myEvent:Event):void {
			var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;
			if ((paramObj['gameId'] != undefined)) {
				_data.gameId = paramObj['gameId']
			} else {
				_data.gameId = '199';
			}
			
		}
		private function addObjects():void{
			addChild(_bg)
			addChild(_boutle)
			_boutle.init();
			addChild(_thermometer);
			startMicrofon();
		}
		public function startMicrofon():void{
			_mic = Microphone.getMicrophone();
			_mic.setLoopBack();
			Security.showSettings("2");
			_mic.addEventListener(StatusEvent.STATUS, microfonStatus);
		}
		private function startRecord():void{
			_mic.addEventListener(SampleDataEvent.SAMPLE_DATA, micSampleDataHandler);
		}
		private function micSampleDataHandler(event:SampleDataEvent):void
		{
			var loud:Number = event.data.readFloat();
			if(loud > _intensity || loud < (_intensity*(-1))){
				_boutle.playAnimation();
				_thermometer.moveThermometr(_boutle.getProgress());
				if(_boutle.getProgress()==1){
					if(!_froze_over){
						_froze_over =  true;
						TweenLite.delayedCall(3,frozeOver);
					}
				}
			}
			else
				_boutle.pauseAnimation();
		}
		private function frozeOver():void{
			_data.sendPost();
			_mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, micSampleDataHandler);
			
		}
		private function microfonStatus(e:StatusEvent):void{
			if(e.code == "Microphone.Unmuted"){
				startRecord();
			}
			else{
				_mic.removeEventListener(StatusEvent.STATUS, microfonStatus);
				TweenLite.delayedCall(2,startMicrofon);
			}
		}
		public static function instance():Game
		{
			return _instance;
		}
		
		
	}
}
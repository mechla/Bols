package stare
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	
	import controllers.Data;
	import controllers.XMLLoader;
	
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.events.StatusEvent;
	import flash.media.Microphone;
	import flash.system.Security;
	import flash.utils.setTimeout;
	
	
	
	
	public class Boutle extends MovieClip
	{
		protected var _imageLoader:LoaderMax = new LoaderMax({name:"imageLoader",onProgress:progressHandler,onComplete:completeHandler, onError:errorHandler});
		protected var _boutle_frozen_loader:ImageLoader = new ImageLoader("assets/butelka_zamrozona.png",{name:"boutle_frozen",container:this,alpha:0, width:408,heigh:463});
		protected var _boutle_frizing_loader:ImageLoader = new ImageLoader("assets/butelka_mrozi_sie.png",{name:"boutle_frizing",container:this,alpha:0, width:408,heigh:463});
		protected var _boutle_normal_loader:ImageLoader = new ImageLoader("assets/butelka_niezamrozona.png",{name:"boutle_normal",container:this,alpha:0, width:408,heigh:463});
		protected var _boutle_frozen:Sprite =  new Sprite();
		protected var _boutle_frizing:Sprite =  new Sprite();
		protected var _boutle_normal:Sprite =  new Sprite();
		protected var _boutle_frizing_alpha:Number = 0;
		protected var _boutle_frozen_alpha:Number = 0;
		private var _intensity:Number;
		private var _alpha_add:Number;
		private var _froze_delay:Number;
		
		protected var _xmlLoad:XMLLoader =  new XMLLoader();
		
		protected var _alert:microfon_alert =  new microfon_alert();
		
		protected var _mic:Microphone;
		protected var _loaders:Number = 2;
		
		protected var _data:Data =  new Data();
		
		protected var _bg:background_mc =  new background_mc();
		protected var _thermometr:Thermometer =  new Thermometer();
		
		private static var _instance:Boutle =  new Boutle();
		

		public function Boutle()
		{
			super();
		}
		public function init():void{
			getFlashvars();
			_imageLoader.append(_boutle_frozen_loader);
			_imageLoader.append(_boutle_frizing_loader);
			_imageLoader.append(_boutle_normal_loader);
			_imageLoader.load();
			
			_mic = Microphone.getMicrophone();
			trace(_mic);
			//						_mic.setLoopBack();
			Security.showSettings("2");
			_mic.addEventListener(StatusEvent.STATUS, microfonStatus);
			
		}
		private function addThermometr():void{
			addChild(_bg);
			addChild(_thermometr);
		}
//		public function addBoutle():void{
//			addThermometr();
//			_loaders--;
//			trace(_loaders);
//			if(_loaders == 0 ){
//				trace(_intensity,_alpha_add,_froze_delay);
//				_boutle_normal.alpha = 0;
//				_boutle_frizing.alpha = 0;
//				_boutle_frozen.alpha = 0;
//				_imageLoader.getContent("boutle_normal").alpha = 1;
//				_imageLoader.getContent("boutle_frizing").alpha = 1;
//				_imageLoader.getContent("boutle_frozen").alpha = 1;
//				_boutle_normal.addChild(_imageLoader.getContent("boutle_normal"));
//				_boutle_frizing.addChild(_imageLoader.getContent("boutle_frizing"));
//				_boutle_frozen.addChild(_imageLoader.getContent("boutle_frozen"));
//				
////				addChild(_boutle_normal);
////				addChild(_boutle_frizing);
////				addChild(_boutle_frozen);
//				TweenLite.to(_boutle_normal,1.5,{alpha:1, ease:Sine.easeIn});
//				startMicrofon();
//			}
//		}
		
		private function startMicrofon():void{
			trace("start microfon");
			_mic.addEventListener(SampleDataEvent.SAMPLE_DATA, micSampleDataHandler);
		}
		private function micSampleDataHandler(event:SampleDataEvent):void
		{
			trace(event.data.readFloat());
			var loud:Number = event.data.readFloat();
			if(loud > _intensity || loud < (_intensity*(-1))){
				setTimeout(frouzeBoutle,_froze_delay*1000);
			}
		}
		private function frouzeBoutle():void{
			if(_boutle_frizing_alpha<1){
				_boutle_frizing_alpha = _boutle_frizing_alpha+_alpha_add;
				trace(_boutle_frizing_alpha);
				_boutle_frizing.alpha = _boutle_frizing_alpha;
			}
			else{
				if(_boutle_frozen_alpha<1){
					_boutle_frozen_alpha = _boutle_frozen_alpha+_alpha_add;
					trace(_boutle_frozen_alpha);
					_boutle_frozen.alpha = _boutle_frozen_alpha;
				}
				else{
					trace("KONIEC");
					_mic.removeEventListener(StatusEvent.STATUS, microfonStatus);
					_mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, micSampleDataHandler);
					_data.sendWin();
				}
			}
			
		}
		private function microfonStatus(e:StatusEvent):void{
			if(e.code == "Microphone.Unmuted"){
				trace("unmunted");
				hideAlert();
			}
			else
				showAlert()
			trace(e.code);
		}
		
		private function getFlashvars():void{
			root.loaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
		}
		private function loaderComplete(myEvent:Event):void {
			trace("root.loaderInfoCompleted");
			var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;
			if ((paramObj['gameId'] != undefined)) 
				_data.gameId = paramObj['gameId']
			_data.sendGameId();
			
		}
		private function showAlert():void{
			if(_alert.parent ==null)
				addChild(_alert);
			
		}
		private function hideAlert():void{
			if(_alert.parent !=null)
				removeChild(_alert);
			
		}
		private function completeHandler(e:LoaderEvent):void{
			trace("IMAGE COMPLETED DOWNLOAD!");
//			addBoutle();
		}
		
		private function errorHandler(e:LoaderEvent):void{
			trace("error occured" + e.text);
		}
		private function progressHandler(e:LoaderEvent):void{
		}
		public function set froze_delay(value:Number):void
		{
			_froze_delay = value;
		}
		
		public function set alpha_add(value:Number):void
		{
			_alpha_add = value;
		}
		
		public function set intensity(value:Number):void
		{
			_intensity = value;
		}
		
		public static function instance():Boutle
		{
			return _instance;
		}
	}
}
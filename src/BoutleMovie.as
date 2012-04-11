package
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.VideoLoader;
	
	import flash.display.Sprite;
	
	public class BoutleMovie extends Sprite
	{
		
		protected var _videoLoader:LoaderMax = new LoaderMax({name:"videoLoader",onProgress:progressHandler,onComplete:completeHandler, onError:errorHandler});
		protected var _boutle:Sprite =  new Sprite();
		protected var _boutle_video:VideoLoader = new VideoLoader("assets/boutle.flv",{name:"boutle_video",autoplay:false,container:_boutle});
		
		protected var _play_count:Number = 0;
		protected var _pause_count:Number = 0;
		
		
		public function BoutleMovie()
		{
			super();
		}
		public function init():void{
			
			_boutle.x =  370;
			_boutle.y = 100;
			addChild(_boutle);
			_videoLoader.append(_boutle_video);
			_videoLoader.load()
		}
		//duration   playProgress 
		public function playAnimation():void{
			_play_count++;
			if(_boutle_video.videoPaused){
				_boutle_video.playVideo(null);
			}
			
		}
		public function getProgress():Number{
			return _boutle_video.playProgress
		}
		public function pauseAnimation():void{
			_pause_count++;
			if(_pause_count > 30){
				_pause_count=0;
				if(!_boutle_video.videoPaused) {
					_boutle_video.pauseVideo(null);
				}
			}
		}
		
		private function completeHandler(e:LoaderEvent):void{
			_boutle_video.playVideo(null);
			_boutle_video.pauseVideo(null);
			trace("VIDEO COMPLETED DOWNLOAD!");
			//			_boutle_video.playVideo(null);
		}
		
		private function errorHandler(e:LoaderEvent):void{
			trace("error occured" + e.text);
		}
		private function progressHandler(e:LoaderEvent):void{
		}
		
	}
}
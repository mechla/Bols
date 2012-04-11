package controllers 
{
	import com.greensock.easing.Bounce;
	import com.greensock.loading.XMLLoader;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import stare.Boutle;
	
	public class XMLLoader
	{
		private var _urlRequest:URLRequest =  new URLRequest("assets/variables.xml");
		private var _loader:URLLoader =  new URLLoader();
		private var _xmlData:XML;
		public function XMLLoader()
		{
			init();
		}
		public function init():void{
			_loader.load(_urlRequest);
			_loader.addEventListener(Event.COMPLETE, onLoaderComplete);
		}
		public function get xmlData():XML
		{
			return _xmlData;
		}
		private function onLoaderComplete(e:Event):void{
			_xmlData =   new XML(_loader.data);
			Boutle.instance().alpha_add = _xmlData.attribute("alpha_jump")
			Boutle.instance().intensity = _xmlData.attribute("sound_intensity")
			Boutle.instance().froze_delay = _xmlData.attribute("froze_delay")
			Boutle.instance().addBoutle();
		}
	}
}

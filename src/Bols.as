package
{
	import com.adobe.protocols.dict.events.ErrorEvent;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.UncaughtErrorEvent;
	import flash.system.Security;

	[SWF(width='605',height='646',frameRate='25')]
	public class Bols extends Sprite
	{
		private var _boutle:Game;
		
		Security.allowDomain('*');
		public function Bols() 
		{
			super();
			if(this.stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		private function init(...args):void{
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtErrorHandler);
			this.addEventListener(ErrorEvent.ERROR,errorHandler);
			
			addChild(Game.instance());
			Game.instance().init();
		}
		private function uncaughtErrorHandler(event:UncaughtErrorEvent):void
		{
			throw new Error("wywołuje UncaughtErrorEvent");
		}
		private function errorHandler(evt:Error):void
		{
			throw new Error(" wywołuje Error ");
			
		}
	}
}
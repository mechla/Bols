package
{
	import flash.display.MovieClip;
	
	public class Thermometer extends MovieClip
	{
		protected var _thermometer:thermometer  = new thermometer();
		public function Thermometer()
		{
			super();
			addThermometr();
		}
		private function addThermometr():void{
			_thermometer.x = 63;
			_thermometer.y =  210;
			_thermometer.znacznik0.visible = false;
			_thermometer.znacznik50.visible =  false;
			_thermometer.znacznik100.visible =  false;
			addChild(_thermometer);
		}
		
		public function moveThermometr(size:Number):void{
			trace(size);
			_thermometer.maska.scaleY = 1-size;
		}
	}
}
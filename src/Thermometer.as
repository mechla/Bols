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
			_thermometer.x = 23;
			_thermometer.y =  180;
			_thermometer.znacznik0.visible = true;
			_thermometer.znacznik50.visible =  false;
			_thermometer.znacznik100.visible =  false;
			_thermometer.maska.scaleY =  0;
			addChild(_thermometer);
		}
		
		public function moveThermometr(size:Number):void{
			trace(size);
			_thermometer.maska.scaleY =  size;
			if(size >= .5 && size < .55)
				_thermometer.znacznik50.visible =  true;
			if(size>=1)
				_thermometer.znacznik100.visible =  true;
			
		}
	}
}
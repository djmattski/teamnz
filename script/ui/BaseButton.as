package script.ui
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class BaseButton
	{
		protected var _container:MovieClip;
		
		public function BaseButton(container:MovieClip)
		{
			_container = container;
			_container.mouseChildren = false;
			_container.mouseEnabled = false;
		}
		
		public function enable():void
		{
			_container.mouseEnabled = true;
			_container.buttonMode = true;
			_container.addEventListener(MouseEvent.ROLL_OVER, onOver);
			_container.addEventListener(MouseEvent.ROLL_OUT, onOut);
		}
		
		public function disable():void
		{
			_container.mouseEnabled = false;
			_container.buttonMode = false;
			_container.removeEventListener(MouseEvent.ROLL_OVER, onOver);
			_container.removeEventListener(MouseEvent.ROLL_OUT, onOut);
		}
		
		public function onOver(e:MouseEvent = null):void
		{
			_container.gotoAndStop(2);
		}
		
		public function onOut(e:MouseEvent = null):void
		{
			_container.gotoAndStop(1);
		}
		
		public function get content():MovieClip
		{
			return _container;
		}
	}
}
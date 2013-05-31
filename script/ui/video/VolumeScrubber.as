package script.ui.video
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import script.ui.BaseButton;
	
	public class VolumeScrubber extends EventDispatcher
	{
		public static const VOLUME_UPDATED:String = 'volumeUpdated';
		
		protected var _container:MovieClip;
		
		private var _button:BaseButton;
		private var _bar:MovieClip;
		private var _bg:MovieClip;
		
		private var _bounds:Rectangle;
		private var _scrubbing:Boolean;
		
		public function VolumeScrubber(container:MovieClip)
		{
			_container = container;
			_bar = _container.bar;
			_bg = _container.bg;
			
			_button = new BaseButton(_container.button);
			
			_bounds = new Rectangle(_button.content.width / 2, 0, _bg.width - _button.content.width, 0);
			_scrubbing = false;
		}
		
		public function enable():void
		{
			_button.content.addEventListener(MouseEvent.MOUSE_DOWN, buttonSelected);
			_button.enable();
		}
		
		public function disable():void
		{
			_button.content.removeEventListener(MouseEvent.MOUSE_DOWN, buttonSelected);
			_button.disable();
		}
		
		public function get isScrubbing():Boolean
		{
			return _scrubbing;
		}
		
		public function get value():Number
		{
			return (_button.content.x - _bounds.x) / _bounds.width;
		}
		
		public function set value(value:Number):void
		{
			if (!_scrubbing) {
				_button.content.x = _bounds.x + (_bounds.width * value);
				_bar.width = _button.content.x;
			}
		}
		
		public function get content():MovieClip
		{
			return _container;
		}
		
		private function buttonSelected(e:MouseEvent):void
		{
			_scrubbing = true;
			
			_button.content.startDrag(false, _bounds);
			
			_container.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			_container.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		private function mouseMove(e:Event):void
		{
			_bar.width = _button.content.x;
			
			dispatchEvent(new Event(VOLUME_UPDATED));
		}
		
		private function mouseUp(e:MouseEvent):void
		{
			_scrubbing = false;
			
			_container.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			_container.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			_button.content.stopDrag();
		}
	}
}
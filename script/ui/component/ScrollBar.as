package script.ui.component
{
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class ScrollBar extends EventDispatcher
	{
		public static const SCROLL:String = 'scroll';
		public static const SCROLL_COMPLETE:String = 'scrollComplete';
		
		protected var _container:MovieClip;
		
		private var bar:ScrollBarButton;
		private var track:MovieClip;
		
		private var _ratio:Number;
		private var _minHeight:int;
		private var clickY:int;
		private var bounds:Rectangle;
		
		public function ScrollBar(container:MovieClip, minHeight:int = 0)
		{
			_container = container;
			_minHeight = minHeight;
			
			bar = new ScrollBarButton(content.bar);
			bar.content.addEventListener(MouseEvent.MOUSE_DOWN, moveBar);
			bar.content.addEventListener(MouseEvent.MOUSE_UP, stopBar);
			track = content.track;
		}
		
		public function init(h:Number):void
		{
			track.height = h;
			bar.setHeight(h);
			
			reset();
		}
		
		public function update(ratio:Number):void
		{
			var h:int = track.height * ratio;
			
			if (h < _minHeight) {
				h = _minHeight;
			}
			
			bar.setHeight(h);
			
			reset();
		}
		
		public function enable():void
		{
			bar.enable();
		}
		
		public function disable():void
		{
			bar.disable();
		}
		
		public function reset():void
		{
			ratio = 0;
			bar.content.y = 0;
			
			bounds = new Rectangle(track.x, track.y, track.x, track.height - bar.content.height);
		}
		
		public function set trackVisible(value:Boolean):void
		{
			track.visible = value;
		}
		
		public function get ratio():Number
		{
			return _ratio;
		}
		
		public function set ratio(value:Number):void
		{
			_ratio = value;
			
			bar.content.y = ratio * (track.height - bar.content.height);
		}
		
		public function get content():MovieClip
		{
			return _container;
		}
		
		protected function moveBar(e:MouseEvent):void
		{
			bar.content.stage.addEventListener(MouseEvent.MOUSE_UP, stopBar);
			
			clickY = bar.content.mouseY;
			
			content.addEventListener(Event.ENTER_FRAME, barMoving);
		}
		
		protected function stopBar(e:MouseEvent):void
		{
			bar.content.stage.removeEventListener(MouseEvent.MOUSE_UP, stopBar);
			
			content.removeEventListener(Event.ENTER_FRAME, barMoving);
			
			dispatchEvent(new Event(ScrollBar.SCROLL_COMPLETE));
		}
		
		protected function barMoving(e:Event):void
		{
			bar.content.y = content.mouseY - clickY;
			
			if (bar.content.x < bounds.x) {
				bar.content.x = bounds.x;
			} else if (bar.content.x > bounds.x + bounds.width) {
				bar.content.x = bounds.x + bounds.width;
			}
			
			if (bar.content.y < bounds.y) {
				bar.content.y = bounds.y;
			} else if (bar.content.y > bounds.y + bounds.height) {
				bar.content.y = bounds.y + bounds.height;
			}
			
			_ratio = (bar.content.y - track.y) / (track.height - bar.content.height);
			
			dispatchEvent(new Event(ScrollBar.SCROLL));
		}

	}
}
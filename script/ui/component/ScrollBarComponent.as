package script.ui.component
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import script.ui.BaseButton;

	public class ScrollBarComponent
	{
		protected var _container:MovieClip;
		protected var _scrollBar:ScrollBar;
		protected var _bg:MovieClip;
		
		protected var _controller:ScrollController;
		protected var _upButton:BaseButton;
		protected var _downButton:BaseButton;
		protected var _selectedScrollButton:BaseButton;
		
		public function ScrollBarComponent(container:MovieClip)
		{
			_container = container;
			_scrollBar = new ScrollBar(content.scrollbar, 100);
			_upButton = new BaseButton(content.upbutton);
			_downButton = new BaseButton(content.downbutton);
			_bg = content.bg;
		}
		
		public function init(scrollableContent:DisplayObject, scrollableContentHeight:int, height:int):void
		{
			_bg.height = height;
			_downButton.content.y = height - 2;
			_scrollBar.init(height - (_downButton.content.height * 2) - 8);
			_controller = new ScrollController(scrollableContent, _scrollBar, scrollableContentHeight);
			_controller.addEventListener(ScrollController.SCROLLBAR_HIDE, scrollBarHide);
			_controller.addEventListener(ScrollController.SCROLLBAR_SHOW, scrollBarShow);
			
			content.visible = _controller.scrollBarVisible;
			
			_upButton.content.addEventListener(MouseEvent.MOUSE_DOWN, scrollTo);
			_downButton.content.addEventListener(MouseEvent.MOUSE_DOWN, scrollTo);
		}
		
		public function enable():void
		{
			_upButton.enable();
			_downButton.enable();
			_controller.enable();	
		}
		
		public function disable():void
		{
			_upButton.disable();
			_downButton.disable();
			_controller.disable();
		}
		
		public function get content():MovieClip
		{
			return _container;
		}
		
		protected function scrollBarHide(e:Event = null):void
		{
			content.visible = false;
			disable();
		}
		
		protected function scrollBarShow(e:Event = null):void
		{
			content.visible = true;
			enable();
		}
		
		private function scrollTo(e:MouseEvent):void
		{
			e.stopImmediatePropagation();
			
			if (e.target == _upButton.content) {
				_selectedScrollButton = _upButton;
			} else if (e.target == _downButton.content) {
				_selectedScrollButton = _downButton;
			}
			
			_selectedScrollButton.content.addEventListener(Event.ENTER_FRAME, doScroll);
			_selectedScrollButton.content.stage.addEventListener(MouseEvent.MOUSE_UP, stopScroll);
		}
		
		private function doScroll(e:Event):void
		{
			if (_selectedScrollButton == _upButton) {
				_controller.scrollUp(20);
			} else if (_selectedScrollButton == _downButton) {
				_controller.scrollDown(20);
			}
		}
		
		private function stopScroll(e:MouseEvent):void
		{
			_selectedScrollButton.content.removeEventListener(Event.ENTER_FRAME, doScroll);
			_selectedScrollButton.content.stage.removeEventListener(MouseEvent.MOUSE_UP, stopScroll);
			_selectedScrollButton = null;
		}
	}
}
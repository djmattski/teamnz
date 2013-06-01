package script.ui.component
{
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class ScrollController extends EventDispatcher
	{
		public static const SCROLLBAR_SHOW:String = 'scrollbarShow';
		public static const SCROLLBAR_HIDE:String = 'scrollbarHide';
		
		protected var content:DisplayObject;
		protected var scrollBar:ScrollBar;
		protected var mask:Sprite;
		protected var height:int;
		
		public function ScrollController(content:DisplayObject, scrollBar:ScrollBar, height:int)
		{
			this.content = content;
			this.scrollBar = scrollBar;
			this.height = height;
			
			mask = new Sprite();
			mask.graphics.beginFill(0x000000, 0.5);
			mask.graphics.drawRect(0, 0, 10, 10);
			mask.graphics.endFill();
			
			if (content.stage) {
				setup();
			} else {
				content.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			}
		}
		
		public function enable():void
		{
			content.stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelScroll);
			scrollBar.addEventListener(ScrollBar.SCROLL, scrolling);
			scrollBar.enable();
		}
		
		public function disable():void
		{
			content.stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelScroll);
			scrollBar.removeEventListener(ScrollBar.SCROLL, scrolling);
			scrollBar.disable();
		}
		
		public function update(height:int = -1):void
		{
			if (height > -1) {
				this.height = height;
				mask.height = height;
			}
			
			if (content.stage) {
				mask.width = content.width;
				content.y = mask.y;
				content.mask = mask;
				
				if (content.height > mask.height) {
					enable();
					scrollBar.content.visible = true;
					scrollBar.update(mask.height / content.height);
					
					dispatchEvent(new Event(SCROLLBAR_SHOW));
				} else {
					disable();
					
					scrollBar.content.visible = false;
					
					dispatchEvent(new Event(SCROLLBAR_HIDE));
				}
			}
		}
		
		public function getHeight():int
		{
			if (mask.height > content.height) {
				return content.height;
			}
			
			return mask.height;
		}
		
		public function reset():void
		{
			scrollBar.ratio = 0;
			content.y = mask.y;
		}
		
		public function scrollUp(offset:int):void
		{
			var yTarget:Number = content.y + offset;
			
			scrollTo(yTarget);
		}
		
		public function scrollDown(offset:int):void
		{
			var yTarget:Number = content.y - offset;
			
			scrollTo(yTarget);
		}
		
		public function get scrollBarVisible():Boolean
		{
			return scrollBar.content.visible;
		}
		
		protected function setup():void
		{
			var bounds:Rectangle = content.getBounds(content.parent);
			mask.x = bounds.x;
			mask.y = bounds.y;
			mask.height = height;
			content.parent.addChild(mask);
			
			update();
		}
		
		protected function addedToStage(e:Event):void
		{
			content.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			content.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			
			setup();
		}
		
		protected function removedFromStage(e:Event):void
		{
			content.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			content.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		protected function scrollTo(yTarget:Number):void
		{
			if (yTarget > mask.y) {
				yTarget = mask.y;
			} else if (yTarget < mask.y + mask.height - content.height) {
				yTarget = mask.y + mask.height - content.height;
			}
			
			scrollBar.ratio = (yTarget - mask.y) / (mask.height - content.height);
			
			TweenMax.to(content, 0.5, { y:yTarget, ease:Expo.easeOut });
		}
		
		protected function scrolling(e:Event):void
		{
			var yTarget:Number = mask.y + (-scrollBar.ratio * (content.height - mask.height));
			
			scrollTo(yTarget);
		}
		
		protected function mouseWheelScroll(e:MouseEvent):void
		{
			if (content.height > mask.height) {
				var yTarget:Number = content.y + (e.delta * 20);
				
				scrollTo(yTarget);
			}
		}
	}
}
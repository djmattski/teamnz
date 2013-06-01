package script.ui.component
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import script.ui.BaseButton;
	
	public class ScrollBarButton extends BaseButton
	{
		public function ScrollBarButton(container:MovieClip)
		{
			super(container);
		}
		
		public function setHeight(h:int):void
		{
			content.height = h;
		}
		
		public override function onOver(e:MouseEvent = null):void
		{
			content.gotoAndStop(2);
		}
		
		public override function onOut(e:MouseEvent = null):void
		{
			if (!e.buttonDown) {
				content.stage.removeEventListener(MouseEvent.MOUSE_UP, onOut);
				content.gotoAndStop(1);
			} else {
				content.stage.addEventListener(MouseEvent.MOUSE_UP, onOut);
			}
		}
	}
}
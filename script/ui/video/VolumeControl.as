package script.ui.video
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import script.ui.BaseButton;
	
	public class VolumeControl extends EventDispatcher
	{
		protected var _container:MovieClip;
		
		private var _mask:Sprite;
		private var _speakerButton:MovieClip;
		private var _scrubberContainer:MovieClip;
		private var _scrubber:VolumeScrubber;
		private var _unMutedVolume:Number;
		
		public function VolumeControl(container:MovieClip)
		{
			_container = container;
			_scrubberContainer = _container.scrubbercontainer;
			_speakerButton = _container.speakerbutton;
			_scrubber = new VolumeScrubber(_scrubberContainer.scrubber);
			
			_mask = new Sprite();
			_mask.graphics.beginFill(0x000000);
			_mask.graphics.drawRect(0, 0, _scrubberContainer.width, 22);
			_mask.graphics.endFill();
			_mask.mouseEnabled = false;
			_mask.mouseChildren = false;
			_container.mask = _mask;
			_container.addChild(_mask);
			
			_speakerButton.mouseChildren = false;
			_scrubberContainer.x = -_scrubberContainer.width + 22;
			
			addListeners();
		}
		
		public function enable():void
		{
			_scrubber.enable();
			
			_speakerButton.buttonMode = true;
			_speakerButton.mouseEnabled = true;
			_speakerButton.addEventListener(MouseEvent.CLICK, speakerClick);
			_speakerButton.addEventListener(MouseEvent.MOUSE_OVER, speakerOver);
			_speakerButton.addEventListener(MouseEvent.MOUSE_OUT, speakerOut);
			
			content.addEventListener(MouseEvent.ROLL_OVER, onOver);
			content.addEventListener(MouseEvent.ROLL_OUT, onOut);
		}
		
		public function disable():void
		{
			_scrubber.disable();
		}
		
		public function get value():Number
		{
			return _scrubber.value;
		}
		
		public function set value(value:Number):void
		{
			if (_scrubber.value != value) {
				_scrubber.value = value;
			
				updateSpeakerState();
			}
		}
		
		public function get content():MovieClip
		{
			return _container;
		}
		
		public function mute():void
		{
			value = 0;
			
			dispatchEvent(new Event(VolumeScrubber.VOLUME_UPDATED));
		}
		
		public function unMute():void
		{
			value = _unMutedVolume;
			
			dispatchEvent(new Event(VolumeScrubber.VOLUME_UPDATED));
		}
		
		protected function showScrubber():void
		{
			TweenLite.to(_scrubberContainer, 0.5, { x:0, ease:Expo.easeOut });
		}
		
		protected function hideScrubber():void
		{
			if (value > 0) {
				_speakerButton.gotoAndStop(3);
			} else {
				_speakerButton.gotoAndStop(1);
			}
			
			TweenLite.to(_scrubberContainer, 0.5, { x:-_scrubberContainer.width + 22, ease:Expo.easeOut });
		}
		
		protected function addListeners():void
		{
			_scrubber.addEventListener(VolumeScrubber.VOLUME_UPDATED, volumeUpdated);
		}
		
		protected function speakerClick(e:MouseEvent):void
		{
			if (value > 0) {
				mute();
			} else {
				if (_unMutedVolume == 0) {
					_unMutedVolume = 0.1;
				}
				
				unMute();
			}
		}
		
		protected function speakerOver(e:MouseEvent):void
		{
			if (value > 0) {
				_speakerButton.gotoAndStop(2);
			} else {
				_speakerButton.gotoAndStop(4);
			}
		}
		
		protected function speakerOut(e:MouseEvent):void
		{
			updateSpeakerState();
		}
		
		protected function onOver(e:MouseEvent):void
		{
			showScrubber();
		}
		
		protected function onOut(e:MouseEvent):void
		{
			if (!_scrubber.isScrubbing) {
				hideScrubber();
			} else {
				content.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			}
		}
		
		private function mouseUp(e:MouseEvent):void
		{
			content.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			if (!content.hitTestPoint(content.stage.mouseX, content.stage.mouseY)) {
				hideScrubber();
			}
		}
		
		private function updateSpeakerState():void
		{
			if (content.stage && content.hitTestPoint(content.stage.mouseX, content.stage.mouseY) || _scrubber.isScrubbing) {
				if (_speakerButton.stage) {
					if (_speakerButton.hitTestPoint(_speakerButton.stage.mouseX, _speakerButton.stage.mouseY)) {
						if (value > 0) {
							_speakerButton.gotoAndStop(2);
						} else {
							_speakerButton.gotoAndStop(4);
						}
					} else {
						if (value > 0) {
							_speakerButton.gotoAndStop(4);
						} else {
							_speakerButton.gotoAndStop(2);
						}
					}
				}
			} else {
				if (value > 0) {
					_speakerButton.gotoAndStop(3);
				} else {
					_speakerButton.gotoAndStop(1);
				}
			}
		}
		
		private function volumeUpdated(e:Event):void
		{
			_unMutedVolume = value;
			
			updateSpeakerState();
			
			dispatchEvent(e);
		}
	}
}
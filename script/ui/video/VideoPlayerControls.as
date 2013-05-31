package script.ui.video
{
	import com.greensock.events.LoaderEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import script.ui.BaseButton;
	
	public class VideoPlayerControls extends EventDispatcher
	{
		protected var _container:MovieClip;
		protected var _controller:VideoController;
		
		private var _bg:Sprite;
		private var _playButton:BaseButton;
		private var _pauseButton:BaseButton;
		private var _rewindButton:BaseButton;
		private var _volume:VolumeControl;
		private var _time:MovieClip;
		private var _currentTime:TextField;
		private var _totalTime:TextField;
		
		public function VideoPlayerControls(container:MovieClip, controller:VideoController)
		{
			_container = container;
			_controller = controller;
			_time = _container.time;
			_currentTime = _time.currenttime;
			_totalTime = _time.totaltime;
			_bg = _container.bg;
			
			_playButton = new BaseButton(container.playbutton);
			_pauseButton = new BaseButton(container.pausebutton);
			_rewindButton = new BaseButton(container.rewindbutton);
			_volume = new VolumeControl(_container.volume);
			
			var textFormat:TextFormat = new TextFormat('Gotham Medium', 10, 0xffffff);
			
			_currentTime.embedFonts = true;
			_totalTime.embedFonts = true;
			_currentTime.defaultTextFormat = textFormat;
			_totalTime.defaultTextFormat = textFormat;
			
			addListeners();
		}
		
		public function init(w:int):void
		{
			_volume.value = _controller.volume;
			
			setSize(w);
			setPlayPause();
			updateTime();
		}
		
		public function setSize(w:int):void
		{
			_bg.width = w;
			_time.x = Math.floor(w - _time.width - 10);
		}
		
		public function enable():void
		{
			_playButton.enable();
			_pauseButton.enable();
			_rewindButton.enable();
			_volume.enable();
		}
		
		public function disable():void
		{
			_playButton.disable();
			_pauseButton.disable();
			_rewindButton.disable();
			_volume.disable();
		}
		
		public function get content():MovieClip
		{
			return _container;
		}
		
		protected function setPlayPause():void
		{
			_playButton.content.visible = !_controller.isPlaying;
			_pauseButton.content.visible = _controller.isPlaying;
		}
		
		protected function updateTime():void
		{
			_currentTime.text = formatTime(_controller.time);
			_totalTime.text = '/ ' + formatTime(_controller.duration);
		}
		
		private function formatTime(time:int):String
		{
			var mins:Number = Math.floor(time / 60);
			var secs:Number = Math.floor(time % 60);
			
			return mins + ':' + formatNumber(secs);
		}
		
		private function formatNumber(value:int):String
		{
			var val:String = value < 10 ? '0' + value : '' + value;
			
			return val;
		}
		
		protected function addListeners():void
		{
			_container.addEventListener(MouseEvent.CLICK, buttonClicked);
			_volume.addEventListener(VolumeScrubber.VOLUME_UPDATED, volumeScrubberUpdated);
			
			_controller.addEventListener(VideoController.VOLUME_UPDATED, controllerVolumeUpdated);
			_controller.addEventListener(VideoController.VIDEO_PAUSED, videoPaused);
			_controller.addEventListener(VideoController.VIDEO_RESUME, videoResume);
			_controller.addEventListener(VideoController.VIDEO_PLAYING, videoPlaying);
			_controller.addEventListener(VideoController.VIDEO_FINISH, videoFinished);
			_controller.addEventListener(VideoController.VIDEO_METADATA_RECEIVED, videoMetadataReceived);
			_controller.addEventListener(LoaderEvent.COMPLETE, videoLoaded);
		}
		
		private function buttonClicked(e:MouseEvent):void
		{
			e.stopImmediatePropagation();
			
			switch (e.target) {
				case _playButton.content:
					_controller.resume();
					break;
				case _pauseButton.content:
					_controller.pause();
					break;
				case _rewindButton.content:
					_controller.seek(0);
					break;
			}
		}
		
		private function videoLoaded(e:LoaderEvent):void
		{
			
		}
		
		private function volumeScrubberUpdated(e:Event):void
		{
			_controller.volume = _volume.value;
		}
		
		private function controllerVolumeUpdated(e:Event):void
		{
			_volume.value = _controller.volume;
		}
		
		private function videoMetadataReceived(e:Event):void
		{
			updateTime();
		}
		
		private function videoPaused(e:Event):void
		{
			setPlayPause();
		}
		
		private function videoResume(e:Event):void
		{
			setPlayPause();
		}
		
		private function videoPlaying(e:Event):void
		{
			updateTime();
		}
		
		private function videoFinished(e:Event):void
		{
			_controller.seek(0);
			setPlayPause();
		}
	}
}
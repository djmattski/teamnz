package script.ui.video
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.VideoLoader;
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class VideoController extends EventDispatcher
	{
		public static const VOLUME_UPDATED:String = 'volumeUpdated';
		public static const VIDEO_PAUSED:String = 'videoPaused';
		public static const VIDEO_PLAYING:String = 'videoPlaying';
		public static const VIDEO_RESUME:String = 'videoResume';
		public static const VIDEO_START:String = 'videoStart';
		public static const VIDEO_FINISH:String = 'videoFinish';
		public static const VIDEO_METADATA_RECEIVED:String = 'videoMetadata';
		
		protected var _video:VideoLoader;
		protected var _volume:Number;
		protected var _playing:Boolean;
		protected var _width:int;
		protected var _height:int;
		
		public function VideoController()
		{
			_volume = 1;
			_playing = false;
		}
		
		public function load(src:String, width:int, height:Number):void
		{
			if (_video) {
				_video.dispose();
			}
			
			_video = new VideoLoader(src, { onComplete:videoLoaded, onProgress:videoLoadProgress, onInit:videoMetadataReceived, width:width, height:height, autoPlay:false });
			_video.load();
		}
		
		public function pause():void
		{
			if (_video) {
				_video.pauseVideo();
			}
			
			_playing = false;
			
			dispatchEvent(new Event(VIDEO_PAUSED));
		}
		
		public function resume():void
		{
			if (_video) {
				_video.playVideo();
			}
			
			_playing = true;
			
			if (time == 0) {
				dispatchEvent(new Event(VIDEO_START));
			}
			
			dispatchEvent(new Event(VIDEO_RESUME));
		}
		
		public function seek(time:int):void
		{
			_video.gotoVideoTime(0, _playing);
		}
		
		public function get time():Number
		{
			return _video ? _video.videoTime : 0;
		}
		
		public function get duration():Number
		{
			return _video ? _video.duration : 0;
		}
		
		public function get isPlaying():Boolean
		{
			return _playing;
		}
		
		public function get volume():Number
		{
			return _volume;
		}
		
		public function set volume(value:Number):void
		{
			_volume = value;
			
			if (_video) {
				_video.volume = volume;
			}
			
			dispatchEvent(new Event(VOLUME_UPDATED));
		}
		
		public function get content():ContentDisplay
		{
			return _video.content;
		}
		
		protected function videoMetadataReceived(e:LoaderEvent):void
		{
			dispatchEvent(new Event(VIDEO_METADATA_RECEIVED));
		}
		
		protected function videoLoadProgress(e:LoaderEvent):void
		{
			dispatchEvent(e);
		}
		
		protected function videoLoaded(e:LoaderEvent):void
		{
			_video.removeEventListener(LoaderEvent.COMPLETE, videoLoaded);
			_video.removeEventListener(LoaderEvent.PROGRESS, videoLoadProgress);
			
			_video.addEventListener(VideoLoader.PLAY_PROGRESS, playProgress);
			_video.addEventListener(VideoLoader.VIDEO_COMPLETE, videoComplete);
			_video.volume = volume;
			
			dispatchEvent(e);
		}
		
		private function playProgress(e:LoaderEvent):void
		{
			dispatchEvent(new Event(VIDEO_PLAYING));
		}
		
		private function videoComplete(e:LoaderEvent):void
		{
			_playing = false;
			
			dispatchEvent(new Event(VIDEO_FINISH));
		}
	}
}
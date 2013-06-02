package script.ui.video
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.VideoLoader;
	
	import component.VideoPlayerAsset;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class CustomPlayer extends Sprite
	{
		private var _controller:VideoController;
		private var _player:MovieClip;
		private var _controls:VideoPlayerControls;
		private var _image:ImageLoader;
		private var _videoContainer:Sprite;
		private var _placeHolder:Sprite;
		private var _bg:Sprite;
		
		private var _w:int;
		private var _h:int;
		
		public function CustomPlayer()
		{
			_controller = new VideoController();
			
			_player = new VideoPlayerAsset;
			_controls = new VideoPlayerControls(_player.controls, _controller);
			_placeHolder = new Sprite();
			_videoContainer = new Sprite();
			_bg = new Sprite();
			
			addChild(_bg);
			addChild(_videoContainer);
			addChild(_player);
			addChild(_placeHolder);
		}
		
		public function init(w:int, h:int, placeholder:String = null):void
		{
			_w = w;
			_h = h;
			
			_bg.graphics.clear();
			_bg.graphics.beginFill(0x000000);
			_bg.graphics.drawRect(0, 0, _w, _h);
			_bg.graphics.endFill();
			
			_controls.init(_w);
			_controls.content.y = _h - _controls.content.height;
			
			if (placeholder ) {
				loadPlaceholder(placeholder);
			}
			
			addListeners();
		}
		
		public function loadVideo(src:String):void
		{
			while (_videoContainer.numChildren > 0) {
				_videoContainer.removeChildAt(0);
			}
			
			_controller.addEventListener(LoaderEvent.COMPLETE, videoLoaded);
			_controller.load(src, _w, _h);
		}
		
		public function enable():void
		{
			_controls.enable();
		}
		
		public function disable():void
		{
			_controls.disable();
		}
		
		protected function loadPlaceholder(src:String):void
		{
			if (_image) {
				while (_placeHolder.numChildren > 0) {
					_placeHolder.removeChildAt(0);
				}
				
				_image.dispose();
			}
			
			_image = new ImageLoader(src, { onComplete:imageLoaded });
			_image.load();
		}
		
		protected function showPlaceHolderImage():void
		{
			_placeHolder.alpha = 0;
			_placeHolder.addChild(_image.content);
			
			TweenLite.to(_placeHolder, 1, { alpha:1, ease:Expo.easeOut })
		}
		
		protected function addListeners():void
		{
		}
		
		protected function removeListeners():void
		{
		}
		
		private function imageLoaded(e:LoaderEvent):void
		{
			_image.removeEventListener(LoaderEvent.COMPLETE, imageLoaded);
			
			showPlaceHolderImage();
		}
		
		private function videoLoaded(e:LoaderEvent):void
		{
			_videoContainer.addChild(_controller.content);
			_controller.addEventListener(VideoController.VIDEO_START, videoStart);
		}
		
		private function videoStart(e:Event):void
		{
			TweenLite.to(_placeHolder, 0.5, { alpha:0, ease:Expo.easeOut });
		}
	}
}
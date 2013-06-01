﻿package script  {		import com.greensock.*;	import com.greensock.easing.*;	import com.greensock.events.LoaderEvent;	import com.greensock.loading.*;		import flash.display.*;	import flash.events.MouseEvent;	import flash.net.URLRequest;		public class home extends Sprite {				private var imgArr:Array;		private var loader1:ImageLoader;		private var loader2:ImageLoader;		private var loader3:ImageLoader;		private var queue:LoaderMax;		public var theWidth:int;		public var theHeight:int;				public function home(w:int,h:int) {			// constructor code						theWidth = w;			theHeight = h;						loader1 = new ImageLoader("images/CC130212-182.jpg", {name:"photo1", container:this, x:0, y:0, width:theWidth, height:theHeight, alpha:0, scaleMode:"stretch", centerRegistration:false});//, onComplete:onImageLoad			loader2 = new ImageLoader("images/CC130212-467.jpg", {name:"photo2", container:this, x:0, y:0, width:theWidth, height:theHeight, alpha:0, scaleMode:"stretch", centerRegistration:false});			loader3 = new ImageLoader("images/CC130214-161.jpg", {name:"photo3", container:this, x:0, y:0, width:theWidth, height:theHeight, alpha:0, scaleMode:"stretch", centerRegistration:false});						queue = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});			//append the ImageLoader and several other loaders			queue.append( loader1 );			queue.append( loader2 );			queue.append( loader3 );			//start loading			queue.load();		}				//Private functions		private function onImageLoad(event:LoaderEvent):void {			//TweenLite.to(event.target.content, 1, {alpha:1});		}		private function progressHandler(event:LoaderEvent):void {			//trace("progress: " + queue.progress);		}				private function completeHandler(event:LoaderEvent):void {			//trace(event.target + " is complete!");			//Get all images			var img1:Sprite = this.getChildAt(0) as Sprite;			var img2:Sprite = this.getChildAt(1) as Sprite;			var img3:Sprite = this.getChildAt(2) as Sprite;						TweenLite.to(img1, 0.1, {alpha:1, onComplete:function(){				var tl = new TimelineMax({repeat:-1});							tl.add(TweenLite.to(img2, 1, {alpha:1, delay:3}));				tl.add(TweenLite.to(img3, 1, {alpha:1, delay:3, onComplete:function(){img2.alpha=0;}}));				tl.add(TweenLite.to(img3, 1, {alpha:0, delay:3}));						 			}});		}				private function errorHandler(event:LoaderEvent):void {			trace("error occured with " + event.target + ": " + event.text);		}	}	}
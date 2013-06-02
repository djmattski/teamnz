﻿package script {		import com.greensock.*;	import com.greensock.easing.*;	import com.greensock.plugins.RemoveTintPlugin;	import com.greensock.plugins.TintPlugin;	import com.greensock.plugins.TweenPlugin;		import flash.display.*;	import flash.events.*;	import flash.geom.*;	import flash.media.Video;	import flash.net.NetConnection;	import flash.net.NetStream;	import flash.text.*;		import fonts.GothamMediumFont;		import script.home;	import script.library_manifest;	import script.navigation;	//import script.tools;	[SWF(width='1024', height='576', backgroundColor='#000000', frameRate='30')]	public class appBase extends MovieClip {				//*************************		//Properties				//private var myTools:tools;		public var theStage:Stage;		public var mainContainer:Sprite;		public var subBase:Sprite;		public var secSub:secSubClass;				private var leftGradContainer:Sprite;		private var leftGradTop:Sprite;		private var leftGradMid:Sprite;		private var leftGradBtm:Sprite;		private var rightGradContainer:Sprite;		private var rightGradTop:Sprite;		private var rightGradMid:Sprite;		private var rightGradBtm:Sprite;		private var subLeftGrad:Sprite;		private var subRightGrad:Sprite;		private var theNav:navigation;		private var theHome:home;		private var videoURL:String = "video/sample_intro.flv";		private var video:Video;        private var connection:NetConnection;        private var stream:NetStream;		private var myManifest:library_manifest;				//*************************		//Constructor		public function appBase() {						if(stage){				init(null);			}else{				addEventListener(Event.ADDED_TO_STAGE, init)			}						//Initiate tools class			//var myTools:tools = new tools();		}				//*************************		//Private Functions		private function init(e:Event):void{			removeEventListener(Event.ADDED_TO_STAGE, init);						myManifest = new library_manifest();						TweenPlugin.activate([RemoveTintPlugin, TintPlugin]);						Font.registerFont(GothamMediumFont);						theStage = stage;			theStage.scaleMode = StageScaleMode.NO_SCALE;			theStage.align = StageAlign.TOP_LEFT;						//If this has been called already, reset the listener so only one exists at any time			//theStage.stage.removeEventListener(Event.RESIZE, resizeListener);			//And then add it			theStage.addEventListener(Event.RESIZE, resizeListener);								mainContainer = new Sprite();			mainContainer.name = 'mainContainer';			mainContainer.graphics.lineStyle(0, 0x000000, 0);			mainContainer.graphics.beginFill(0x000000, 0);			mainContainer.graphics.drawRect(0, 0, 1024, 576);			mainContainer.graphics.endFill();			mainContainer.x = (theStage.stageWidth / 2) - (mainContainer.width / 2);			mainContainer.y = (theStage.stageHeight / 2) - (mainContainer.height / 2);			addChild(mainContainer);						//Left grad			leftGradContainer = new Sprite();			leftGradContainer.x = mainContainer.x - 1224;//Width of the gradient children			leftGradContainer.y = mainContainer.y;			addChild(leftGradContainer);						leftGradTop = createGrad('0x20363A',304,[1,0],1000);			leftGradTop.name = 'leftGradTop';			leftGradTop.width = 1224;			leftGradTop.height = 304;			leftGradTop.x = 0;			leftGradTop.y = 0;			leftGradContainer.addChild(leftGradTop);						leftGradMid = createGrad('0xFFFFFF',6,[1,0],1000);			leftGradMid.name = 'leftGradMid';			leftGradMid.width = 1224;			leftGradMid.height = 6;			leftGradMid.x = 0;			leftGradMid.y = leftGradTop.height;			leftGradContainer.addChild(leftGradMid);						leftGradBtm = createGrad('0x000000',266,[1,0],1000);			leftGradBtm.name = 'leftGradBtm';			leftGradBtm.width = 1224;			leftGradBtm.height = 266;			leftGradBtm.x = 0;			leftGradBtm.y = leftGradTop.height + leftGradMid.height;			leftGradContainer.addChild(leftGradBtm);						//right grad			rightGradContainer = new Sprite();			rightGradContainer.x = mainContainer.x + mainContainer.width;			rightGradContainer.y = mainContainer.y;			addChild(rightGradContainer);						rightGradTop = createGrad('0x20363A',304,[0,1],0);			rightGradTop.name = 'rightGradTop';			rightGradTop.width = 1224;			rightGradTop.height = 304;			rightGradTop.x = 0;			rightGradTop.y = 0;			rightGradContainer.addChild(rightGradTop);						rightGradMid = createGrad('0xFFFFFF',6,[0,1],0);			rightGradMid.name = 'rightGradMid';			rightGradMid.width = 1224;			rightGradMid.height = 6;			rightGradMid.x = 0;			rightGradMid.y = rightGradTop.height;			rightGradContainer.addChild(rightGradMid);						rightGradBtm = createGrad('0x000000',266,[0,1],0);			rightGradBtm.name = 'rightGradBtm';			rightGradBtm.width = 1224;			rightGradBtm.height = 266;			rightGradBtm.x = 0;			rightGradBtm.y = rightGradTop.height + rightGradMid.height;			rightGradContainer.addChild(rightGradBtm);									//Start Intro video						//connection = new NetConnection();            //connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);            //connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);            //connection.connect(null);						continueApp();								}				//Continue the app		private function continueApp():void{			//Remove video			if(video != null){				stream.close();				removeChild(video);			}						//Place home elements			theHome = new home(theStage.stageWidth,theStage.stageHeight);			theHome.name = 'home';			theHome.x = 0;			theHome.y = 0;			theHome.graphics.lineStyle(0, 0xFFFFFF, 0);			theHome.graphics.beginFill(0x000000, 1);			theHome.graphics.drawRect(0, 0, theStage.stageWidth, theStage.stageHeight);			theHome.graphics.endFill();			theHome.width = theStage.stageWidth;			theHome.height = theStage.stageHeight;			addChild(theHome);						//Navigation			theNav = new navigation();			theNav.name = 'theNav';			theNav.x = mainContainer.x + 30;			theNav.y = ((mainContainer.y / 2) - 15) - theNav.navYDelta;			addChild(theNav);			theNav.shaBang();		}				//Resize		private function resizeListener(event:Event):void{			//mainContainer.y = (theStage.stageHeight / 2) - (mainContainer.height / 2);			//mainContainer.x = (theStage.stageWidth / 2) - (mainContainer.width / 2);			mainContainer.y = (theStage.stageHeight / 2) - (576 / 2);			mainContainer.x = (theStage.stageWidth / 2) - (1024 / 2);			leftGradContainer.x = mainContainer.x - 1224;			leftGradContainer.y = mainContainer.y;			//rightGradContainer.x = mainContainer.x + mainContainer.width;			rightGradContainer.x = mainContainer.x + 1024;			rightGradContainer.y = mainContainer.y;			if(subLeftGrad != null){				subLeftGrad.x = leftGradContainer.x;				subLeftGrad.y = leftGradContainer.y;			}			if(subRightGrad != null){				subRightGrad.x = rightGradContainer.x;				subRightGrad.y = rightGradContainer.y;			}			if(subBase != null){				subBase.width = theStage.stageWidth;				subBase.height = theStage.stageHeight;			}			if(secSub != null){				secSub.x = mainContainer.x;				secSub.y = mainContainer.y;			}			if(theNav != null){				theNav.x = mainContainer.x + 30;				theNav.y = ((mainContainer.y / 2) - 15) - theNav.navYDelta;			}			if(video != null){				video.width = theStage.stageWidth;				video.height = theStage.stageHeight;			}			if(theHome != null){				theHome.width = theStage.stageWidth;				theHome.height = theStage.stageHeight;			}		}				/**		* Video functions		*/		private function netStatusHandler(event:NetStatusEvent):void {            switch (event.info.code) {                case "NetConnection.Connect.Success":                    connectStream();                    break;                case "NetStream.Play.StreamNotFound":                    trace("Unable to locate video: " + videoURL);                    break;				case "NetStream.Play.Start":					//(parent as DisplayObjectContainer).topHalf.alpha = 1;					break;				case "NetStream.Play.Stop":					continueApp();					break;            }			//trace(event.info.code);        }		        private function connectStream():void {            stream = new NetStream(connection);            stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);            stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);			stream.bufferTime = 0.5;            video = new Video();			video.name = 'introVideo';			video.x = 0;			video.y = 0;			video.width = theStage.stageWidth;			video.height = theStage.stageHeight;			video.smoothing = true;            video.attachNetStream(stream);            stream.play(videoURL);            addChild(video);        }        private function securityErrorHandler(event:SecurityErrorEvent):void {            trace("securityErrorHandler: " + event);        }                private function asyncErrorHandler(event:AsyncErrorEvent):void {            // ignore AsyncErrorEvent events.        }		/**End video functions**/				private function createGrad(colour:String,gradHeight:int,alphaArr:Array,tx:int):Sprite{			var theSprite:Sprite = new Sprite();			var fillType:String = GradientType.LINEAR;			var colors:Array = [colour, colour];			var alphas:Array = alphaArr;			var ratios:Array = [0, 255];			var matr:Matrix = new Matrix();			matr.createGradientBox(200, 200, 0, tx, 0);			var spreadMethod:String = SpreadMethod.PAD;			theSprite.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);        			theSprite.graphics.drawRect(0,0,1224,gradHeight);			theSprite.graphics.endFill();						return theSprite;		}						/**		* Static functions to deal with new sub secions loaded		*/				public static function rollOn(e:MouseEvent):void{			e.currentTarget.gotoAndStop(2);			//trace('rollOver:'+e.target.name);		}		public static function rollOff(e:MouseEvent):void{			e.currentTarget.gotoAndStop(1);			//trace('rollOut:'+e.target.name);		}		/**		* Function to handle the addition of sub pages to the app		*/		public function newSub(e:MouseEvent):void{			newSub2(e.currentTarget.name);		}				public function newSub2(id:String):void		{						//Cover the screen			subBase = new Sprite();			subBase.name = 'subBase';			subBase.graphics.beginFill(0x000000, 1);			subBase.graphics.drawRect(0, 0, theStage.stageWidth, theStage.stageHeight);			subBase.graphics.endFill();			subBase.x = 0;			subBase.y = 0;			subBase.alpha = 0;			addChild(subBase);			//Add the sub section			var my_dispatch:customDispatcher = new customDispatcher('closeMe');			my_dispatch.addEventListener(my_dispatch.ACTION, killSub);			secSub = new secSubClass(id, my_dispatch);			secSub.name = 'secSub';			secSub.x = mainContainer.x;			secSub.y = mainContainer.y;			secSub.alpha = 0;			addChild(secSub);						//Add more gradients to handle things flying in and out			//Left grad			subLeftGrad = createGrad('0x000000',576,[1,0],1000);			subLeftGrad.name = 'subLeftGrad';			subLeftGrad.width = 1224;			subLeftGrad.height = 576;			subLeftGrad.x = mainContainer.x - 1224;			subLeftGrad.y = mainContainer.y;			addChild(subLeftGrad);						//Right grad			subRightGrad = createGrad('0x000000',576,[0,1],0);			subRightGrad.name = 'subRightGrad';			subRightGrad.width = 1224;			subRightGrad.height = 576;			subRightGrad.x = mainContainer.x + mainContainer.width;			subRightGrad.y = mainContainer.y;			addChild(subRightGrad);						TweenLite.to([subBase,secSub],0.5,{alpha:1});		}				public function killSub(e:Event):void{			TweenLite.to([subBase,secSub],0.5,{alpha:0, ease:Sine.easeOut, onComplete:function(){				removeChild(subBase);				removeChild(secSub);				removeChild(subLeftGrad);				removeChild(subRightGrad);			}});		}					}//END CLASS	}
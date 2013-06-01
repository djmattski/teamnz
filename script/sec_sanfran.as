﻿package script{	import assets.sec_6_left;	import assets.sec_6_right;		import com.greensock.TweenLite;	import com.greensock.easing.*;		import flash.display.MovieClip;	import flash.display.Sprite;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.geom.*;		import script.ui.BaseButton;	import script.ui.video.CustomPlayer;
		public class sec_sanfran extends Sprite	{			private var sec_right:MovieClip;		private var sec_left:MovieClip;		private var sanFran_img_gal:Sprite;		private var img_gal_icon:global_image_gallery_icon;		private var readButton1:BaseButton;		private var readButton2:BaseButton;		private var downloadButton:BaseButton;		private var video:CustomPlayer;				public var theAppBase:appBase;				public function sec_sanfran(mainApp)		{			theAppBase = mainApp;						sec_right = new sec_6_right();			sec_right.x = 1300;			sec_right.y = 0;			addChild(sec_right);						sec_left = new sec_6_left();			sec_left.x = -1300;			sec_left.y = 350;			addChild(sec_left);						readButton1 = new BaseButton(sec_right.readbutton);			readButton2 = new BaseButton(sec_left.readbutton);			downloadButton = new BaseButton(sec_left.downloadbutton);						video = new CustomPlayer();			video.init(585, 325);			video.x = 439;			video.y = 50;			video.loadVideo('./flv/sanfran.flv');			sec_right.addChild(video);						//Img gal			sanFran_img_gal = new Sprite();			sanFran_img_gal.name = 'sanFran_img_gal';			sanFran_img_gal.x = 500;			sanFran_img_gal.y = video.y + video.height + 55;			sanFran_img_gal.buttonMode = true;			sec_right.addChild(sanFran_img_gal);			giveMeACircleBtn('img_gal', 0x805080, 0x512F4B, sanFran_img_gal);						addListeners();			animateIn();		}				public function flyout(my_dispatch:customDispatcher):void		{			disable();			removeListeners();						TweenLite.to(sec_right, 1, { x:1300, ease:Sine.easeIn});			TweenLite.to(sec_left, 1.4, { x:-1300,ease:Sine.easeIn, onComplete:my_dispatch.dispatchEvent, onCompleteParams:[new Event(my_dispatch.ACTION)]});		}				public function enable():void		{			readButton1.enable(); 			readButton2.enable();			downloadButton.enable();			video.enable();		}				public function disable():void		{			readButton1.disable(); 			readButton2.disable();			downloadButton.disable();			video.disable();		}				protected function animateIn():void		{			TweenLite.to(sec_right, 1, { x:0, ease:Sine.easeOut });			TweenLite.to(sec_left, 1.4, { x:0, ease:Sine.easeOut, onComplete:enable });		}				protected function addListeners():void		{			addEventListener(MouseEvent.CLICK, buttonClicked);		}				protected function removeListeners():void		{			removeEventListener(MouseEvent.CLICK, buttonClicked);		}				private function buttonClicked(e:MouseEvent):void		{			switch (e.target) {				case readButton1.content:				case readButton2.content:					break;				case downloadButton.content:					break;			}		}				public function giveMeACircleBtn(theName:String, theColour1:uint, theColour2:uint, theContainer:Sprite):void{			var thisBack:Sprite = new Sprite();			thisBack.name = theName;			thisBack.graphics.beginFill(theColour1, 1);			thisBack.graphics.drawCircle(0, 0, 30);			thisBack.graphics.endFill();			//thisBack.width = 80;			//thisBack.height = 80;			theContainer.addChild(thisBack);			img_gal_icon = new global_image_gallery_icon();			img_gal_icon.x = (img_gal_icon.width/2)*-1;			img_gal_icon.y = (img_gal_icon.height/2)*-1;			theContainer.addChild(img_gal_icon);			theContainer.addEventListener(MouseEvent.ROLL_OVER, function(){				//alter colour 				var my_color:ColorTransform = new ColorTransform();				my_color.color = theColour2;				thisBack.transform.colorTransform = my_color;			});			theContainer.addEventListener(MouseEvent.ROLL_OUT, function(){				//alter colour				var my_color:ColorTransform = new ColorTransform();				my_color.color = theColour1;				thisBack.transform.colorTransform = my_color;			});			theContainer.addEventListener(MouseEvent.MOUSE_DOWN, theAppBase.newSub);		}	}}
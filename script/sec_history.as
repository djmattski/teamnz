package script
{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	
	import script.tools;
	
	public class sec_history extends Sprite
	{
		
		private var his_right:Sprite;
		private var his_left:Sprite;
		private var his_title:sec_3_title;
		private var his_nav_nz_history:sec_2_team_history_button;
		private var his_nav_changed:sec_2_team_changed_button;
		private var his_sliderMc:sec_2_slide_button;
		private var timeline:sec_history_timeline;
		private var theAppBase:appBase;
		
		private var backDrop:Sprite;
		private var lines:global_line;
		private var closeX:global_close_btn;
		private var closeCont:Sprite;
		private var theColour1:uint;
		private var theColour2:uint;
		private var bigImageCont:Sprite;
		private var downBtn:global_download_image;
		private var myTools:tools;
		
		//Slider
		private var animLength : int;
		private var leftBound : Number;
		private var rightBound : Number;
		private var dragBound : Rectangle;
		private var calcWidth : Number;
		//
		
		public function sec_history(mainApp)
		{
			theAppBase = mainApp;
			theColour1 = 0x993449;
			theColour2 = 0x602638;
			
			// SPLIT HOLDERS
			his_right = new Sprite();
			his_right.name = 'his_right';
			his_right.x = -1300;
			his_right.y = 0;
			addChild(his_right);
			
			his_left = new Sprite();
			his_left.name = 'his_left';
			his_left.x = 1300;
			his_left.y = 150; // The height of the first half of the container + white border
			addChild(his_left);
			//
			
			//Right elements
			his_title = new sec_3_title();
			his_title.name = 'his_title';
			his_title.x = 25;
			his_title.y = 45;
			his_right.addChild(his_title);
			
			his_nav_nz_history = new sec_2_team_history_button();
			his_nav_nz_history.name = 'sec_2_nz_americas_cup';
			his_nav_nz_history.x = 25;
			his_nav_nz_history.y = 95;
			his_nav_nz_history.buttonMode = true;
			his_nav_nz_history.addEventListener(MouseEvent.ROLL_OVER, appBase.rollOn);
			his_nav_nz_history.addEventListener(MouseEvent.ROLL_OUT, appBase.rollOff);
			his_nav_nz_history.addEventListener(MouseEvent.MOUSE_DOWN, theAppBase.newSub);
			his_right.addChild(his_nav_nz_history);
			
			his_nav_changed = new sec_2_team_changed_button();
			his_nav_changed.name = 'sec_2_team_has_changed';
			his_nav_changed.x = his_nav_nz_history.x + his_nav_nz_history.width + 5;
			his_nav_changed.y = his_nav_nz_history.y;
			his_nav_changed.buttonMode = true;
			his_nav_changed.addEventListener(MouseEvent.ROLL_OVER, appBase.rollOn);
			his_nav_changed.addEventListener(MouseEvent.ROLL_OUT, appBase.rollOff);
			his_nav_changed.addEventListener(MouseEvent.MOUSE_DOWN, theAppBase.newSub);
			his_right.addChild(his_nav_changed);
			
			
			TweenLite.to(his_right,1,{x:0,ease:Sine.easeOut});
			
			//Left elements
			
			//Timeline
			timeline = new sec_history_timeline(this);
			timeline.name = 'timeline';
			timeline.x = 25;
			timeline.y = 0;
			his_left.addChild(timeline);
			
			//THE SLIDER
			his_sliderMc = new sec_2_slide_button();
			his_sliderMc.name = 'his_sliderMc';
			his_sliderMc.x = 0;
			his_sliderMc.y = (timeline.y + timeline.height) - (his_sliderMc.height/2);
			his_sliderMc.buttonMode = true;
			his_sliderMc.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseEvents);
			his_left.addChild(his_sliderMc);
			//
			animLength = timeline.width - (1024);
			leftBound = 0;
			rightBound = 1024 - his_sliderMc.width;
			dragBound = new Rectangle(leftBound, his_sliderMc.y, rightBound, 0);
			calcWidth = (rightBound / animLength);
			
			TweenLite.to(his_left,1.4,{x:0,ease:Sine.easeOut});
		}
		
		//Public functions
		public function flyout(my_dispatch:customDispatcher):void{
			if(bigImageCont){
				removeChild(bigImageCont);
			}
			TweenLite.to(timeline,1,{x:0,ease:Sine.easeIn});
			TweenLite.to(his_right,1,{x:-1300,ease:Sine.easeIn});
			TweenLite.to(his_left,1.4,{x:1300,ease:Sine.easeIn, onComplete:function(){
				my_dispatch.dispatchEvent(new Event(my_dispatch.ACTION));
			}});
		}
		
		//Private functions
		private function handleMouseEvents(evt:MouseEvent):void{
			switch(String(evt.type)) {
				case MouseEvent.MOUSE_DOWN:
					his_sliderMc.startDrag(false, dragBound);
					stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseEvents);
					timeline.addEventListener(Event.ENTER_FRAME, scrubMovie);
					break;
				case MouseEvent.MOUSE_UP:
					his_sliderMc.stopDrag();
					stage.removeEventListener(MouseEvent.MOUSE_UP, handleMouseEvents);
					timeline.removeEventListener(Event.ENTER_FRAME, scrubMovie);
					break;
			}
		}
		
		private function scrubMovie(evt:Event):void{
			var scrubPos : int = his_sliderMc.x;
			var gotoFrame : int = Math.ceil(scrubPos / calcWidth);
			timeline.x = gotoFrame * -1;
		}
		
		//Open large images
		public function openBig(id:String):void{
			//trace(e.currentTarget.name);
			
			bigImageCont = new Sprite();
			bigImageCont.alpha = 0;
			
			backDrop = new Sprite();
			backDrop.name ='backDrop';
			backDrop.x = -200;
			backDrop.y = 45;
			backDrop.graphics.beginFill(0x000000, 0.8);
			backDrop.graphics.drawRect(0, 0, 1424, 576);
			backDrop.graphics.endFill();
			backDrop.width = 1424;
			backDrop.height = 576;
			bigImageCont.addChild(backDrop);
			
			lines = new global_line();
			lines.name = 'lines';
			lines.x = 0;
			lines.y = 541;
			bigImageCont.addChild(lines);
			
			var classRefBigImg:Class = getDefinitionByName(id) as Class;
			var bigImage:MovieClip = new classRefBigImg();
			bigImage.name = 'bigImage';
			bigImage.x = 512 - (bigImage.width / 2);
			bigImage.y = 40;
			bigImageCont.addChild(bigImage);
			
			closeCont = new Sprite();
			closeCont.name = 'closeCont';
			closeCont.x = 0;
			closeCont.y = 40;
			closeCont.buttonMode = true;
			bigImageCont.addChild(closeCont);
			var thisBack:Sprite = new Sprite();
			thisBack.name = 'thisBack';
			thisBack.graphics.beginFill(theColour1, 1);
			thisBack.graphics.drawRect(0, 0, 40, 40);
			thisBack.graphics.endFill();
			thisBack.width = 40;
			thisBack.height = 40;
			thisBack.x = 0;
			thisBack.y = 0;
			closeX = new global_close_btn();
			closeX.x = 22 - (closeX.width/2);
			closeX.y = 22 - (closeX.height/2);
			closeCont.addChild(thisBack);
			closeCont.addChild(closeX);
			closeCont.addEventListener(MouseEvent.ROLL_OVER, function(){
				//alter colour 
				var my_color:ColorTransform = new ColorTransform();
				my_color.color = theColour2;
				thisBack.transform.colorTransform = my_color;
			});
			closeCont.addEventListener(MouseEvent.ROLL_OUT, function(){
				//alter colour
				var my_color:ColorTransform = new ColorTransform();
				my_color.color = theColour1;
				thisBack.transform.colorTransform = my_color;
			});
			closeCont.addEventListener(MouseEvent.MOUSE_DOWN, closeMeDown);
			
			//Add in download button
			downBtn = new global_download_image();
			downBtn.name = id+'_download';
			downBtn.x = 512 - (downBtn.width / 2);
			downBtn.y = 550;
			downBtn.buttonMode = true;
			downBtn.addEventListener(MouseEvent.ROLL_OVER, appBase.rollOn);
			downBtn.addEventListener(MouseEvent.ROLL_OUT, appBase.rollOff);
			downBtn.addEventListener(MouseEvent.MOUSE_DOWN, downloadThis);
			bigImageCont.addChild(downBtn);
			
			
			addChild(bigImageCont);
			TweenLite.to(bigImageCont, 0.5, {alpha:1});
			
		}
		
		private function closeMeDown(e:MouseEvent):void{
			TweenLite.to(bigImageCont, 0.5, {alpha:0, ease:Sine.easeOut, onComplete:function(){
				removeChild(bigImageCont); 
			}});
		}
		
		private function downloadThis(e:MouseEvent):void{
			//trace(imgPrefix+currImage);
			myTools = new tools();
			var downName:String = tools.getDownloadBit(e.currentTarget.name);
			myTools.fileName = downName+'.jpg';
			myTools.loadFile('downloads/history/'+downName+'.jpg');
		}
		
		
	}
}
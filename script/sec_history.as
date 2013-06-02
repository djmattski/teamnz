package script
{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
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
			
			// SPLIT HOLDERS
			his_right = new Sprite();
			his_right.name = 'his_right';
			his_right.x = 1300;
			his_right.y = 0;
			addChild(his_right);
			
			his_left = new Sprite();
			his_left.name = 'his_left';
			his_left.x = -1300;
			his_left.y = 310; // The height of the first half of the container + white border
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
			his_right.addChild(his_nav_nz_history);
			
			his_nav_changed = new sec_2_team_changed_button();
			his_nav_changed.name = 'sec_2_team_has_changed';
			his_nav_changed.x = his_nav_nz_history.x + his_nav_nz_history.width + 5;
			his_nav_changed.y = his_nav_nz_history.y;
			his_right.addChild(his_nav_changed);
			
			
			TweenLite.to(his_right,1,{x:0,ease:Sine.easeOut});
			
			//Left elements
			
			//Timeline
			timeline = new sec_history_timeline(theAppBase);
			timeline.name = 'timeline';
			timeline.x = 25;
			timeline.y = 309;
			his_left.addChild(timeline);
			
			//THE SLIDER
			his_sliderMc = new sec_2_slide_button();
			his_sliderMc.name = 'his_sliderMc';
			his_sliderMc.x = 0;
			his_sliderMc.y = timeline.y - (his_sliderMc.height/2);
			his_sliderMc.buttonMode = true;
			his_sliderMc.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseEvents);
			his_left.addChild(his_sliderMc);
			//
			animLength = timeline.width - (1024/2) + 400;
			leftBound = 0;
			rightBound = 1024 - his_sliderMc.width;
			dragBound = new Rectangle(leftBound, his_sliderMc.y, rightBound, 0);
			calcWidth = (rightBound / animLength);
			
			TweenLite.to(his_left,1.4,{x:0,ease:Sine.easeOut});
		}
		
		//Public functions
		public function flyout(my_dispatch:customDispatcher):void{
			TweenLite.to(his_right,1,{x:1300,ease:Sine.easeIn});
			TweenLite.to(his_left,1.4,{x:-1300,ease:Sine.easeIn, onComplete:function(){
				my_dispatch.dispatchEvent(new Event(my_dispatch.ACTION));
			}});
		}
		
		//Private functions
		private function handleMouseEvents(evt:MouseEvent):void{
			switch(String(evt.type)) {
				case MouseEvent.MOUSE_DOWN:
					his_sliderMc.sec_3_slide.startDrag(false, dragBound);
					stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseEvents);
					timeline.addEventListener(Event.ENTER_FRAME, scrubMovie);
					break;
				case MouseEvent.MOUSE_UP:
					his_sliderMc.sec_3_slide.stopDrag();
					stage.removeEventListener(MouseEvent.MOUSE_UP, handleMouseEvents);
					timeline.removeEventListener(Event.ENTER_FRAME, scrubMovie);
					break;
			}
		}
		
		private function scrubMovie(evt:Event):void{
			var scrubPos : int = his_sliderMc.x;
			var gotoFrame : int = Math.ceil(scrubPos / calcWidth) - 480;
			timeline.x = gotoFrame * -1;
		}
		
		
		
	}
}
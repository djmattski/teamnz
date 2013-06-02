﻿package script {		import flash.display.*;	import flash.events.*;	import flash.geom.*;	import com.greensock.*;	import com.greensock.easing.*;			public class sec_team extends Sprite{				private var team_right:Sprite;		private var team_left:Sprite;		private var team_heros_cont:sec_team_slider;		private var team_title:sec_1_title;		private var team_sailing_btn:sec_1_sailing_button;		private var team_man_btn:sec_1_management_button;		private var team_design_btn:sec_1_design_button;		private var team_shore_btn:sec_1_shore_button;		private var team_support_btn:sec_1_support_button;		private var team_slider:sec_1_slide_button;		private var currCrew:String;		private var team_sailors:sec_team_sailors;		private var team_design:sec_team_design;		private var team_shore:sec_team_shore;		private var team_man:sec_team_man;		private var team_support:sec_team_support;				//Slider		private var animLength : int;		private var leftBound : Number;		private var rightBound : Number;		private var dragBound : Rectangle;		private var calcWidth : Number;		//				public var theAppBase:appBase;				public function sec_team(mainApp) {			// constructor code						theAppBase = mainApp;						///** SPLIT HOLDERS			team_right = new Sprite();			team_right.name = 'team_right';			team_right.x = 1300;			team_right.y = 0;			addChild(team_right);						team_left = new Sprite();			team_left.name = 'team_left';			team_left.x = -1300;			team_left.y = 310; // The height of the first half of the container + white border			addChild(team_left);			//									//Right elements			team_title = new sec_1_title();			team_title.name = 'team_title';			team_title.x = 25;			team_title.y = 45;			team_right.addChild(team_title);						//Major players holder			team_heros_cont = new sec_team_slider(theAppBase);			team_heros_cont.name = 'team_heros_cont';			team_heros_cont.x = 480;			team_heros_cont.y = 304;			team_right.addChild(team_heros_cont);			//Slider			team_slider = new sec_1_slide_button();			team_slider.name = 'team_slider';			team_slider.x = 0;			team_slider.y = team_heros_cont.y - (team_slider.height/2);			team_slider.buttonMode = true;			team_slider.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseEvents);			team_right.addChild(team_slider);			//			animLength = team_heros_cont.width - (1024/2) + 400;			leftBound = 0;			rightBound = 1024 - team_slider.width;			dragBound = new Rectangle(leftBound, team_slider.y, rightBound, 0);			calcWidth = (rightBound / animLength);												TweenLite.to(team_right,1,{x:0,ease:Sine.easeOut});						//Left elements			team_sailing_btn = new sec_1_sailing_button();			team_sailing_btn.name = 'team_sailing_btn';			team_sailing_btn.x = 25;			team_sailing_btn.y = 15;			team_sailing_btn.buttonMode = true;			team_sailing_btn.addEventListener(MouseEvent.ROLL_OVER, appBase.rollOn);			team_sailing_btn.addEventListener(MouseEvent.ROLL_OUT, appBase.rollOff);			team_sailing_btn.addEventListener(MouseEvent.MOUSE_DOWN, newCrew);			team_left.addChild(team_sailing_btn);			//			team_design_btn = new sec_1_design_button();			team_design_btn.name = 'team_design_btn';			team_design_btn.x = team_sailing_btn.x + team_sailing_btn.width + 10;			team_design_btn.y = 15;			team_design_btn.buttonMode = true;			team_design_btn.addEventListener(MouseEvent.ROLL_OVER, appBase.rollOn);			team_design_btn.addEventListener(MouseEvent.ROLL_OUT, appBase.rollOff);			team_design_btn.addEventListener(MouseEvent.MOUSE_DOWN, newCrew);			team_left.addChild(team_design_btn);			//			team_shore_btn = new sec_1_shore_button();			team_shore_btn.name = 'team_shore_btn';			team_shore_btn.x = team_design_btn.x + team_design_btn.width + 10;			team_shore_btn.y = 15;			team_shore_btn.buttonMode = true;			team_shore_btn.addEventListener(MouseEvent.ROLL_OVER, appBase.rollOn);			team_shore_btn.addEventListener(MouseEvent.ROLL_OUT, appBase.rollOff);			team_shore_btn.addEventListener(MouseEvent.MOUSE_DOWN, newCrew);			team_left.addChild(team_shore_btn);			//			team_support_btn = new sec_1_support_button();			team_support_btn.name = 'team_support_btn';			team_support_btn.x = team_shore_btn.x + team_shore_btn.width + 10;			team_support_btn.y = 15;			team_support_btn.buttonMode = true;			team_support_btn.addEventListener(MouseEvent.ROLL_OVER, appBase.rollOn);			team_support_btn.addEventListener(MouseEvent.ROLL_OUT, appBase.rollOff);			team_support_btn.addEventListener(MouseEvent.MOUSE_DOWN, newCrew);			team_left.addChild(team_support_btn);			//			team_man_btn = new sec_1_management_button();			team_man_btn.name = 'team_man_btn';			team_man_btn.x = team_support_btn.x + team_support_btn.width + 10;			team_man_btn.y = 15;			team_man_btn.buttonMode = true;			team_man_btn.addEventListener(MouseEvent.ROLL_OVER, appBase.rollOn);			team_man_btn.addEventListener(MouseEvent.ROLL_OUT, appBase.rollOff);			team_man_btn.addEventListener(MouseEvent.MOUSE_DOWN, newCrew);			team_left.addChild(team_man_btn);						//Create the first crew			team_sailors = new sec_team_sailors(theAppBase);			team_sailors.name = 'team_sailors';			team_sailors.x = 25;			team_sailors.y = 40;			team_left.addChild(team_sailors);			currCrew = 'team_sailors';						TweenLite.to(team_left,1.4,{x:0,ease:Sine.easeOut});		}				//Public functions		public function flyout(my_dispatch:customDispatcher):void{			TweenLite.to(team_heros_cont,1,{x:480,ease:Sine.easeIn});			TweenLite.to(team_right,1,{x:1300,ease:Sine.easeIn});			TweenLite.to(team_left,1.4,{x:-1300,ease:Sine.easeIn, onComplete:function(){				my_dispatch.dispatchEvent(new Event(my_dispatch.ACTION));			}});		}				//Private functions		private function handleMouseEvents(evt:MouseEvent):void{		   switch(String(evt.type)) {			  case MouseEvent.MOUSE_DOWN:				 team_slider.startDrag(false, dragBound);				 stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseEvents);				 team_heros_cont.addEventListener(Event.ENTER_FRAME, scrubMovie);			  break;			  case MouseEvent.MOUSE_UP:				 team_slider.stopDrag();				 stage.removeEventListener(MouseEvent.MOUSE_UP, handleMouseEvents);				 team_heros_cont.removeEventListener(Event.ENTER_FRAME, scrubMovie);			  break;		   }		}				private function scrubMovie(evt:Event):void{		   var scrubPos : int = team_slider.x;		   var gotoFrame : int = Math.ceil(scrubPos / calcWidth) - 480;		   team_heros_cont.x = gotoFrame * -1;		}				/**		* Add a new crew to the bottom		*/		public function newCrew(e:MouseEvent):void{						var currtarget:String = e.currentTarget.name;			var currCrewMC = team_left.getChildByName(currCrew) as Sprite;			TweenLite.to(currCrewMC,0.5,{alpha:0, ease:Sine.easeIn, onComplete:function(){				team_left.removeChild(currCrewMC);								switch(currtarget){					case 'team_sailing_btn':						team_sailors = new sec_team_sailors(theAppBase);						team_sailors.name = 'team_sailors';						team_sailors.x = 25;						team_sailors.y = 40;						team_sailors.alpha = 0;						team_left.addChild(team_sailors);						TweenLite.to(team_sailors,0.5,{alpha:1, ease:Sine.easeOut, onComplete:function(){							currCrew = 'team_sailors';						}});					break;					case 'team_design_btn':						team_design = new sec_team_design(theAppBase);						team_design.name = 'team_design';						team_design.x = 25;						team_design.y = 40;						team_design.alpha = 0;						team_left.addChild(team_design);						TweenLite.to(team_design,0.5,{alpha:1, ease:Sine.easeOut, onComplete:function(){							currCrew = 'team_design';						}});					break;					case 'team_shore_btn':						team_shore = new sec_team_shore(theAppBase);						team_shore.name = 'team_shore';						team_shore.x = 25;						team_shore.y = 40;						team_shore.alpha = 0;						team_left.addChild(team_shore);						TweenLite.to(team_shore,0.5,{alpha:1, ease:Sine.easeOut, onComplete:function(){							currCrew = 'team_shore';						}});					break;					case 'team_man_btn':						team_man = new sec_team_man(theAppBase);						team_man.name = 'team_man';						team_man.x = 25;						team_man.y = 40;						team_man.alpha = 0;						team_left.addChild(team_man);						TweenLite.to(team_man,0.5,{alpha:1, ease:Sine.easeOut, onComplete:function(){							currCrew = 'team_man';						}});					break;					case 'team_support_btn':						team_support = new sec_team_support(theAppBase);						team_support.name = 'team_support';						team_support.x = 25;						team_support.y = 40;						team_support.alpha = 0;						team_left.addChild(team_support);						TweenLite.to(team_support,0.5,{alpha:1, ease:Sine.easeOut, onComplete:function(){							currCrew = 'team_support';						}});					break;				}							}});		}			}	}
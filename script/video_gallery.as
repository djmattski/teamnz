package script
{
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import component.scrollbar.ScrollBarComponentAsset;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	
	import script.tools;
	import script.ui.component.ScrollBarComponent;
	
	public class video_gallery extends Sprite{
		
		private var vidPrefix:String;
		private var imageHolder:Sprite;
		private var currCol:int;
		private var currRow:int;
		private var backDrop:Sprite;
		private var lines:global_line;
		private var closeX:global_close_btn;
		private var closeCont:Sprite;
		private var theColour1:uint;
		private var theColour2:uint;
		private var bigImageCont:Sprite;
		private var downBtn:global_download_image;
		private var currImage:int;
		private var numVids:int;
		private var myTools:tools;
		
		public function video_gallery(vid_gal_identifier,colour1:uint,colour2:uint){
			// constructor code
			
			//Old school switch
			switch(vid_gal_identifier){
				case 'boats_vid_gal':
					numVids = 5;
					vidPrefix = 'sec_3';
					break;
			}
			
			//Title
			var classRefVidGalTitle:Class = getDefinitionByName(vidPrefix+'_vid_gal_title') as Class;
			var thisTitle_vidGal:MovieClip = new classRefVidGalTitle();
			thisTitle_vidGal.name = 'thisTitle_vidGal';
			thisTitle_vidGal.x = 20;
			thisTitle_vidGal.y = 55;
			addChild(thisTitle_vidGal);
			//
			currCol = 0;
			currRow = -1;
			theColour1 = colour1;
			theColour2 = colour2;
			currImage = 1;
			imageHolder = new Sprite();
			imageHolder.y = 130;
			addChild(imageHolder);
			for(var i:int = 0; i < numVids; i++){
				
				
				
				var newNum:int = i+1;
				var classRefImgGalThumb:Class = getDefinitionByName(vidPrefix+'_vid_thumb_'+newNum) as Class;
				var thumb:MovieClip = new classRefImgGalThumb();
				thumb.name = newNum+'_image';
				if(i % 5 == 0){
					currRow ++;
				}
				thumb.y = ((thumb.height + 12) * currRow);
				thumb.x = (thumb.width + 12) * currCol;
				currCol ++;
				if(currCol > 4){
					currCol = 0;
				}
				
				thumb.buttonMode = true;
				thumb.addEventListener(MouseEvent.MOUSE_DOWN, openBig);
				imageHolder.addChild(thumb);
			}
			
			//Scrollbar
			var sbComponent:ScrollBarComponent = new ScrollBarComponent(new ScrollBarComponentAsset());
			sbComponent.init(imageHolder, 378, 378);
			sbComponent.content.x = (imageHolder.width) + 5;
			sbComponent.content.y = 130;
			//sbComponent.enable();
			addChild(sbComponent.content);
		}
		
		/**
		 * Private functions
		 */
		
		private function openBig(e:MouseEvent):void{
			//trace(e.currentTarget.name);
			
			bigImageCont = new Sprite();
			bigImageCont.alpha = 0;
			
			backDrop = new Sprite();
			backDrop.name ='backDrop';
			backDrop.x = -30;
			backDrop.y = 0;
			backDrop.graphics.beginFill(0x000000, 0.8);
			backDrop.graphics.drawRect(0, 0, 1024, 576);
			backDrop.graphics.endFill();
			backDrop.width = 1024;
			backDrop.height = 576;
			bigImageCont.addChild(backDrop);
			
			lines = new global_line();
			lines.name = 'lines';
			lines.x = 0;
			lines.y = 515;
			bigImageCont.addChild(lines);
			
			var numberName:Number = tools.getItemNumber(e.currentTarget.name);
			var classRefBigImg:Class = getDefinitionByName(vidPrefix+'_image_'+numberName) as Class;
			var bigImage:MovieClip = new classRefBigImg();
			bigImage.name = 'bigImage';
			bigImage.x = 512 - (bigImage.width / 2);
			bigImage.y = 0;
			bigImageCont.addChild(bigImage);
			
			currImage = numberName;
			
			closeCont = new Sprite();
			closeCont.name = 'closeCont';
			closeCont.x = 0;
			closeCont.y = 0;
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
			downBtn.name = 'downBtn';
			downBtn.x = 512 - (downBtn.width / 2);
			downBtn.y = 538;
			downBtn.buttonMode = true;
			downBtn.addEventListener(MouseEvent.MOUSE_DOWN, downloadThis);
			bigImageCont.addChild(downBtn);
			
			//Next/Prev
			giveMeSomeNextPrev(bigImageCont);
			
			addChild(bigImageCont);
			TweenLite.to(bigImageCont, 0.5, {alpha:1});
			
		}
		
		private function closeMeDown(e:MouseEvent):void{
			TweenLite.to(bigImageCont, 0.5, {alpha:0, ease:Sine.easeOut, onComplete:function(){
				removeChild(bigImageCont); 
			}});
		}
		
		private function downloadThis(e:MouseEvent):void{
			//trace(vidPrefix+currImage);
			myTools = new tools();
			myTools.fileName = vidPrefix+'_image_'+currImage+'.jpg';
			myTools.loadFile('downloads/'+vidPrefix+'_image_'+currImage+'.jpg');
		}
		
		private function giveMeSomeNextPrev(myParent:Sprite):void{
			
			var classRefPrev:Class = getDefinitionByName(vidPrefix+'_prev_image') as Class;
			var prevBtn:MovieClip = new classRefPrev();
			prevBtn.name ='prevBtn';
			prevBtn.x = downBtn.x - prevBtn.width - 10;
			prevBtn.y = 538;
			prevBtn.buttonMode = true;
			if(currImage <= 1){
				prevBtn.visible = false;
			}
			prevBtn.addEventListener(MouseEvent.MOUSE_DOWN, moveThisPageYo);			
			prevBtn.addEventListener(MouseEvent.ROLL_OVER, appBase.rollOn);
			prevBtn.addEventListener(MouseEvent.ROLL_OUT, appBase.rollOff);
			myParent.addChild(prevBtn);
			
			var classRefNext:Class = getDefinitionByName(vidPrefix+'_next_image') as Class;
			var nextBtn:MovieClip = new classRefNext();
			nextBtn.name ='nextBtn';
			nextBtn.x = downBtn.x + downBtn.width + 10;
			nextBtn.y = 538;
			nextBtn.buttonMode = true;
			if(currImage >= numVids){
				nextBtn.visible = false;
			}
			nextBtn.addEventListener(MouseEvent.MOUSE_DOWN, moveThisPageYo);
			nextBtn.addEventListener(MouseEvent.ROLL_OVER, appBase.rollOn);
			nextBtn.addEventListener(MouseEvent.ROLL_OUT, appBase.rollOff);
			myParent.addChild(nextBtn);
		}
		
		private function moveThisPageYo(e:MouseEvent):void{
			
			var currImageMc:MovieClip = bigImageCont.getChildByName('bigImage') as MovieClip;
			var nextBtn:MovieClip = bigImageCont.getChildByName('nextBtn') as MovieClip;
			var prevBtn:MovieClip = bigImageCont.getChildByName('prevBtn') as MovieClip;
			
			switch(e.currentTarget.name){
				case 'nextBtn':
					if(currImage < numVids){
						
						TweenLite.to(currImageMc, 0.5, {alpha:0, ease:Sine.easeOut, onComplete:function(){
							bigImageCont.removeChild(currImageMc);
							currImage ++;
							var numberName:Number = currImage;
							var classRef:Class = getDefinitionByName(vidPrefix+'_image_'+numberName) as Class;
							var bigImage:MovieClip = new classRef();
							bigImage.name = 'bigImage';
							bigImage.x = 512 - (bigImage.width / 2);
							bigImage.y = 0;
							bigImage.alpha = 0;
							bigImageCont.addChild(bigImage);
							TweenLite.to(bigImage, 0.5, {alpha:1, ease:Sine.easeIn});
							//REmove next btn
							if(currImage >= numVids){
								nextBtn.visible = false;
							}
							if(currImage > 1){
								prevBtn.visible = true;
							}
						}});
						
					}
					break;
				case 'prevBtn':
					if(currImage > 1){
						
						TweenLite.to(currImageMc, 0.5, {alpha:0, ease:Sine.easeOut, onComplete:function(){
							bigImageCont.removeChild(currImageMc);
							currImage --;
							var numberName:Number = currImage;
							var classRef:Class = getDefinitionByName(vidPrefix+'_image_'+numberName) as Class;
							var bigImage:MovieClip = new classRef();
							bigImage.name = 'bigImage';
							bigImage.x = 512 - (bigImage.width / 2);
							bigImage.y = 0;
							bigImage.alpha = 0;
							bigImageCont.addChild(bigImage);
							TweenLite.to(bigImage, 0.5, {alpha:1, ease:Sine.easeIn});
							//REmove prev btn
							if(currImage <= 1){
								prevBtn.visible = false;
							}
							if(currImage < numVids){
								nextBtn.visible = true;
							}
						}});
					}
					break;
			}
		}
		
	}
}
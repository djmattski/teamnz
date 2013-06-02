package script
{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.*;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.*;

	public class sec_history_timeline extends Sprite
	{
		private var grandDad:sec_history;
		
		
		
		private var myTools:tools;
		//Titles
		private var title_1987:sec_2_1987_title;
		private var title_1988:sec_2_1988_title;
		private var title_1992:sec_2_1992_title;
		private var title_1995:sec_2_1995_title;
		private var title_2000:sec_2_2000_title;
		private var title_2003:sec_2_2003_title;
		private var title_2007:sec_2_2007_title;
		//Text
		private var text_1987:sec_2_1987_text;
		private var text_1988:sec_2_1988_text;
		private var text_1992:sec_2_1992_text;
		private var text_1995:sec_2_1995_text;
		private var text_2000:sec_2_2000_text;
		private var text_2003:sec_2_2003_text;
		private var text_2007:sec_2_2007_text;
		//Thumbs
		private var thumb_1_1987:sec_2_1987_thumb_1;
		private var thumb_1_1988:sec_2_1988_thumb_1;
		private var thumb_1_1992:sec_2_1992_thumb_1;
		private var thumb_1_1995:sec_2_1995_thumb_1;
		private var thumb_1_2000:sec_2_2000_thumb_1;
		private var thumb_2_2000:sec_2_2000_thumb_2;
		private var thumb_3_2000:sec_2_2000_thumb_3;
		private var thumb_4_2000:sec_2_2000_thumb_4;
		private var thumb_1_2003:sec_2_2003_thumb_1;
		private var thumb_2_2003:sec_2_2003_thumb_2;
		private var thumb_3_2003:sec_2_2003_thumb_3;
		private var thumb_1_2007:sec_2_2007_thumb_1;
		private var thumb_2_2007:sec_2_2007_thumb_2;
		private var thumb_3_2007:sec_2_2007_thumb_3;
		private var thumb_4_2007:sec_2_2007_thumb_4;
		
		//private var divider:thinLine;
		
		public function sec_history_timeline(myGrandDad)
		{
			
			grandDad = myGrandDad;
			
			//1987
			var divider1:thinLine = new thinLine();
			divider1.x = 0;
			divider1.y = 0;
			addChild(divider1);
			title_1987 = new sec_2_1987_title();
			title_1987.x = 12;
			title_1987.y = 0;
			addChild(title_1987);
			text_1987 = new sec_2_1987_text();
			text_1987.x = 12;
			text_1987.y = title_1987.y + title_1987.height + 15;
			addChild(text_1987);
			thumb_1_1987 = new sec_2_1987_thumb_1();
			thumb_1_1987.name = 'sec_2_1987_img_1';
			thumb_1_1987.x = 12;
			thumb_1_1987.y = text_1987.y + text_1987.height + 20;
			thumb_1_1987.buttonMode = true;
			thumb_1_1987.addEventListener(MouseEvent.MOUSE_DOWN, openBig);
			addChild(thumb_1_1987);
			
			//1988
			var divider2:thinLine = new thinLine();
			divider2.x = 276;
			divider2.y = 0;
			addChild(divider2);
			title_1988 = new sec_2_1988_title();
			title_1988.x = divider2.x + 12;
			title_1988.y = 0;
			addChild(title_1988);
			text_1988 = new sec_2_1988_text();
			text_1988.x = divider2.x + 12;
			text_1988.y = title_1988.y + title_1988.height + 15;
			addChild(text_1988);
			thumb_1_1988 = new sec_2_1988_thumb_1();
			thumb_1_1988.name = 'sec_2_1988_img_1';
			thumb_1_1988.x = divider2.x + 12;
			thumb_1_1988.y = text_1988.y + text_1988.height + 20;
			addChild(thumb_1_1988);
			
			//1992
			var divider3:thinLine = new thinLine();
			divider3.x = 554;
			divider3.y = 0;
			addChild(divider3);
			title_1992 = new sec_2_1992_title();
			title_1992.x = divider3.x + 12;
			title_1992.y = 0;
			addChild(title_1992);
			text_1992 = new sec_2_1992_text();
			text_1992.x = divider3.x + 12;
			text_1992.y = title_1992.y + title_1992.height + 15;
			addChild(text_1992);
			thumb_1_1992 = new sec_2_1992_thumb_1();
			thumb_1_1992.name = 'sec_2_1992_img_1';
			thumb_1_1992.x = divider3.x + 12;
			thumb_1_1992.y = text_1992.y + text_1992.height + 20;
			addChild(thumb_1_1992);
			
			//1995
			var divider4:thinLine = new thinLine();
			divider4.x = 830;
			divider4.y = 0;
			addChild(divider4);
			title_1995 = new sec_2_1995_title();
			title_1995.x = divider4.x + 12;
			title_1995.y = 0;
			addChild(title_1995);
			text_1995 = new sec_2_1995_text();
			text_1995.x = divider4.x + 12;
			text_1995.y = title_1995.y + title_1995.height + 15;
			addChild(text_1995);
			thumb_1_1995 = new sec_2_1995_thumb_1();
			thumb_1_1995.name = 'sec_2_1995_img_1';
			thumb_1_1995.x = divider4.x + 12;
			thumb_1_1995.y = text_1995.y + text_1995.height + 20;
			addChild(thumb_1_1995);
			
			//2000
			var divider5:thinLine = new thinLine();
			divider5.x = 1104;
			divider5.y = 0;
			addChild(divider5);
			title_2000 = new sec_2_2000_title();
			title_2000.x = divider5.x + 12;
			title_2000.y = 0;
			addChild(title_2000);
			text_2000 = new sec_2_2000_text();
			text_2000.x = divider5.x + 12;
			text_2000.y = title_2000.y + title_2000.height + 15;
			addChild(text_2000);
			thumb_1_2000 = new sec_2_2000_thumb_1();
			thumb_1_2000.name = 'sec_2_2000_img_1';
			thumb_1_2000.x = 1294;
			thumb_1_2000.y = text_2000.y;
			addChild(thumb_1_2000);
			thumb_2_2000 = new sec_2_2000_thumb_2();
			thumb_2_2000.name = 'sec_2_2000_img_2';
			thumb_2_2000.x = thumb_1_2000.x + thumb_1_2000.width + 10;
			thumb_2_2000.y = text_2000.y;
			addChild(thumb_2_2000);
			thumb_3_2000 = new sec_2_2000_thumb_3();
			thumb_3_2000.name = 'sec_2_2000_img_3';
			thumb_3_2000.x = 1294
			thumb_3_2000.y = thumb_1_2000.y + thumb_1_2000.height + 10;
			addChild(thumb_3_2000);
			thumb_4_2000 = new sec_2_2000_thumb_4();
			thumb_4_2000.name = 'sec_2_2000_img_4';
			thumb_4_2000.x = thumb_2_2000.x;
			thumb_4_2000.y = thumb_3_2000.y;
			addChild(thumb_4_2000);
			
			//2003
			var divider6:thinLine = new thinLine();
			divider6.x = 1602;
			divider6.y = 0;
			addChild(divider6);
			title_2003 = new sec_2_2003_title();
			title_2003.x = divider6.x + 12;
			title_2003.y = 0;
			addChild(title_2003);
			thumb_1_2003 = new sec_2_2003_thumb_1();
			thumb_1_2003.name = 'sec_2_2003_img_1';
			thumb_1_2003.x = title_2003.x;
			thumb_1_2003.y = title_2003.y + title_2003.height + 15;
			addChild(thumb_1_2003);
			thumb_2_2003 = new sec_2_2003_thumb_2();
			thumb_2_2003.name = 'sec_2_2003_img_2';
			thumb_2_2003.x = thumb_1_2003.x + thumb_1_2003.width + 10;
			thumb_2_2003.y = thumb_1_2003.y;
			addChild(thumb_2_2003);
			thumb_3_2003 = new sec_2_2003_thumb_3();
			thumb_3_2003.name = 'sec_2_2003_img_3';
			thumb_3_2003.x = thumb_2_2003.x + thumb_2_2003.width + 10;
			thumb_3_2003.y = thumb_2_2003.y;
			addChild(thumb_3_2003);
			text_2003 = new sec_2_2003_text();
			text_2003.x = divider6.x + 12;
			text_2003.y = thumb_1_2003.y + thumb_1_2003.height + 15;
			addChild(text_2003);
			
			//2007
			var divider7:thinLine = new thinLine();
			divider7.x = 1946;
			divider7.y = 0;
			addChild(divider7);
			title_2007 = new sec_2_2007_title();
			title_2007.x = divider7.x + 12;
			title_2007.y = 0;
			addChild(title_2007);
			text_2007 = new sec_2_2007_text();
			text_2007.x = divider7.x + 12;
			text_2007.y = title_2007.y + title_2007.height + 15;
			addChild(text_2007);
			thumb_1_2007 = new sec_2_2007_thumb_1();
			thumb_1_2007.name = 'sec_2_2007_img_1';
			thumb_1_2007.x = 2102;
			thumb_1_2007.y = text_2007.y;
			addChild(thumb_1_2007);
			thumb_2_2007 = new sec_2_2007_thumb_2();
			thumb_2_2007.name = 'sec_2_2007_img_2';
			thumb_2_2007.x = thumb_1_2007.x + thumb_1_2007.width + 10;
			thumb_2_2007.y = text_2007.y;
			addChild(thumb_2_2007);
			thumb_3_2007 = new sec_2_2007_thumb_3();
			thumb_3_2007.name = 'sec_2_2007_img_3';
			thumb_3_2007.x = 2102
			thumb_3_2007.y = thumb_1_2007.y + thumb_1_2007.height + 10;
			addChild(thumb_3_2007);
			thumb_4_2007 = new sec_2_2007_thumb_4();
			thumb_4_2007.name = 'sec_2_2007_img_4';
			thumb_4_2007.x = thumb_2_2007.x;
			thumb_4_2007.y = thumb_2_2007.y + thumb_2_2007.height + 10;
			addChild(thumb_4_2007);
			
		}
		
		//Private functions
		private function openBig(e:MouseEvent):void{
			grandDad.openBig(e.currentTarget.name);
		}
		
		
	}
}
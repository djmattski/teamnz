package script.model
{
	public class Model
	{
		public static const TEAM:String = 'team';
		public static const HISTORY:String = 'history';
		public static const BOATS:String = 'boats';
		public static const SPONSORS:String = 'sponsors';
		public static const PRADA:String = 'prada';
		public static const SAN_FRANCISCO:String = 'sanFran';
		public static const VOLVO_OCEAN_RACE:String = 'volvo';
		public static const LATEST_RESOURCES:String = 'resources';
		
		public static var SECTIONS:Object = new Object();
		SECTIONS[TEAM] = { id:TEAM, className:'sec_team', color:0xD4A630, nav:{ textOffsetX:-30, textOffsetY:65 } };
		SECTIONS[HISTORY] = { id:HISTORY, className:'sec_history', color:0xB33048, nav:{ textOffsetX:-30, textOffsetY:65 } };
		SECTIONS[BOATS] = { id:BOATS, className:'sec_boats', color:0x0082A7, nav:{ textOffsetX:-19, textOffsetY:65 } };
		SECTIONS[SPONSORS] = { id:SPONSORS, color:0x008241, nav:{ textOffsetX:-38, textOffsetY:65 } };
		SECTIONS[PRADA] = { id:PRADA, className:'sec_prada', color:0xEF791D, nav:{ textOffsetX:-77, textOffsetY:65 } };
		SECTIONS[SAN_FRANCISCO] = { id:SAN_FRANCISCO, className:'sec_sanfran', color:0x904F84, nav:{ textOffsetX:-74, textOffsetY:65 } };
		SECTIONS[VOLVO_OCEAN_RACE] = { id:VOLVO_OCEAN_RACE, color:0x008282, nav:{ textOffsetX:-57, textOffsetY:65 } };
		SECTIONS[LATEST_RESOURCES] = { id:LATEST_RESOURCES, color:0x006FA6, nav:{ textOffsetX:-66, textOffsetY:65 } };
		
		public static var NAVIGATION:Array = [TEAM, HISTORY, BOATS, SPONSORS, PRADA, SAN_FRANCISCO, VOLVO_OCEAN_RACE, LATEST_RESOURCES];
	}
}
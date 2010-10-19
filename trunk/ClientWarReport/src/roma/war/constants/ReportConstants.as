package roma.war.constants
{
	public class ReportConstants
	{
		/** 军队状态 **/
		public static const TROOP_STAY:String = "stay";
		public static const TROOP_MARCH:String = "march";
		public static const TROOP_ATK:String = "atk";
		public static const TROOP_THROW:String = "throw";
		public static const TROOP_BEBEATED:String = "beBeated";    // 军队受攻击的效果
		public static const TROOP_REMOVE:String = "troopRemove";   // 军队消失
		public static const EMBEDS_COMMON:String = "common";
		
		public static const RED:int = 0;
		public static const BLUE:int = 1;
		public static const HERO_MAX:Number = 3;
		
		/** 英雄状态 **/
		public static const HERO_ENTER:String = "enter";
		public static const HERO_INBATTLE:String = "inBattle";
		public static const HERO_QUIT:String = "quit";
		public static const HERO_RETREAT:String = "retreat";
		public static const HERO_WAIT:String = "wait";
		
		/** 显示文字状态 **/
		public static const TEXT_SHOW_SKILL:int = 0;
		public static const TEXT_SHOW_BYSKILL:int = 1;
		public static const TEXT_SHOW_DAMAGE:int = 3;
		public static const TEXT_SHOW_DEADCOUNT:int = 4;
		public static const TEXT_SHOW_OTHERS:int = 5;
		
	}
}
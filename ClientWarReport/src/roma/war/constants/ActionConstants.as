package roma.war.constants
{
	public class ActionConstants
	{
		/** 步兵或骑兵 都是普通的攻击 */
		public static const ATT_TYPE_NORMAL:String = "normal";
		/** 弓箭 */
		public static const ATT_TYPE_ARROW:String = "arrow";
		/** 弩炮 */
		public static const ATT_TYPE_PEG:String = "peg";
		/** 标枪 */
		public static const ATT_TYPE_JAVELIN:String = "javelin";
		/** 投石*/
		public static const ATT_TYPE_STONE:String = "stone";
		
		/** 陷阱 **/
		public static const ATT_TYPE_TRAP:String = "trap";
		/** 滚石 **/
		public static const ATT_TYPE_WALL_BUILDING_STONE:String = "wallStone";
		/** 箭塔 **/
		public static const ATT_TYPE_TOWER_ARROW:String = "towerArrow";
		
		/** weapon **/
		public static const WEAPON_TYPE:String = "weapon";
		
		/**
		 * other
		 */ 
		public static const OTHER_TYPE_BLAZE:String = "blaze";
		public static const OTHER_TYPE_SMOKE:String = "smoke";
		public static const OTHER_TYPE_CORPSE:String = "corpse";
		public static const OTHER_TYPE_PIT:String = "pit";
		public static const OTHER_TYPE_KILL:String = "kill";
		
		
		/**
		 * 1	ack				data:[k1,p1,k2,p2,mode,dmg]
		 * 2	armyMove		data:[key,pos]
		 * 3	armyQuit		data:[key,pos]
		 * 4	armyRetreat		data:[key,pos]
		 * 5	trapAttack		data:[key,pos,count]
		 * 6	unitWait		data:[key,pos]
		 * 7	trapWork		data:[trapCount,hitCount]
		 * 8	rockfallMiss	data:[key,pos]
		 * 9	rockConsume		data:[consume]
		 */ 
		public static const ACTION_TYPE_ATK:int = 1;
		public static const ACTION_TYPE_MOVE:int =2;
		public static const ACTION_TYPE_QUIT:int =3;
		public static const ACTION_TYPE_RETREAT:int = 4;
		public static const ACTION_TYPE_TRAPATTACK:int =5;
		public static const ACTION_TYPE_WAIT:int =6;
		public static const ACTION_TYPE_TRAPWORK:int =7;
		public static const ACTION_TYPE_ROCKFALLMISS:int =8;
		public static const ACTION_TYPE_ROCKCONSUME:int =9;
		
	}
	
}
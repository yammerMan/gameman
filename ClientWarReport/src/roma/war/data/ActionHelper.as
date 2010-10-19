package roma.war.data
{
	import roma.common.constants.BattleConstants;
	import roma.common.constants.TroopForConstants;
	import roma.war.constants.ActionConstants;
	import roma.war.constants.ReportConstants;
	
	public class ActionHelper
	{
		public function ActionHelper()
		{
		}
		
		/**
		 * 行为攻击方式
		 */ 
		public static function getAtkMode(troopId:int=0,actionMode:int = -1):String{
			switch(troopId){
				case TroopForConstants.T_ARCHERS:
				return ActionConstants.ATT_TYPE_ARROW;
				case TroopForConstants.T_BALLISTAS:
				return ActionConstants.ATT_TYPE_PEG;
				case TroopForConstants.T_CAVALRY:
				return ActionConstants.ATT_TYPE_NORMAL;
				case TroopForConstants.T_ONAGERS:
				return ActionConstants.ATT_TYPE_STONE;
				case TroopForConstants.T_TRIARII:
				return ActionConstants.ATT_TYPE_NORMAL;
				case TroopForConstants.T_URBAN_COHORT:
					if(actionMode == BattleConstants.MODE_RANGE)return ActionConstants.ATT_TYPE_JAVELIN;
					else return ActionConstants.ATT_TYPE_NORMAL;
				case BattleConstants.KEY_TRAP:
				return ActionConstants.ATT_TYPE_TRAP;
				case BattleConstants.KEY_ARROW_TOWER:
				return ActionConstants.ATT_TYPE_TOWER_ARROW;
				case BattleConstants.KEY_ROCK_FALL:
				return ActionConstants.ATT_TYPE_WALL_BUILDING_STONE;
				default:
				return ActionConstants.ATT_TYPE_NORMAL;
			}
		}
		
		/**
		 * 英雄行为状态
		 */ 
		public static function getBeanStates(hId:int):String{
			switch(hId){
				case 0:
				return ReportConstants.HERO_ENTER;
				case 1:
				return null;
				case 2:
				return ReportConstants.HERO_QUIT;
				default:
				return null;
			}
		}
		
		/**
		 * 军队行为状态
		 */ 
		public static function getTroopState(tId:int):String{
			switch(tId){
				case 0:
				return ReportConstants.TROOP_STAY;
				case 1:
				return ReportConstants.TROOP_MARCH;
				case 2:
				return ReportConstants.TROOP_ATK;
				case 3:
				return ReportConstants.TROOP_THROW;
				default:
				return null;
			}
		}
		
		
		
	}
}
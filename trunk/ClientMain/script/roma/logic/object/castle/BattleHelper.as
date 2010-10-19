package roma.logic.object.castle
{
	import roma.common.constants.BattleConstants;
	import roma.common.constants.FieldConstant;
	import roma.common.constants.HeroGrowthConstant;
	import roma.common.constants.ScoutConstants;
	import roma.util.MultiLang;
	
	public class BattleHelper
	{
		public static var instance:BattleHelper = new BattleHelper();
		
		public function BattleHelper()
		{
		}
		
		/**
		 * 模糊数量的描述
		 */ 
		public function getBattleVagueType(t:int):String{
			var str:String = "";
			switch(t){
				case ScoutConstants.UNDEFINED_10:
					str = MultiLang.msg('battleSituation.type.undefined10');
				break;
				case ScoutConstants.UNDEFINED_100:
					str = MultiLang.msg('battleSituation.type.undefined100');
				break;
				case ScoutConstants.UNDEFINED_500:
					str = MultiLang.msg('battleSituation.type.undefined500');
				break;
				case ScoutConstants.UNDEFINED_1000:
					str = MultiLang.msg('battleSituation.type.undefined1000');
				break;
				case ScoutConstants.UNDEFINED_2500:
					str = MultiLang.msg('battleSituation.type.undefined2500');
				break;
				case ScoutConstants.UNDEFINED_5000:
					str = MultiLang.msg('battleSituation.type.undefined5000');
				break;
				case ScoutConstants.UNDEFINED_10000:
					str = MultiLang.msg('battleSituation.type.undefined10000');
				break;
				case ScoutConstants.UNDEFINED_25000:
					str = MultiLang.msg('battleSituation.type.undefined25000');
				break;
				case ScoutConstants.UNDEFINED_50000:
					str = MultiLang.msg('battleSituation.type.undefined50000');
				break;
				case ScoutConstants.UNDEFINED_100000:
					str = MultiLang.msg('battleSituation.type.undefined100000');
				break;
				case ScoutConstants.UNDEFINED_UNLIMIT:
					str = MultiLang.msg('battleSituation.type.undefinedUnlimit');
				break;
				case ScoutConstants.UNDEFINED_UNKNOW:
					str = MultiLang.msg('battleSituation.type.undefinedUnknow');
				break;
			}
			return str;
		}
		
		public function getBattleMission(t:int,fieldType:int=13):String{
			switch(t){
				case BattleConstants.ARMY_MISSION_ATTACK:
					return MultiLang.msg('military.mission.attack');
				break;
				case BattleConstants.ARMY_MISSION_CONQUEST:
					return MultiLang.msg('diplomacy.conquest.label');
				break;
				case BattleConstants.ARMY_MISSION_INDEPENDENT:
					return MultiLang.msg('diplomacy.conquest.battle.label');
				break;
				case BattleConstants.ARMY_MISSION_LOOT:
					return MultiLang.msg('military.mission.loot');
				break;
				case BattleConstants.ARMY_MISSION_REINFORCE:
					return MultiLang.msg('military.mission.reinforce');
				break;
				case BattleConstants.ARMY_MISSION_TRAINNING:
					return fieldType==FieldConstant.TYPE_NPC_FIELD?MultiLang.msg('military.mission.manoeuvre'):MultiLang.msg('military.mission.quell');
				break;
				default:
					return "";
			}
		}
		
		public static function getMissionString(t:int):String{
			switch(t){
				case BattleConstants.ARMY_MISSION_LOOT:
				return MultiLang.msg('military.newArmy.tip.loot');
				case BattleConstants.ARMY_MISSION_CONQUEST:
				return MultiLang.msg('military.newArmy.tip.conquest');
				case BattleConstants.ARMY_MISSION_ATTACK:
				return MultiLang.msg("military.newArmy.tip.attack");
				case BattleConstants.ARMY_MISSION_REINFORCE:
				return MultiLang.msg("military.newArmy.tip.reinforce");
				case BattleConstants.ARMY_MISSION_TRAINNING:
				return MultiLang.msg("trainingRoomWin.synopsisContent");
				default:
				return "";
			}
		}
		
		public function getBeanTempleType(t:int):String{
			switch(t){
				case HeroGrowthConstant.HERO_GROWTH_TYPE_FIGHTING:
					return MultiLang.msg('hero.temper.temperDesc.fightLabel');
				break;
				case HeroGrowthConstant.HERO_GROWTH_TYPE_READING:
					return MultiLang.msg('hero.temper.temperDesc.readLabel');
				break;
				case HeroGrowthConstant.HERO_GROWTH_TYPE_INSPECTING:
					return MultiLang.msg('hero.temper.temperDesc.patrolLabel');
				break;
				case HeroGrowthConstant.HERO_GROWTH_TYPE_VISITING:
					return MultiLang.msg('hero.temper.temperDesc.interviewLabel');
				break;
				case HeroGrowthConstant.HERO_GROWTH_TYPE_TREASURING:
					return MultiLang.msg('hero.temper.temperDesc.treasureHuntLabel');
				break;
				case HeroGrowthConstant.HERO_GROWTH_TYPE_SCOUTING:
					return MultiLang.msg('hero.temper.temperDesc.enterRearLabel');
				break;
				default:
					return " hero no this temple";
			}
		}
		
	}
}
package roma.logic.object.buff.impl
{
	import flash.utils.Dictionary;
	
	import roma.common.constants.BuffConstants;
	import roma.util.MultiLang;
	
	public class BuffHelper
	{
		public static var instance:BuffHelper = new BuffHelper();
		private function buffMap:Dictionary = new Dictionary()
		
		public function BuffHelper()
		{
			initBuffMap();
		}
		
		private function initBuffMap():void{
			buffMap[BuffConstants.CASTLE_ADV_MOVE]                     ="castleadvmove";
			buffMap[BuffConstants.CASTLE_COMFORTING_COOL_DOWN]         ="castlecomfortingcooldown";
			buffMap[BuffConstants.CASTLE_LEVY_COOL_DOWN] 			   ="castlelevycooldown";
			buffMap[BuffConstants.CASTLE_MOVE_COOLDOWN]                ="castlemovecooldown";
			buffMap[BuffConstants.HERO_AWARD_COOL_DOWN]                ="herogetAwardcooldown";
			buffMap[BuffConstants.HERO_INC_ATTACK]                     ="heroincattack";
			buffMap[BuffConstants.HERO_INC_INTELLIGENCE]               ="heroincintelligence";
			buffMap[BuffConstants.HERO_INC_POLITICS]                   ="heroincpolitics";
			buffMap[BuffConstants.INC_ARMY_PERCENT]                    ="incarmypercent";
			buffMap[BuffConstants.INC_RESOURCE_PRECENT]                ="incresourceprecent";
			buffMap[BuffConstants.PLAYER_BEGINNER]                     ="playerbeginner";
			buffMap[BuffConstants.PLAYER_INC_ARMY_ATTACK]              ="playerinc_armyattack";
			buffMap[BuffConstants.PLAYER_INC_ARMY_DEFENCE]             ="playerincarmydefence";
			buffMap[BuffConstants.PLAYER_INC_FOOD_PRODUCE]             ="playerincfoodproduce";
			buffMap[BuffConstants.PLAYER_INC_GOLD_PRODUCE]             ="playerincgoldsproduce";
			buffMap[BuffConstants.PLAYER_INC_IRON_PRODUCE]             ="playerincironproduce";
			buffMap[BuffConstants.PLAYER_INC_STONE_PRODUCE]            ="playerincstoneproduce";
			buffMap[BuffConstants.PLAYER_INC_WOOD_PRODUCE]             ="playerincwoodproduce";
			buffMap[BuffConstants.PLAYER_INCREASE_CONSTRUCT_LIMIT]     ="playerincreaseconstructlimit";
			buffMap[BuffConstants.PLAYER_KEEP_SILENCE]                 ="playerkeepsilence";
			buffMap[BuffConstants.PLAYER_PEACE]                        ="playerpeace";
			buffMap[BuffConstants.PLAYER_PEACE_COOLDOWN]               ="playerpeacecooldown";
			buffMap[BuffConstants.PLAYER_TROOP_RELIVE]                 ="playertrooprelive";
			buffMap[BuffConstants.TAX_MODIFY_COOL_DOWN]                ="taxmodifycooldown";
		}
		
		public function getBuffName(type:int):String{
			var key:String = buffMap[type];
			return MultiLang.msg('buff.'+key+'.name');
		}
	}
}
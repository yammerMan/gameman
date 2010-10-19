package framework.game
{
	public interface IGameRuleHelper
	{
		/**
		 * 加入建筑规则数据
		 */
		function _b(
				building:String,
				food:int,
				wood:int,
				stone:int,
				iron:int,
				time:int,
				buff1:int,
				buff2:int,
				buff3:int,
				buildingDepends:String,
				techDepends:String,
				itemDepends:String,
				populationDepends:String
				):void;
				
		/**
		 * 加入科技规则数据
		 */
		function _t(
				tech:String,
				gold:int,
				food:int,
				wood:int,
				stone:int,
				iron:int,
				time:int,
				effect:int,
				buildingDepends:String,
				techDepends:String,
				itemDepends:String
				):void ;
				
		/**
		 * 加入军队规则数据
		 */
		function _tr(
				troopType:int,
				life:int,
				gold:int,
				food:int,
				wood:int,
				stone:int,
				iron:int,
				time:int,
				attack:int,
				defence:int,
				dmgMin:int,
				dmgMax:int,
				speed:int,
				load:int,
				foodRequest:int,
				population:int,
				buildingLevelRequest:int,
				buildingDepends:String,
				techDepends:String,
				itemDepends:String
				):void ;

		/**
		 * 加入城防规则数据
		 */
		function _f(
				fortType:int,
				life:int,
				food:int,
				wood:int,
				stone:int,
				iron:int,
				time:int,
				attack:int,
				defence:int,
				dmgMin:int,
				dmgMax:int,
				space:int,
				buildingLevelRequest:int,
				buildingDepends:String,
				techDepends:String,
				itemDepends:String
				):void;
				
		/**
		 * 加入物品规则
		 */
		function _i (
			itemId:String,
//			name:String,
			price:int,
//			itemDesc:String,
//			funcDesc:String,
			user_limit:int,
			day_limit:int,
			itemType:int,
			isHeroItem:Boolean,
			isPlayerItem:Boolean,
			keyItemId:String=null
		):void;
		
		function _q (
			id:int,
			//name:String,
			//description:String,
			questTarget:String,
			award:String
			//typeName:String,
			//manual:String
		):void;
		
		function _qt (
			typeId:int
			//name:String,
			//description:String
		):void;
		
		function _w(
			id:int,
			food:int,
			wood:int,
			stone:int,
			iron:int,
			population:int,
			time:int,
			value:int,
			severancePay:int
		):void;
		
		
		/**
		 * 加入盟库规则数据
		 */
		function _a(
				level:int,
				food:int,
				wood:int,
				stone:int,
				iron:int,
				gold:int,
				memberLimit:int,
				maxCap:int
				):void ;
		
		
		
		
	}
}
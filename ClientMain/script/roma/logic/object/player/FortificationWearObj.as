package roma.logic.object.player
{
	import roma.common.constants.BuildingConstant;
	import roma.common.constants.TroopForConstants;
	import roma.common.constants.TechConstant;
	import roma.logic.GameContext;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.object.tech.BaseTechObj;
	import roma.logic.rule.BuildingRule;
	import roma.logic.rule.ForticationRule;
	import roma.logic.rule.GameRuleHelper;
	
	/**
	 *建筑学、维修技术 
	 */	  
	
	[Bindable]
	public class FortificationWearObj
	{
		/**建筑学加成，城墙、箭塔耐久值增加的百分比*/
		public var wearAddPercent:int;
		
		/**城墙耐久值*/
		public var wallWear:Number;
		
		/**箭塔耐久值*/
		public var arrowTowerWear:Number;
		
		/**维修技术加成，陷阱、箭塔、落石修复率增加的百分比*/
		public var fortRepairAddPercent:int;
		
		/**陷阱修复率*/
		public var trapRepRate:Number;
		
		/**箭塔修复率*/
		public var arrowTowerRepRate:Number;
		
		/**落石修复率*/
		public var rockfallRepRate:Number;
		
		public function FortificationWearObj()
		{
		}
		
		/**
		 *重新计算城墙、箭塔耐久值 
		 */		
		public function reCalculateWear(castle:CastleObj,level:int):void{
			var techObj:BaseTechObj = GameContext.instance.getPlayerObj().techManager.getTechObjById(TechConstant.ARCHITECTURE);
			var wallRule:BuildingRule = GameRuleHelper.instance.getBuildingRule(BuildingConstant.TYPE_WALL_BUILDING,level);
			var arrowTowerRule:ForticationRule = GameRuleHelper.instance.getForticationRule(TroopForConstants.F_ARROWTOWER);
			this.wearAddPercent = techObj.getCurCastleTechRule(castle).effect;
			
			this.wallWear = wallRule.buff1(100+this.wearAddPercent)/100;
			this.arrowTowerWear = arrowTowerRule.life(100+this.wearAddPercent)/100;
		}

		/**
		 *重新计算城防工事修复率
		 */		
		public function reCalcFortRepairRate():void{
			//TODO
		}
	}
}
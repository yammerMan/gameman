package roma.logic.rule
{
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.rule.ruleCheck.RuleCheckResult;
	
	public class BuildingRule extends BaseRule
	{
		public var type:int;
		public var buildingLevel:int;
		public var buff1:int;
		public var buff2:int;
		public var buff3:int;
		
		public function BuildingRule(
				building:String,
				golds:int,
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
				populationDepends:String) {
			super(food,wood,golds,iron,stone,time,itemDepends,techDepends,buildingDepends,populationDepends);
			
			var index:int = building.indexOf(".");
			this.type = int(building.substring(0,index));
			this.buildingLevel = int(building.substring(index+1));
			
			this.buff1 = buff1;
			this.buff2 = buff2;
			this.buff3 = buff3;
		}
		
		override public function check(buildingObj:BaseBuilding=null):RuleCheckResult {
			var res:RuleCheckResult = super.check();
			GameContext.instance.getPlayerObj().getCurCastleObj().effectBuildingTime(res);
			return res;
		} 
	}
}
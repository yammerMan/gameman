package roma.logic.rule
{
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.rule.ruleCheck.RuleCheckResult;
	
	public class TechRule extends BaseRule
	{
		public var techKey:String;
		public var techEffect:int;
		
		public function TechRule(
				tech:String,
				golds:int,
				food:int,
				wood:int,
				stone:int,
				iron:int,
				time:int,
				techEffection:int,
				buildingDepends:String,
				techDepends:String,
				itemDepends:String
				) {
			super(food,wood,golds,iron,stone,time,itemDepends,techDepends,buildingDepends);
			techKey = tech;
			techEffect = techEffection;		
		}

		override public function check(buildingObj:BaseBuilding=null):RuleCheckResult {
			var res:RuleCheckResult = super.check();
			GameContext.instance.getPlayerObj().getCurCastleObj().effectTechTime(res);
			return res;
		} 
	}
}
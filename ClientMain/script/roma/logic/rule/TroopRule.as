package roma.logic.rule
{
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.rule.ruleCheck.RuleCheckResult;
	
	
	[Bindable]
	public class TroopRule extends BaseRule 
	{
		public var troop:int;
		public var life:int;
		public var attack:int;
		public var defence:int;
		public var dmgMin:int;
		public var dmgMax:int;
		public var speed:int;
		public var load:int;
		public var foodRequest:int;
		public var population:int;
		public var buildingLevelRequest:int;
		
		public function TroopRule(
				troop:int,
				life:int,
				golds:int,
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
				) {
			super(food,wood,golds,iron,stone,time,itemDepends,techDepends,buildingDepends);
			this.troop = troop   ;
			this.life       = life       ;
			this.attack     = attack     ;
			this.defence    = defence    ;
			this.dmgMin     = dmgMin     ;
			this.dmgMax     = dmgMax     ;
			this.speed      = speed      ;
			this.load       = load       ;
			this.foodRequest= foodRequest;
			this.population = population ;
			this.buildingLevelRequest = buildingLevelRequest;
		}

		override public function check(buildingObj:BaseBuilding=null):RuleCheckResult {
			var res:RuleCheckResult = super.check();
			GameContext.instance.getPlayerObj().getCurCastleObj().effectTroopProduceTime(res,buildingObj);
			return res;
		} 
	}
}
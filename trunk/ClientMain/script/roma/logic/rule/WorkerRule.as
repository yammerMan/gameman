package roma.logic.rule
{
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.rule.ruleCheck.RuleCheckResult;
	
	[Bindable]
	public class WorkerRule extends BaseRule
	{
		public var id:int;
		public var food:int;
		public var wood:int;
		public var stone:int;
		public var iron:int;
		public var population:int;
		public var time:int;
		public var value:int;
		public var severancePay:int;
		
		public function WorkerRule(
			id:int,
			food:int,
			wood:int,
			stone:int,
			iron:int,
			population:int,
			time:int,
			value:int,
			severancePay:int)
		{
			super(food,wood,0,iron,stone,time,null,null,null);
			this.id = id;
			this.food = food;
			this.wood = wood;
			this.stone = stone;
			this.iron = iron;
			this.population = population;
			this.time = time;
			this.value = value;
			this.severancePay = severancePay;
		}
		
		override public function check(buildingObj:BaseBuilding=null):RuleCheckResult {
			var res:RuleCheckResult = super.check();
			GameContext.instance.getPlayerObj().getCurCastleObj().effectWorkerTrainningTime(res,buildingObj);
			return res;
		} 
	}
}
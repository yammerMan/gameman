package roma.logic.rule
{
	[Bindable]
	public class AllianceRule
	{
		public var allianceLevel:int;
		public var food:int;
		public var wood:int;
		public var stone:int;
		public var iron:int;
		public var golds:int;
		public var memberLimit:int;
		public var maxCap:int;
		
		public function AllianceRule(
				allianceLevel:int,
				food:int,
				wood:int,
				stone:int,
				iron:int,
				golds:int,
				memberLimit:int,
				maxCap:int)
				{
					this.allianceLevel=allianceLevel;
					this.food=food;
					this.wood=wood;
					this.stone=stone;
					this.iron=iron;
					this.golds=golds;
					this.memberLimit=memberLimit;
					this.maxCap=maxCap;
				}

	}
}
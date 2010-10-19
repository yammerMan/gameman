package roma.logic.rule
{
		
	[Bindable]
	public class ForticationRule extends BaseRule 
	{
		public var fortType:int;
		public var fortLife:int;
		public var fortAttack:int;
		public var fortDefence:int;
		public var dmgMin:int;
		public var dmgMax:int;
		public var fortSpace:int;
		public var buildingLevelRequest:int;

		public function ForticationRule(
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
			){
			super(food,wood,0,iron,stone,time,itemDepends,techDepends,buildingDepends);
			this.fortType = fortType;
			this.fortLife     = life    ;
			this.fortAttack   = attack  ;
			this.fortDefence  = defence ;
			this.dmgMin   = dmgMin  ;
			this.dmgMax   = dmgMax  ;
			this.fortSpace    = space   ;
			this.buildingLevelRequest = buildingLevelRequest;
		}
	}
}
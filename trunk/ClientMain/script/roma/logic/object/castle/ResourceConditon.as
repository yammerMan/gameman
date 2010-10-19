package roma.logic.object.castle
{
	import roma.common.constants.BuildingConstant;
	import roma.common.constants.InteriorConstant;
	import roma.logic.object.building.BuildingHelper;
	import roma.logic.rule.GameRuleHelper;
	import roma.util.MultiLang;
	
	[Bindable]
	public class ResourceConditon
	{
		public var castleLevel:int;
		public var needLevel:int;
		public var needItemNum:int;
		public var needFood:Number;
		public var needWood:Number;
		public var needIron:Number;
		public var needStone:Number;
		public var needGold:Number;
		public var itemStr:String;
		public var townLevelStr:String;
			
		public function ResourceConditon(castlelevel:int,level:int,num:int,food:Number,wood:Number,iron:Number,stone:Number,golds:Number)
		{
			this.castleLevel = castlelevel;
			this.needLevel   = level;
			this.needItemNum =num;
			this.needFood    = food;
			this.needWood    = wood;
			this.needIron    = iron;
			this.needStone   = stone;
			this.needGold    = golds;
			
			this.itemStr = GameRuleHelper.instance.getItemRuleById(InteriorConstant.EXPAND_CASTLE_ITEM).name+" x "+num;
			this.townLevelStr = BuildingHelper.instance.getName(BuildingConstant.TYPE_TOWN_HALLS) + " " + MultiLang.msg("public.label.level") +" "+ level;
		}
	}
}
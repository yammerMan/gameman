package roma.logic.object.tech.impl
{
	import roma.common.constants.BuildingConstant;
	import roma.logic.object.tech.BaseTechObj;

	/**
	 * 步兵技巧.每升1级，步兵的攻击能力增加3%，20级后弓手获得散射能力，可以同时攻击战场上所有敌军，散射时对每支部队的伤害值是攻击单一部队的25%。
	 * 这一技能可通过战术设定来决定是否使用。
	 */
	public class InfantrySkill extends BaseTechObj
	{
		public function InfantrySkill()
		{
			super();
		}
		
		override protected function getDependBuildingType():int{
			return BuildingConstant.TYPE_MILITARY_INSTITUTE;
		}
	}
}
package roma.logic.object.tech.impl
{
	import roma.common.constants.BuildingConstant;
	import roma.logic.object.tech.BaseTechObj;

	/**
	 * 骑兵技巧.每升1级，骑兵和斥候的攻击能力增加3%，20级后骑兵获得突袭能力，可以攻击直线上2支敌军，后排敌军所受伤害减半。
	 */
	public class EquestrianSkill extends BaseTechObj
	{
		public function EquestrianSkill()
		{
			super();
		}
		
		override protected function getDependBuildingType():int{
			return BuildingConstant.TYPE_MILITARY_INSTITUTE;
		}
	}
}
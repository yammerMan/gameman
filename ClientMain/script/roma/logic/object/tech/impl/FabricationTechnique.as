package roma.logic.object.tech.impl
{
	import roma.common.constants.BuildingConstant;
	import roma.logic.object.tech.BaseTechObj;

	/**
	 * 制造技术 每升1级，弩炮、投石器、箭塔和落石的攻击能力增加3%，20级后弩炮将获得穿透能力，可以同时攻击直线上前后2排的敌人，攻击后排敌人的伤害值减半。
	 */
	public class FabricationTechnique extends BaseTechObj
	{
		public function FabricationTechnique()
		{
			super();
		}
		
		override protected function getDependBuildingType():int{
			return BuildingConstant.TYPE_MILITARY_INSTITUTE;
		}
	}
}
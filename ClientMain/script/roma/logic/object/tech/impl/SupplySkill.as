package roma.logic.object.tech.impl
{
	import roma.common.constants.BuildingConstant;
	import roma.logic.object.castle.CastleResourceManager;
	import roma.logic.object.tech.BaseTechObj;
	import roma.logic.rule.TechRule;

	/**
	 * 补给技巧.每升1级，军队的耗粮减少3%
	 */
 	public class SupplySkill extends BaseTechObj 
	{
		public function SupplySkill()
		{
			super();
		}

		override protected function getDependBuildingType():int{
			return BuildingConstant.TYPE_MILITARY_INSTITUTE;
		}
	}
}
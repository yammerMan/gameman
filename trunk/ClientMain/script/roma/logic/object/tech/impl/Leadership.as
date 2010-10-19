package roma.logic.object.tech.impl
{
	import roma.common.constants.BuildingConstant;
	import roma.logic.object.tech.BaseTechObj;

	/**
	 * 领导能力.每升1级，英雄所率领的部队人数就增加3%
	 */
 	public class Leadership extends BaseTechObj
	{
		public function Leadership()
		{
			super();
		}

		override protected function getDependBuildingType():int{
			return BuildingConstant.TYPE_MILITARY_INSTITUTE;
		}
	}
}
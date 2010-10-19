package roma.logic.object.tech.impl
{
	import roma.common.constants.BuildingConstant;
	import roma.logic.object.tech.BaseTechObj;

	/**
	 * 救援技巧.每升1级，军队的生命或耐久值增加3%
	 */
	public class MedicalTechnology extends BaseTechObj
	{
		public function MedicalTechnology()
		{
			super();
		}

		override protected function getDependBuildingType():int{
			return BuildingConstant.TYPE_MILITARY_INSTITUTE;
		}
	}
}
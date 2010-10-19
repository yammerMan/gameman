package roma.logic.object.tech.impl
{
	import roma.common.constants.BuildingConstant;
	import roma.logic.object.tech.BaseTechObj;

	/**
	 * 后勤学.每升1级，军队的负重能力提升3%
	 */
 	public class Logistics extends BaseTechObj
	{
		public function Logistics()
		{
			super();
		}
		
		override protected function getDependBuildingType():int{
			return BuildingConstant.TYPE_MILITARY_INSTITUTE;
		}
	}
}
package roma.logic.object.tech.impl
{
	import roma.common.constants.BuildingConstant;
	import roma.logic.object.tech.BaseTechObj;

	/**
	 * 行军技巧.每升1级，军队的大地图移动速度增加3%
	 */
	public class MarchAbility extends BaseTechObj
	{
		public function MarchAbility()
		{
			super();
		}

		override protected function getDependBuildingType():int{
			return BuildingConstant.TYPE_MILITARY_INSTITUTE;
		}
	}
}
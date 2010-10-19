package roma.logic.object.tech.impl
{
	import roma.common.constants.BuildingConstant;
	import roma.logic.object.castle.CastleResourceManager;
	import roma.logic.object.tech.BaseTechObj;

	/**
	 * 防御技巧.每升1级，军队的防御能力上升3%
	 */
	public class DefenceSkill extends BaseTechObj 
	{
		public function DefenceSkill()
		{
			super();
		}
		
		override protected function getDependBuildingType():int{
			return BuildingConstant.TYPE_MILITARY_INSTITUTE;
		}
	}
}
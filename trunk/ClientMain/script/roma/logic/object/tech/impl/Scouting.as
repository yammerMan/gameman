package roma.logic.object.tech.impl
{
	import roma.common.constants.BuildingConstant;
	import roma.logic.object.tech.BaseTechObj;

	/**
	 * 侦查技术.每升1级，侦察与反侦察能力就越强
	 */
	public class Scouting extends BaseTechObj
	{
		public function Scouting()
		{
			super();
		}

		override protected function getDependBuildingType():int{
			return BuildingConstant.TYPE_MILITARY_INSTITUTE;
		}
	}
}
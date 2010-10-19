package roma.data
{
	import roma.logic.object.building.BaseBuilding;
	
	public class BuildingData
	{
		public var buildingWinshowId:String;
		public var buildingObj:BaseBuilding;
		public var data:Object;
		
		public function BuildingData(buildingWinshowId:String, buildingObj:BaseBuilding , data:Object=null)
		{
			this.buildingWinshowId = buildingWinshowId;
			this.buildingObj = buildingObj;
			this.data = data;
		}
	}
}
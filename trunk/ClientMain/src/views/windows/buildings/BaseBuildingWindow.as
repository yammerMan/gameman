package views.windows.buildings
{
	import roma.logic.object.building.BaseBuilding;
	
	import views.windows.BaseWin;

	public class BaseBuildingWindow extends BaseWin
	{
		[Bindable]
		public var buildingObj:BaseBuilding;
		public function BaseBuildingWindow()
		{
			super();
		}
	}
}
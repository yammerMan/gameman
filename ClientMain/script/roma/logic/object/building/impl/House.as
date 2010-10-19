package roma.logic.object.building.impl
{
	import animation.IAniPlayer;
	import animation.aniSet.building.HouseAniSet;
	
	import roma.common.valueObject.ArchitectureBean;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.object.castle.CastleResourceManager;
	import roma.logic.rule.BuildingRule;
	import roma.logic.rule.GameRuleHelper;
	import roma.util.MultiLang;
	
	import views.PopupWindows;
	import views.windows.buildings.house.HouseWin;

	/**
	 * 
	 * 民房
	 */
	public class House extends BaseBuilding 
	{
		public function House(bean:ArchitectureBean)
		{
			super(bean);
		}

		override public function isUniqueType():Boolean {
			return false;
		}

		/** 需要覆盖的方法 */
		override public function onClick():void {
			PopupWindows.openBuildingInfoWin(HouseWin.WINDOW_SHOW , this);
		}

		/** 获得建筑的动画*/
		override protected function getNormalAniPLayer():IAniPlayer {
			return new HouseAniSet();			
		}
	}
}
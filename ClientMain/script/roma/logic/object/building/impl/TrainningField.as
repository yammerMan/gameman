package roma.logic.object.building.impl
{
	import animation.AniPlayer;
	import animation.AnimationManager;
	import animation.IAniPlayer;
	import animation.aniSet.building.TrainningFieldAniSet;
	
	import roma.common.valueObject.ArchitectureBean;
	import roma.logic.object.building.BaseBuilding;
	
	import views.PopupWindows;
	import views.windows.buildings.trainningField.TrainningFieldWin;

	/**
	 * 
	 * 校场
	 * 
	 */
	public class TrainningField extends BaseBuilding
	{
		public function TrainningField(bean:ArchitectureBean)
		{
			super(bean);
		}

		/**
		 * 重写父类的方法
		 * 点击弹出界面
		 **/
		override public function onClick():void {
			PopupWindows.openBuildingInfoWin(TrainningFieldWin.WINDOW_SHOW ,this);
		}

		/** 获得建筑的动画*/
		override protected function getNormalAniPLayer():IAniPlayer {
			return new TrainningFieldAniSet();
		}
	}
}
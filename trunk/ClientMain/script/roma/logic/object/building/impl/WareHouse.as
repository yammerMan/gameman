package roma.logic.object.building.impl
{
	import animation.AniPlayer;
	import animation.AnimationManager;
	import animation.IAniPlayer;
	
	import roma.common.action.ControllerFactory;
	import roma.common.controller.CommonResponse;
	import roma.common.valueObject.ArchitectureBean;
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	import roma.util.MultiLang;
	
	import views.MainContainer;
	import views.PopupWindows;
	import views.spreadUI.MyAlert;
	import views.windows.buildings.warehouse.WareHouseWin;

	/**
	 * 
	 * 仓库
	 * 
	 */
	public class WareHouse extends BaseBuilding 
	{
		public function WareHouse(bean:ArchitectureBean)
		{
			super(bean);
		}

		/**
		 * 不是唯一性建筑
		 */ 
		override public function isUniqueType():Boolean {
			return false;
		}
		
		/**
		 * 重写父类的方法
		 * 点击弹出界面
		 **/
		override public function onClick():void {
			PopupWindows.openBuildingInfoWin(WareHouseWin.WINDOW_SHOW ,this);
		}

		/** 获得建筑的动画*/
		override protected function getNormalAniPLayer():IAniPlayer {
			return new AniPlayer(AnimationManager.buildings.warehouseNormal);			
		}
		
		/*修改仓库容量*/
		public function modify(food:int,wood:int,stone:int,iron:int):void{
			ControllerFactory.getInstance().getCityController().modifyStoreRate(GameContext.instance.getPlayerObj().getCurCastleObj().cityId,
			food,wood,stone,iron,callback);
			function callback(event:CommonResponse):void{
				if(event.isSuccess()){
					MainContainer.instance.risePlay(MultiLang.msg("wareHouse.modifySucess"));
				}else{
					MyAlert.showError(event);
				}
			}
		}
	}
}
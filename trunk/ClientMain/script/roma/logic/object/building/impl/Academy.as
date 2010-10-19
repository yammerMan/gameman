package roma.logic.object.building.impl
{
	import animation.AniPlayer;
	import animation.AnimationManager;
	import animation.IAniPlayer;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.constants.TechConstant;
	import roma.common.valueObject.ArchitectureBean;
	import roma.logic.object.building.BaseBuilding;
	
	import views.PopupWindows;
	import views.windows.buildings.BaseTechWindow;

	public class Academy extends BaseBuilding
	{
		private static var log:ILogger = Log.getLogger("roma.logic.object.building.impl.Academy");
		
		public function Academy(bean:ArchitectureBean)
		{
			super(bean);
		}
		
		/**
		 * 学院
		 * 重写父类的方法
		 * 点击弹出界面
		 **/
		override public function onClick():void {
			PopupWindows.openBuildingInfoWin(BaseTechWindow.WINDOW_SHOW ,this);
		}

		/** 需要覆盖的方法 */
		override protected function getNormalAniPLayer():IAniPlayer {
			return new AniPlayer(AnimationManager.buildings.academyNormal);			
		}
		
		public function getPeopleTechAry():ArrayCollection{
			//一定顺序排序
			return new ArrayCollection([TechConstant.FARMING,TechConstant.WOODCUTTING,TechConstant.QUARRYING,TechConstant.METALLURGY,
										TechConstant.ESTATES,TechConstant.WAREHOUSING,TechConstant.ARCHITECTURE,TechConstant.LEARNING,
										TechConstant.REPAIR_TECHNIQUES]);
		}
		
		public function getAcademyAccPer():Number{
			var res:Number = (this.getCurLevelBuildingRule() != null)?(this.getCurLevelBuildingRule().buff1/100):0;
			return res;
		}
	}
}
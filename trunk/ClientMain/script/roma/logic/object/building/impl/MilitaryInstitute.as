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
	
	/**
	 *军事学院 
	 */
	public class MilitaryInstitute extends BaseBuilding
	{
		private static var log:ILogger = Log.getLogger("roma.logic.object.building.impl.MilitaryInstitute");

		public function MilitaryInstitute(bean:ArchitectureBean)
		{
			super(bean);
		}
		
		/**
		 * 重写父类的方法
		 * 点击弹出界面
		 **/
		override public function onClick():void {
			PopupWindows.openBuildingInfoWin(BaseTechWindow.WINDOW_SHOW ,this);
		}

		/** 获得建筑的动画*/
		override protected function getNormalAniPLayer():IAniPlayer {
			return new AniPlayer(AnimationManager.buildings.militaryInstituteNormal);			
		}

		public function getArmyTechAry():ArrayCollection{
			//一定顺序排序
			return new ArrayCollection([TechConstant.INFANTRY_SKILL,TechConstant.EQUESTRIAN_SKILL,TechConstant.FABRICATION_TECHNIQUE,
				TechConstant.SCOUTING,TechConstant.LEADERSHIP,TechConstant.DEFENCE_SKILL,TechConstant.MEDICAL_TECHNOLOGY,
				TechConstant.LOGISTICS,TechConstant.MARCH_ABILITY,TechConstant.SUPPLY_SKILL_TYPE]);		
		}
		
		public function getMilitaryAccPer():Number{
			var res:Number = (this.getCurLevelBuildingRule() != null)?(this.getCurLevelBuildingRule().buff1/100):0;
			return res;
		}
	}
}
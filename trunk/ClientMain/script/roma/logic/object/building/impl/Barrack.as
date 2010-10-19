package roma.logic.object.building.impl
{
	import animation.AniPlayer;
	import animation.AnimationManager;
	import animation.IAniPlayer;
	
	import mx.collections.ArrayCollection;
	
	import roma.common.constants.TroopForConstants;
	import roma.common.valueObject.ArchitectureBean;
	import roma.logic.object.building.BaseBuilding;
	
	import views.PopupWindows;
	import views.windows.buildings.BaseTroopWindow;

	public class Barrack extends BaseBuilding
	{
		public function Barrack(bean:ArchitectureBean)
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
			PopupWindows.openBuildingInfoWin(BaseTroopWindow.WINDOW_SHOW ,this);
		}

		/** 需要覆盖的方法 */
		override protected function getNormalAniPLayer():IAniPlayer {
			return new AniPlayer(AnimationManager.buildings.barrackNormal);			
		}
		
		public function getbarrackAccPer():Number{
			var res:Number  = 0;
			if(this.getCurLevelBuildingRule() != null){
				res= this.getCurLevelBuildingRule().buff1/100;
			}
			return res;
		}
		
		public function getTroopAry():ArrayCollection{
			return new ArrayCollection([TroopForConstants.T_TRIARII,TroopForConstants.T_ARCHERS,TroopForConstants.T_URBAN_COHORT]);		
		}
//		/** 获得建筑的功能说明 ， 需要覆盖的方法*/
//		override public function getFuncDesc(level:int):String {
//			if (level>0 && level < BuildingConstant.HIGHEST_LEVEL+1) {
//				var rule:BuildingRule = GameRuleHelper.instance.getBuildingRule(this.typeId , level);
//				if(rule.buff2!=0){
//					return  BuildingHelper.instance.getFuncDesc(this.typeId,rule.buildingLevel, rule.buff1 , rule.buff2);
//				}
//				if(rule.buff1!=0){
//					return Lang.msg("building.barrack.funcSpecial",rule.buildingLevel,BuildingHelper.instance.getName(this.typeId), rule.buff1);
//				}
//			} 
//			return "";
//		}
	}
}
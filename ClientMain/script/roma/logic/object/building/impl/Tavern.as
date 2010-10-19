package roma.logic.object.building.impl
{
	import animation.AniPlayer;
	import animation.AnimationManager;
	import animation.IAniPlayer;
	
	import roma.common.constants.BuildingConstant;
	import roma.common.valueObject.ArchitectureBean;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.object.building.BuildingHelper;
	import roma.logic.rule.BuildingRule;
	import roma.logic.rule.GameRuleHelper;
	
	import views.PopupWindows;
	import views.windows.buildings.tavern.TavernWin;

	/**
	 * 
	 *酒馆
	 * 
	 */
	public class Tavern extends BaseBuilding
	{
		public function Tavern(bean:ArchitectureBean)
		{
			super(bean);
		}
		
		
		/**
		 * 重写父类的方法
		 * 点击弹出界面
		 **/
		override public function onClick():void {
			PopupWindows.openBuildingInfoWin(TavernWin.WINDOW_SHOW ,this);
		}

		/** 获得建筑的动画*/
		override protected function getNormalAniPLayer():IAniPlayer {
			return new AniPlayer(AnimationManager.buildings.tavernNormal);			
		}
		
		/** 获得建筑的功能说明 ， 需要覆盖的方法*/
//		override public function getFuncDesc(level:int):String {
//			if (level>0 && level < BuildingConstant.HIGHEST_LEVEL+1) {
//				var rule:BuildingRule = GameRuleHelper.instance.getBuildingRule(this.typeId , level);
//				if(rule.buff3!=0){
//					return BuildingHelper.instance.getFuncDesc(this.typeId,rule.buildingLevel, rule.buff1 , rule.buff3, rule.buff2,"1~"+rule.buildingLevel*2);
//				}else if(rule.buff2!=0){
//					return BuildingHelper.instance.getFuncDesc(this.typeId,rule.buildingLevel, rule.buff1 , rule.buff3);
//				}else{
//					return BuildingHelper.instance.getFuncDesc(this.typeId,rule.buildingLevel, rule.buff1);
//				}
//				
//			} else {
//				return "";
//			}
//		}
		
	}
}
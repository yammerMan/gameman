package roma.logic.object.building.impl
{
	import animation.AniPlayer;
	import animation.AnimationManager;
	import animation.IAniPlayer;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.constants.BuildingConstant;
	import roma.common.valueObject.ArchitectureBean;
	import roma.common.valueObject.MaterialBean;
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.object.hero.HeroObj;
	import roma.logic.object.player.ItemResManager;
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.ItemRule;
	
	import views.PopupWindows;
	import views.windows.buildings.herosMansion.HerosMansionWin;

	public class HerosMansion extends BaseBuilding
	{
		private var log:ILogger = Log.getLogger("roma.logic.object.building.impl.HerosMansion");
		
		public function HerosMansion(bean:ArchitectureBean)
		{
			super(bean);
		}

		/**
		 * 英雄馆
		 * 重写父类的方法
		 * 点击弹出界面
		 **/
		override public function onClick():void {
			PopupWindows.openBuildingInfoWin(HerosMansionWin.WINDOW_SHOW ,this);
		}

		/** 获得建筑的动画*/
		override protected function getNormalAniPLayer():IAniPlayer {
			return new AniPlayer(AnimationManager.buildings.herosMansionNormal);			
		}
		
		/**
		 * 英雄馆空闲空间
		 */ 
		public function getBeanSpace():int{
			if (this.level>0) {
				var lev:int = GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_HEROS_MANSION).level;
				return GameRuleHelper.instance.getBuildingRule(BuildingConstant.TYPE_HEROS_MANSION,lev).buff1;
			} else {
				return 0;
			}
		}
		
	}
}
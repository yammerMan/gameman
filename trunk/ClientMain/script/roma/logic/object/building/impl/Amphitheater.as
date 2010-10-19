package roma.logic.object.building.impl
{
	import animation.AniPlayer;
	import animation.AnimationManager;
	import animation.IAniPlayer;
	
	import mx.collections.ArrayCollection;
	
	import roma.common.constants.BuffConstants;
	import roma.common.valueObject.ArchitectureBean;
	import roma.logic.GameContext;
	import roma.logic.object.buff.BaseBuffObj;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.object.hero.HeroObj;
	
	import views.PopupWindows;
	import views.windows.buildings.amphitheater.AmphitheaterWin;

	public class Amphitheater extends BaseBuilding
	{
		public function Amphitheater(bean:ArchitectureBean)
		{
			super(bean);
		}
		
		/**
		 * 重写父类的方法
		 * 点击弹出界面
		 **/
		override public function onClick():void {
			PopupWindows.openBuildingInfoWin(AmphitheaterWin.WINDOW_SHOW ,this);
		}

		/** 获得建筑的动画*/
		override protected function getNormalAniPLayer():IAniPlayer {
			return new AniPlayer(AnimationManager.buildings.amphitheatreNormal);			
		}
		
		/** 使用物品前，先检查是否有"增加同时历练的英雄数目"的buff */
		public function checkUseItem():Boolean{
			return GameContext.instance.getPlayerObj().buffManager.hasBuff(BuffConstants.PLAYER_INC_GROWING_HERO_COUNT);
		}
		
		public function getBeanTemperList():int{
			var count:int = 0;
			var arr:ArrayCollection = GameContext.instance.getPlayerObj().getCurCastleObj().heroManager.heroArray;
			for each(var i:HeroObj in arr){
				if(i.heroInfo.growthEndTime >0){
					count ++;
				}
			}
			return count;
		}
			
	}
}
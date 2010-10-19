package roma.logic.object.building.impl
{
	import animation.AniPlayer;
	import animation.AnimationManager;
	import animation.IAniPlayer;
	
	import flash.display.BitmapData;
	
	import roma.common.valueObject.ArchitectureBean;
	import roma.logic.object.building.BaseBuilding;
	
	import views.PopupWindows;
	import views.windows.buildings.resBuilding.ResUnityWin;

	public class Farm extends BaseBuilding
	{
		public function Farm(bean:ArchitectureBean)
		{
			super(bean);
		}
		
		/**
		 * 农田
		 * 重写父类的方法
		 * 点击弹出界面
		 **/
		override public function onClick():void {
			PopupWindows.openBuildingInfoWin(ResUnityWin.WINDOW_SHOW ,this);
		}

		/** 需要覆盖的方法 */
		override protected function getNormalAniPLayer():IAniPlayer {
			return new AniPlayer(AnimationManager.buildings.farmNormal);			
		}

		override protected function initAni():void {
			this.normalAniPlayer = new AniPlayer(AnimationManager.buildings.farmNormal);
			this.addConstructingAni(AnimationManager.buildings.workingPeople , 25 , 60);
			this.addConstructingAni(AnimationManager.buildings.workingPeople , 80 , 48);
			
			this.levelBgPlayer.sceneX=0;
			this.levelBgPlayer.sceneY=19;
			
			this.levelDigitalPlayer1.sceneX = this.levelBgPlayer.sceneX+7;
			this.levelDigitalPlayer1.sceneY = this.levelBgPlayer.sceneY+7;
			this.levelDigitalPlayer2.sceneX = this.levelBgPlayer.sceneX+12;
			this.levelDigitalPlayer2.sceneY = this.levelBgPlayer.sceneY+7;

			this.levelDigitalPlayer3.sceneX = this.levelBgPlayer.sceneX+7;
			this.levelDigitalPlayer3.sceneY = this.levelBgPlayer.sceneY+7;
			this.levelDigitalPlayer4.sceneX = this.levelBgPlayer.sceneX+12;
			this.levelDigitalPlayer4.sceneY = this.levelBgPlayer.sceneY+7;
		}
		
		override public function drawToBitmapData(screen:BitmapData, x:int, y:int):void{
			if (this.isConstructing()) {
				//画建造时的动画
				this.normalAniPlayer.gotoAndPlay(screen,x,y);
				this.drawWorkingPeopleToSecne(screen,x,y);				
								
			} else {
				this.normalAniPlayer.gotoAndPlay(screen,x,y);
			}
			this.drawLevel(screen , x , y);
		}
		
		/** 获得建筑的功能说明 ， 需要覆盖的方法*/
//		override public function getFuncDesc(level:int):String {
//			if (level>0 && level < BuildingConstant.HIGHEST_LEVEL+1) {
//				var rule:BuildingRule = GameRuleHelper.instance.getBuildingRule(this.typeId , level);
//				if(rule.buff2!=0){
//					return  BuildingHelper.instance.getFuncDesc(this.typeId,rule.buildingLevel, rule.buff1 , rule.buff2);
//				}
//				if(rule.buff1!=0){
//					return Lang.msg("building.farm.funcSpecial",rule.buildingLevel,BuildingHelper.instance.getName(this.typeId), rule.buff1);
//				}
//			} 
//			return "";
//		}
	}
}
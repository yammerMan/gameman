package roma.logic.object.building.impl
{
	import animation.AniPlayer;
	import animation.AnimationManager;
	
	import flash.display.BitmapData;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.InteriorConstant;
	import roma.common.controller.CommonResponse;
	import roma.common.controller.castle.ResourceStaticResponse;
	import roma.common.valueObject.ArchitectureBean;
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.object.castle.CastleLevelConstant;
	import roma.util.MultiLang;
	
	import views.MainContainer;
	import views.PopupWindows;
	import views.spreadUI.MyAlert;
	import views.windows.buildings.townHall.TownHallWin;
	
	public class TownHall extends BaseBuilding
	{
		private static var log:ILogger = Log.getLogger('roma.logic.object.building.impl.TownHall');
		
		private var fountainAni:AniPlayer = new AniPlayer(AnimationManager.buildings.fountainAni);
		private var fountainAni2:AniPlayer = new AniPlayer(AnimationManager.buildings.fountainAni);
		
		private var frontFenceAni:AniPlayer = new AniPlayer(AnimationManager.buildings.townHallFrontFenceAni);
		private var backFenceAni:AniPlayer = new AniPlayer(AnimationManager.buildings.townHallBackFenceAni);
		
		public function TownHall(bean:ArchitectureBean)	{
			super(bean);
		}

		/** 需要覆盖的方法 */
		override public function onClick():void {
			PopupWindows.openBuildingInfoWin(TownHallWin.WINDOW_SHOW , this);
		}

		/** 需要覆盖的方法 */
		override public function drawToBitmapData(screen:BitmapData, x:int, y:int):void{
			//喷泉动画
			this.fountainAni.gotoAndPlay(screen,25,110);
			this.fountainAni2.gotoAndPlay(screen,85,148);
			if (this.isConstructing()) {
				//画建造时的动画
				this.backFenceAni.gotoAndPlay(screen,56,42);
				this.normalAniPlayer.gotoAndPlay(screen,x,y);
				this.frontFenceAni.gotoAndPlay(screen,56,42);
				
				this.drawWorkingPeopleToSecne(screen,x,y);				
			} else {
				this.normalAniPlayer.gotoAndPlay(screen,x,y);
			}
			
			this.drawLevel(screen , x , y);
		}
		
		public function getTownnHallBuildingAccPer():Number {
			var res:Number = this.getCurLevelBuildingRule().buff1 / 100 
			return res;
		}
		
		override protected function initAni():void {
			this.normalAniPlayer = new AniPlayer(AnimationManager.buildings.townHallNormal);
			this.addConstructingAni(AnimationManager.buildings.workingPeople1 , 56 , 114);
			this.addConstructingAni(AnimationManager.buildings.workingPeople , 120 , 125);
			this.addConstructingAni(AnimationManager.buildings.workingPeople , 178 , 114);
			this.addConstructingAni(AnimationManager.buildings.workingPeople , 208 , 99);
			
			this.levelBgPlayer.sceneX=133;
			this.levelBgPlayer.sceneY=52;
			
			this.levelDigitalPlayer3.sceneX =this.levelDigitalPlayer1.sceneX = 140;
			this.levelDigitalPlayer3.sceneY =this.levelDigitalPlayer1.sceneY=59;
			this.levelDigitalPlayer4.sceneX =this.levelDigitalPlayer2.sceneX = 145;
			this.levelDigitalPlayer4.sceneY =this.levelDigitalPlayer2.sceneY=59;
		}
		
		/**修改税率*/
		public function changeTex(submitTaxRate:int,callbackFunction:Function=null):void{
			if(submitTaxRate==GameContext.instance.getPlayerObj().getCurCastleObj().resourceManager.texRate)return;
			ControllerFactory.getInstance().getCityController().modifyTaxRate(GameContext.instance.getPlayerObj().getCurCastleObj().getCityId(),submitTaxRate,callback);
			function callback(event:CommonResponse):void
	 		{
	 			if(event.isSuccess()){
					MainContainer.instance.risePlay(MultiLang.msg("townHall.label.ChangetaxRateSuccess"));
					GameContext.instance.getPlayerObj().getCurCastleObj().resourceManager.texRate=submitTaxRate;
					if(callbackFunction!=null){
						callbackFunction.apply(this);
					}
				} else {
					MyAlert.showError(event);
				}
	 		}
		}
		
		
		/**修改开工率*/
		public function modifyOpeoRate(foodRate:int,woodRate:int,stoneRate:int,ironRate:int,callbackFun:Function=null):void{
			ControllerFactory.getInstance().getCityController().modifyOperRate(GameContext.instance.getPlayerObj().getCurCastleObj().getCityId(),foodRate,woodRate,stoneRate,ironRate,callback);
			function callback(event:CommonResponse):void
			{
	   			if(event.isSuccess()){
	   				if(callbackFun!=null){
	   					callbackFun.apply(this,[event]);
	   				}
				} else {
					MyAlert.showError(event);
				}
	   		}
		}
		
		/**城市改名*/
		public function cityChangeName(name:String,logoUrl:String,logoSource:*):void{
			ControllerFactory.getInstance().getCityController().modifyCityName(GameContext.instance.getPlayerObj().getCurCastleObj().getCityId(),name,logoUrl,1,callback);
			function callback(event:CommonResponse):void
			{
	   			if(event.isSuccess()){
	   				GameContext.instance.getPlayerObj().getCurCastleObj().name=name;
	   				GameContext.instance.getPlayerObj().getCurCastleObj().logoUrl=logoUrl;
					MainContainer.instance.risePlay(MultiLang.msg("townHall.label.ChangeCityNameSuccess"));
				} else {
					MyAlert.showError(event);
				}
	   		}
		}
		
		/**
		 * 增加建筑排程
		 * @param fun
		 */
		public function addBuildingProcess(fun:Function = null):void{
			var onAddBuildingProcess:Function = function(event:CommonResponse):void{
				if(event.isSuccess()){
					log.debug('add building process successful');
					
					if(fun !=null){
						MainContainer.instance.risePlay(MultiLang.msg("townHall.label.increatBuilting.successTip"));
						fun.apply(this,[event]);
					}
				}else{
					MyAlert.showError(event)				
				}				
			}
			
			ControllerFactory.getInstance().getBuildingController().increaseConstructLimit(onAddBuildingProcess);
		}
		
		/**
		 *城池扩建 
		 */
		public function extendCastle(fun:Function=null):void{
			var onExtendCastle:Function = function(event:CommonResponse):void{
				if(event.isSuccess()){
					//setCastleLevel();
					if(fun!=null){
						fun.apply(this);
					}
					
					log.debug("current castle level is: "+castle.level)
					MainContainer.instance.risePlay(MultiLang.msg('public.extendCastle.success',castle.level+1));
				}else{
					MyAlert.showError(event);
				}
			}
			
			log.debug("start extend castle");			
			ControllerFactory.getInstance().getCityController().expandCastle(this.castle.cityId,onExtendCastle);
		}
		
		
		/**
		 *获取资源生产数据
		 */
		public function getResourceStatics(fun:Function=null):void{
			var resourceStatics:Function = function(event:ResourceStaticResponse):void{
				if(event.isSuccess()){
					if(fun!=null){
						fun.apply(this,[event]);
					}
				}else{
					MyAlert.showError(event);
				}
			}
					
			ControllerFactory.getInstance().getCityController().resourceStatics(this.castle.cityId,resourceStatics,false);
		}
		
		private function setCastleLevel():void{
			if(this.level>=InteriorConstant.FIRST_EXPAND_TOWNHALL_LEVEL_DEPEND && this.level<InteriorConstant.SECOND_EXPAND_TOWNHALL_LEVEL_DEPEND){
				this.castle.level = CastleLevelConstant.CASTLE_LEVEL_TWO;
			}else if(this.level >= InteriorConstant.SECOND_EXPAND_TOWNHALL_LEVEL_DEPEND && this.level<InteriorConstant.THIRD_EXPAND_TOWNHALL_LEVEL_DEPEND){
				this.castle.level = CastleLevelConstant.CASTLE_LEVEL_THREE;
			}else{
				this.castle.level = CastleLevelConstant.CASTLE_LEVEL_FOUR;
			}
		}
		
		/** 获得建筑的功能说明 ， 需要覆盖的方法*/
//		override public function getFuncDesc(level:int):String {
//			if (level>0 && level < BuildingConstant.HIGHEST_LEVEL+1) {
//				var rule:BuildingRule = GameRuleHelper.instance.getBuildingRule(this.typeId , level);
//				if(rule.buff2!=0){
//					return  BuildingHelper.instance.getFuncDesc(this.typeId,rule.buildingLevel, rule.buff1 , rule.buff2);
//				}
//				if(rule.buff1!=0){
//					return Lang.msg("building.townHall.funcSpecial",rule.buildingLevel,BuildingHelper.instance.getName(this.typeId), rule.buff1);
//				}
//			} 
//			return "";
//		}
	}
}
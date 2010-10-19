			import flash.events.MouseEvent;
			
			import mx.collections.ArrayCollection;
			import mx.events.ItemClickEvent;
			import mx.events.ListEvent;
			import mx.logging.ILogger;
			import mx.logging.Log;
			
			import roma.common.action.ControllerFactory;
			import roma.common.constants.BuildingConstant;
			import roma.common.constants.GeneralConstants;
			import roma.common.controller.CommonResponse;
			import roma.common.events.HeroManUpdate;
			import roma.logic.GameContext;
			import roma.logic.object.building.BaseBuilding;
			import roma.logic.object.castle.CastleObj;
			import roma.logic.object.hero.HeroObj;
			import roma.message.EvtDispacther;
			import roma.message.events.HerosEvent;
			
			import views.PopupWindows;
			import views.spreadUI.MyAlert;
			import views.windows.buildings.amphitheater.AmphitheaterWin;
			import views.windows.functionWins.hero.HeroHelper;
			
			public static const WINDOW_SHOW:String = "herosMansionWin.show";
			public static var DISCHARGE_CHIEF:String = "dischargeLeader";
			public static const WINDOW_SHOW_WEAVE:String="herosMansionWin.showWeaveWin";
			public static const WINDOW_SHOW_OUTFIT:String="herosMansionWin.showOutfitWin";
			public static const WINDOW_SHOW_CAMPAIGN:String="herosMansionWin.showCampaignWin";

			private static var log:ILogger = Log.getLogger("views.windows.buildings.herosMansion");
			
			private var cityId:int;
			
			[Bindable]
			private var showWinId:int;
			
			[Bindable]
			private var cityComData:Array=new Array();
			
			private var curSelectCastle:CastleObj;

			[Bindable]
			private var curHero:HeroObj;
			[Bindable]
			private var heroArray:ArrayCollection = GameContext.instance.getPlayerObj().getCurCastleObj().heroManager.heroArray;
			
			/**
			 *每次界面弹出调用，刷新数据
			 */ 
			override public function refresh():void{
				log.debug("winData={0}" , winData);

				this.cityId = GameContext.instance.getPlayerObj().getCurCastleObj().cityId;
				this.heroArray = GameContext.instance.getPlayerObj().getCurCastleObj().heroManager.heroArray;
				
				/* curHero = HeroObj(this.winData); */
				curHero = HeroHelper.instance.curSelectHero;
//				this.eventData = null;
				if(curHero == null){
					
				}else{
					this.cityId = curHero.castleObj.cityId;
					this.heroArray = GameContext.instance.getPlayerObj().getCastleObjById(cityId).heroManager.heroArray;
				}
				getCityArr();
				
				reset();
			}
			
			/**
			 * 界面隐藏调用，停止当前窗体一切相关动画等
			 */ 
			override public function destroy():void{
			}
			
			private function init():void{
				EvtDispacther.instance.addEventListener(HerosEvent.HERO_UPDATE,onHeroManUpdateResponse);
			}
			
			private function reset():void{
				for (var i:int=0; i< this.heroArray.length; i++) {
					var hero:HeroObj = HeroObj(this.heroArray[i]);
					hero.selectedInUi = false;
					if (curHero == null) {
						curHero = hero;
					}
				}
				if(curHero != null){
					curHero.selectedInUi = true;
					curHero.updateHeroObj();
				}
				if(this.initialized){
					 this.heroViewStack.selectedIndex=this.showWinId;
					 this.updateViewer(this.showWinId);
					//this.heroTroops.refresh(heroProperty.subCall);
				}
			}
			
			/**
			 * 获得城池列表
			 */ 
			private function getCityArr():void{
				this.cityComData=GameContext.instance.getPlayerObj().getAllCastle();
				for(var i:int=0;i<this.cityComData.length;i++){
					if (CastleObj(this.cityComData[i]).cityId==GameContext.instance.getPlayerObj().getCurCastleObj().cityId){
						this.cityCom.selectedIndex=i;
						HeroHelper.instance.curSelectCastle=GameContext.instance.getPlayerObj().getCurCastleObj();
						this.curSelectCastle = GameContext.instance.getPlayerObj().getCurCastleObj();
						break;
					}
				}
				this.checkHero();
			}
			
				/**
			 * 选择了城池
			 */
			public function onCitySelected(event:ListEvent):void {
				HeroHelper.instance.curSelectCastle=this.cityComData[event.currentTarget.selectedIndex];
				curSelectCastle=HeroHelper.instance.curSelectCastle;
				HeroHelper.instance.curSelectHero=null;
				checkHero();
				this.reset();
			}
			
			private function checkHero():void{
				this.curHero=HeroHelper.instance.curSelectHero;
				if(HeroHelper.instance.curSelectCastle == null){
					
				}else{
					this.curSelectCastle = HeroHelper.instance.curSelectCastle;
					this.heroArray = HeroHelper.instance.curSelectCastle.heroManager.heroArray;
				}
				
				for (var i:int=0; i< this.heroArray.length; i++) {
					var hero:HeroObj = HeroObj(this.heroArray[i]);
					hero.selectedInUi = false;
					if (curHero == null) {
						curHero = hero;
						HeroHelper.instance.curSelectHero=hero;
					}
				}
				if(curHero != null){
					curHero.selectedInUi = true;
					curHero.updateHeroObj();
				}
				
			}
			
			private function updateViewer(index:int):void{
				switch(index){
					case 0:
						this.heroPropertyView.hero=this.curHero;
						break;
					case 1:
						this.heroWeaveView.refresh();
						break;
					case 2:
						this.heroOutfitView.hero=this.curHero;
						break;
					case 3:	
						this.heroCampaignView.refreshFromMapTile(this.curHero,HeroHelper.instance.targetMapTileData);
						break;
					default:
				}
				this.showWinId=index;
			}
			
			public function gotoTargetWin(winId:String):void{
				switch(winId){
					case HerosMansionWin.WINDOW_SHOW:
						this.showWinId=0;
					break;
					case HerosMansionWin.WINDOW_SHOW_WEAVE:
						this.showWinId=1;
					break;
					case HerosMansionWin.WINDOW_SHOW_OUTFIT:
						this.showWinId=2;
					break;
					case HerosMansionWin.WINDOW_SHOW_CAMPAIGN:
						this.showWinId=3;
					break;
					
					default:
				}
				this.reset();
			}
			
			public function onHeroItemClick(data:Object):void{
				/* if (this.curHero!=null) {
					this.curHero.selectedInUi = false;
				} */
				curHero = HeroObj(data);
				/* curHero.selectedInUi = true; */
				HeroHelper.instance.curSelectHero=curHero;
				curHero.updateHeroObj();
				reset();
			}
			
			private function callHireHero():void{
				var callBuilding:BaseBuilding = GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_AMPHITHEATRE);
				if(callBuilding)
				{PopupWindows.openBuildingInfoWin(AmphitheaterWin.WINDOW_SHOW,callBuilding);}
				else{
					MyAlert.show(MultiLang.msg('building.isNotExist'));
				}
			}
			
			private function callTrainHero():void{
				var callBuilding:BaseBuilding = GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_AMPHITHEATRE);
				if(callBuilding)
				{PopupWindows.openBuildingInfoWin(AmphitheaterWin.WINDOW_SHOW,callBuilding,"heroTrain");}
				else{
					MyAlert.show(MultiLang.msg('building.isNotExist'));
				}
			}
			
			/**
			 * 有英雄更新的相应 
			 */ 
			private function onHeroManUpdateResponse(event:HerosEvent):void{
				var updateEvent:HeroManUpdate = HeroManUpdate(event.evtData);
				if(updateEvent.updateType == GeneralConstants.UPDATE_DELETE_TYPE){
					if(heroArray.length >0){
						this.curHero = heroArray[0] as HeroObj;
						curHero.selectedInUi = true;
					}
				}
				this.reset();
			}
			
			
			private function organizingTroop():void{
				
			}
			
			private function sortHeroByBtn(event:MouseEvent):void{
				var isUp:Boolean=false;
				if(event.currentTarget==this.upBtn){
					isUp=true;
					if(curHero.heroInfo.sort>0){
						ControllerFactory.getInstance().getHeroController().sortHero(GameContext.instance.getPlayerObj().getCurCastleObj().cityId,curHero.heroInfo.id,curHero.heroInfo.sort-1,callback);	
					}
				}else{
					if(curHero.heroInfo.sort<heroArray.length-1){
						ControllerFactory.getInstance().getHeroController().sortHero(GameContext.instance.getPlayerObj().getCurCastleObj().cityId,curHero.heroInfo.id,curHero.heroInfo.sort+1,callback);
						
					}
				}
				function callback(event:CommonResponse):void{
					if(event.success){
						var tempHero:HeroObj;
						if(isUp){
							tempHero=HeroObj(heroArray.getItemAt(curHero.heroInfo.sort-1));
							heroArray.setItemAt(tempHero,curHero.heroInfo.sort);
							heroArray.setItemAt(curHero,curHero.heroInfo.sort-1);
							curHero.heroInfo.sort=curHero.heroInfo.sort-1;
							tempHero.heroInfo.sort=tempHero.heroInfo.sort+1;
						}else{
							tempHero=HeroObj(heroArray.getItemAt(curHero.heroInfo.sort+1));
							heroArray.setItemAt(tempHero,curHero.heroInfo.sort);
							heroArray.setItemAt(curHero,curHero.heroInfo.sort+1);
							curHero.heroInfo.sort=curHero.heroInfo.sort+1;
							tempHero.heroInfo.sort=tempHero.heroInfo.sort-1;
						}
						GameContext.instance.getPlayerObj().getCurCastleObj().heroManager.heroArrCheck();
						EvtDispacther.sendEvent(EvtDispacther.HERO_SORT_CHANGE);
					}else{
						MyAlert.showError(event);
					}
				}
			}
			
			private function clickHandler(event:ItemClickEvent):void {
				this.showWinId=event.index;
				this.reset();
			}

// ActionScript file
		import flash.events.Event;
		
		import gs.TweenLite;
		import gs.easing.Back;
		
		import mx.logging.ILogger;
		import mx.logging.Log;
		
		import roma.data.BuildingData;
		import roma.logic.object.building.BaseBuilding;
		import roma.logic.object.player.ConquestObj;
		import roma.message.EvtDispacther;
		import roma.message.events.WindowSwitchEvent;
		import roma.util.PopupWinManager;
		
		import views.PopupWindows;
		import views.mainFrame.PurResourcesWin;
		import views.mainModules.map.CastleInfoWin;
		import views.mainModules.map.IMapTile;
		import views.mainModules.map.TrainingRoomWin;
		import views.mainModules.town.NewBuildingWindow;
		import views.spreadUI.MyAlert;
		import views.windows.BaseWin;
		import views.windows.functionWins.alliance.Alliance;
		import views.windows.functionWins.diplomacy.DiplomacyWin;
		import views.windows.functionWins.diplomacy.VassalMesWin;
		import views.windows.functionWins.hero.HerosMansionWin;
		import views.windows.functionWins.intelligence.BattleSituationDetail;
		import views.windows.functionWins.intelligence.FieldBattleWin;
		import views.windows.functionWins.intelligence.IntelligenceWin;
		import views.windows.functionWins.mail.Mail;
		import views.windows.functionWins.military.AssignTroopWin;
		import views.windows.functionWins.military.GoingToWarWin;
		import views.windows.functionWins.playInfo.PlayerLogoWin;
		import views.windows.functionWins.shop.Shop;
		
		public static var instance:PopupWindows;
		
		private static var log:ILogger = Log.getLogger("views.PopupWindows");
		
		private var map:Dictionary = new Dictionary();

		public var curWin:BaseWin = null;
	
		public var lastWin:BaseWin=null;
		
		public var prevWin:BaseWin = null;
	
		private function init():void{
			log.debug("init()");
			instance=this;
			
			this.x = (1000 -this.width)/2;
			this.y = -this.height;

			initWinMap();

			this.addEventListener(Event.ENTER_FRAME,frameHandler);
			
			EvtDispacther.instance.addEventListener(WindowSwitchEvent.EVENT_CHANGE,popupWindowChange);
		}
			
		private function initWinMap():void{
		    map[Alliance.WINDOW_SHOW] = this.unionWin;
			map[OutAllianceWin.WINDOW_SHOW] = this.outAllianceWin;
			map[DomesticAffairsWin.WINDOW_SHOW] = this.domesticAffairsWin;
			map[FriendlyWin.WINDOW_SHOW] = this.friendlyWin;
			map[IntelligenceWin.WINDOW_SHOW] = this.intelligenceWin;
			map[FieldBattleWin.WINDOW_SHOW] = this.fieldBattleWin;
			map[DiplomacyWin.WINDOW_SHOW] = this.diplomacyWin;
			map[LordPanelWin.WINDOW_SHOW] = this.lordPanelWin;
			map[Mail.WINDOW_SHOW] = this.mailWin;
			map[RankingWin.WINDOW_SHOW] = this.rankingWin;
			map[Shop.WINDOW_SHOW] = this.storeWin;
			map[TaskWin.WINDOW_SHOW] = this.taskWin;
			map[NewBuildingWindow.WINDOW_SHOW] = this.consNewBuildingWin;
			map[BuildingInfoWindow.WINDOW_SHOW] = this.buildingWindowInfo;
			map[MyItemsWin.WINDOW_SHOW] = this.myItemsWin;
			map[KingInfoWin.WINDOW_SHOW] = this.kingInfoWin;
			map[PlayerLogoWin.WINDOW_SHOW] = this.playerLogoWin;
			map[AssignTroopWin.WINDOW_SHOW] = this.assignTroopWin;
			map[PurResourcesWin.WINDOW_SHOW] = this.buyItemResourceWin;
			map[HerosMansionWin.WINDOW_SHOW] = this.herosMansionWin;
			map[HerosMansionWin.WINDOW_SHOW_WEAVE] = this.herosMansionWin;
			map[HerosMansionWin.WINDOW_SHOW_OUTFIT] = this.herosMansionWin;
			map[HerosMansionWin.WINDOW_SHOW_CAMPAIGN] = this.herosMansionWin;
			map[CastleInfoWin.WINDOW_SHOW] = this.castleInfoWin;
			map[GoingToWarWin.WINDOW_SHOW] = this.createArmyWin;
			map[BattleSituationDetail.WINDOW_SHOW] = this.battleSituationDetail;
			map[VassalMesWin.WINDOW_SHOW] = this.vassalMesWin;
			map[TrainingRoomWin.WINDOW_SHOW] = this.trainingRoomWin;
		}
			
		/**
		 * 弹出窗口侦听器
		 */ 
		private function popupWindowChange(event:WindowSwitchEvent):void{
			log.debug("popupWindowChange. id={0}" , event.getEvtId());

			PopupWinManager.instance.removePopup();
			MyAlert.close();
			if (this.curWin != null) {
				this.prevWin = curWin;
				this.curWin.destroy();
				this.curWin = null;
			}
			if (event.getEvtId() == BuildingInfoWindow.WINDOW_SHOW){
				this.height=410;
				this.width=820;
			} else if (event.getEvtId() == Shop.WINDOW_SHOW||event.getEvtId() == MyItemsWin.WINDOW_SHOW || event.getEvtId() == TaskWin.WINDOW_SHOW || 
					event.getEvtId() == Mail.WINDOW_SHOW || event.getEvtId() == DiplomacyWin.WINDOW_SHOW || event.getEvtId() == IntelligenceWin.WINDOW_SHOW || event.getEvtId()== FieldBattleWin.WINDOW_SHOW){
				this.height=400;
				this.width=800;
			} else if(event.getEvtId() == OutAllianceWin.WINDOW_SHOW){
				this.width = 398;
				this.height = 230;
			} else if(event.getEvtId() == FriendlyWin.WINDOW_SHOW){
				this.height=384;
				this.width=408;
			} else if(event.getEvtId() == KingInfoWin.WINDOW_SHOW){
				this.height=305;
				this.width=392;
			} else if(event.getEvtId() == PlayerLogoWin.WINDOW_SHOW){
				this.width = 394;
				this.height = 270;
			}else if(event.getEvtId() == PurResourcesWin.WINDOW_SHOW){
				this.width = 460;
				this.height = 386;
			}else if(event.getEvtId() == CastleInfoWin.WINDOW_SHOW){
				this.width = 650;
				this.height = 400;
				this.castleInfoWin.setMapTile(IMapTile(event.eventData));
			}else if(event.getEvtId() == TrainingRoomWin.WINDOW_SHOW){
				this.width = 650;
				this.height = 400;
				this.trainingRoomWin.setMapTile(IMapTile(event.eventData));
			}else if(event.getEvtId() == VassalMesWin.WINDOW_SHOW){
				this.width = 650;
				this.height = 390;
				this.vassalMesWin.setVassalMesBean(ConquestObj(event.eventData));
			}else if(event.getEvtId() == GoingToWarWin.WINDOW_SHOW){
				this.width = 700;
				this.height = 386;
			}else if(event.getEvtId() == RankingWin.WINDOW_SHOW){
				this.height=400;
				this.width=800;
				if(event.eventData!=null && event.getEvtId() == RankingWin.WINDOW_SHOW){
					this.rankingWin.gotoRanking(event.eventData.winId);
				}
			}else if(event.getEvtId() == HerosMansionWin.WINDOW_SHOW||event.getEvtId() == HerosMansionWin.WINDOW_SHOW_WEAVE || event.getEvtId() == HerosMansionWin.WINDOW_SHOW_OUTFIT|| event.getEvtId() == HerosMansionWin.WINDOW_SHOW_CAMPAIGN){
				this.height=400;
				this.width=800;
				this.herosMansionWin.gotoTargetWin(event.getEvtId());
				
			}else{
				if(event.getEvtId() != WindowSwitchEvent.WINDOW_CLOSE_ID){
					this.height=384;
					this.width=820;
				}
			}
			
			if (event.getEvtId() == WindowSwitchEvent.WINDOW_CLOSE_ID){
				this.lastWin = null;
				this.prevWin = null;
				TweenLite.to(this,0.5,{y:-this.height,ease:Back.easeIn,onComplete:onMovecomplete});
			} else {
				this.curWin = BaseWin(this.map[event.getEvtId()]);
				if (curWin !=null) {
					this.curWin.winData = event.eventData;
					this.curWin.winId = event.getEvtId();
					this.currentPopupWin.selectedChild = this.curWin;
					this.curWin.onShowUpdate();
					this.visible = true;
					this.movePopupWin();
					
					if(curWin != lastWin){
						lastWin = curWin;
					}
				} else {
					log.error("popupWindowChange. ({0}) not found" , event.getEvtId());
				}
			}
			
			this.x = (1000 -this.width)/2;

			if(curWin !=null)this.curWin.bShow = event.getBl();
		}
		
		private function onMovecomplete():void{
			this.visible = false;
		}
		
 		private function onMoveOutcomplete():void{
			//this.mask.y = -10;
		} 
		
		private function movePopupWin():void{
			//Turntable.getInstance().hide();
			
			this.removeListener();
			
 			if(curWin !=lastWin){
				this.y = - this.height;
			}
		
			if(curWin!=null){
				if(curWin.initialized && this.y<=-this.height){
					TweenLite.to(this,0.5,{y:(440-this.height)/2+20,ease:Back.easeOut,onComplete:onMoveOutcomplete});	
				}else{
					this.addListener();
				}					
			}else{
				this.removeListener();
			}
			
		}
		
		private var count:int=0;
		private function frameHandler(event:Event):void{
			count++;
			if(count<5)return;
			count =0;
			if(curWin==null)return;
			if(curWin.initialized){
				this.removeListener();
				TweenLite.to(this,0.5,{y:(440-this.height)/2+20,ease:Back.easeOut,onComplete:onMoveOutcomplete});	
			}
		}
		
		private function addListener():void{
			if(!this.hasEventListener(Event.ENTER_FRAME)){
				this.addEventListener(Event.ENTER_FRAME,frameHandler);
			}
		}
		
		private function removeListener():void{
			this.removeEventListener(Event.ENTER_FRAME,frameHandler);	
		}
		
		/**
		 * 重设窗口大小
		 * 
		 */
		public function resetSize(w:int,h:int):void{
			this.width=w;
			this.height=h;
			this.curWin.width=w;
			this.curWin.height=h;
		}
		
		/**
		 * 打开新建建筑的选择窗口
		 */
		public static function openNewBuildingWinAtPosition(position:int):void {
			EvtDispacther.instance.eventDispatch(NewBuildingWindow.WINDOW_SHOW , {position:position});
		}
		
		/**
		 * 打开某个建筑的窗口
		 */
		public static function openBuildingInfoWin(winId:String, buildingObj:BaseBuilding , otherData:Object=null):void {
			EvtDispacther.instance.eventDispatch(BuildingInfoWindow.WINDOW_SHOW , new BuildingData(winId , buildingObj , otherData));
		}
		
		/**
		 * 切换到某个窗口
		 * 添加一个布尔值，判断是否显示返回按钮
		 */
		public static function openFuncWin(winId:String, data:Object=null,b:Boolean=false):void {
			EvtDispacther.instance.eventDispatch(winId,data,b);
		}
		
		public static function closeAll():void {
			EvtDispacther.instance.eventDispatch(WindowSwitchEvent.WINDOW_CLOSE_ID);				
		}
		

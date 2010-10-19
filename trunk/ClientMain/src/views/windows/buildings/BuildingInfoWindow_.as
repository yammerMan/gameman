// ActionScript file
			import flash.events.Event;
			
			import mx.collections.ArrayCollection;
			import mx.logging.ILogger;
			import mx.logging.Log;
			
			import roma.common.constants.BuildingConstant;
			import roma.common.valueObject.PostTransportBean;
			import roma.data.BuildingData;
			import roma.logic.GameContext;
			import roma.logic.object.building.BaseBuilding;
			import roma.logic.object.building.BuildingHelper;
			import roma.logic.object.castle.TradeManager;
			import roma.logic.object.tech.BaseTechObj;
			import roma.logic.rule.ruleCheck.RuleCheckResult;
			import roma.message.EvtDispacther;
			import roma.message.events.BuildingStatusChangeEvent;
			import roma.message.events.WindowSwitchEvent;
			import roma.util.InputTextHelper;
			import roma.util.MultiLang;
			
			import views.PopupWindows;
			import views.mainModules.town.DismantlePanel;
			import views.spreadUI.MyAlert;
			import views.spreadUI.tips.CommonTooltip;
			import views.spreadUI.tips.ConditionTip;
			import views.spreadUI.tips.ToolTipContainer;
			import views.windows.buildings.BaseTechWindow;
			import views.windows.buildings.BaseTroopWindow;
			import views.windows.buildings.resBuilding.ResUnityWin;
			import views.windows.buildings.trainningField.BruiseTroopData;
			
			public static const WINDOW_SHOW:String ="buildingWindowInfo.show";
			
			private static var log:ILogger =Log.getLogger("views.windows.buildings.BuildingInfoWindow");
			
			private var map:Dictionary = new Dictionary();

			[Bindable]
			private var buildingObj:BaseBuilding = null;

			[Bindable]
			private var upgradeBtnEnable:Boolean = false; 
			
			[Bindable]
			private var btnSpeedupEnable:Boolean = true; 

//			[Bindable]
//			private var btnUpgradeVisible:Boolean = true; 
			
			[Bindable]
			private var destructBtnVisible:Boolean = true;
			
			[Bindable]
			private var typeName:String;
			
			[Bindable]
			private var buildingIcon:String; 
			
			[Bindable]
			private var isConstructing:Boolean = false;

			[Bindable]
			private var remainTimeStr:String
			
			[Bindable]
			private var finishTimeStr:String
			
			[Bindable]
			private var buildingDes:String;
			
			[Bindable]
			private var buildingFunctionDesc:String;
			
			[Bindable]
			private var buildingFunctionDescShort:String;
			
			[Bindable]
			private var levelIcon:Class;

			private var ruleCheckResult:RuleCheckResult;
			
			private var ruleCheckResultForDegrade:RuleCheckResult;
			
			private var lastWin:BaseBuildingWindow = null;
			private var buildingWin:BaseBuildingWindow;
			
			private var conditionTooptip:ConditionTip = ToolTipContainer.instance.conditionTooltip;
			
			private var commonTooltip:CommonTooltip = ToolTipContainer.instance.commonTooltip;
			
						
			private function init():void {
				log.debug("beforeInit()");
				//建筑窗口数组
			    map[BaseTroopWindow.WINDOW_SHOW]     = troopWindow         ;
			    map[BaseTechWindow.WINDOW_SHOW]      = techWindow          ;
			    map[HouseWin.WINDOW_SHOW]            = houseWin            ;
			    map[WareHouseWin.WINDOW_SHOW]        = wareHouseWin        ;
			    map[DakWin.WINDOW_SHOW]              = dakWin              ;
			    map[TempleWin.WINDOW_SHOW]           = templeWin           ;
			    map[MarketWin.WINDOW_SHOW]           = marketWin           ;
			    map[TownHallWin.WINDOW_SHOW]         = townHallWin         ;
			    map[TrainningFieldWin.WINDOW_SHOW]   = trainningFieldWin   ;                   
			    map[WallWin.WINDOW_SHOW]             = wallWin             ;
			    map[ResUnityWin.WINDOW_SHOW]         = resUnityWin         ;
			    map[AmphitheaterWin.WINDOW_SHOW]     = amphitheaterWin     ;
	
				this.addEventListener(Event.ENTER_FRAME,frameHandler);

				var onBuildingStatusChange:Function = function(event:BuildingStatusChangeEvent):void {
					if(isShow()){
						checkBuildingCondition();
						buildingWin.refresh();
					}
				}
				EvtDispacther.instance.addEventListener(BuildingStatusChangeEvent.EVENT_NAME, onBuildingStatusChange);
			}
			
			private var count:int =0;
			private function frameHandler(event:Event):void{
				count++;
				if (this.count< this.stage.frameRate) {
					return;
				}
				count =0;
				
				this.checkBuildingCondition();
				this.buildingWin.update();
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
			 *每次打开界面刷新 
			 */ 
			override public function refresh():void{
				if(this.winData ==null){
					throw new Error("eventData is null ");
				}

				if ( this.winData.buildingWinshowId == ""){
					throw new Error("winData.buildingWinshowId:  "+this.winData.buildingWinshowId);
				}

				var data:BuildingData = this.winData as BuildingData;
				this.buildingObj = data.buildingObj;
				
				this.typeName = this.buildingObj.getName();
				this.buildingIcon = this.buildingObj.getLogoClass();
				this.buildingDes = this.buildingObj.getDesc();
				this.buildingFunctionDesc=this.buildingObj.getFunctionDesc();
				this.buildingFunctionDescShort=this.addMore(this.buildingObj.getFunctionDesc());
				
				this.buildingWin = map[data.buildingWinshowId] as BaseBuildingWindow;
				this.buildingWin.winData = this.winData;
				this.buildingWin.buildingObj=data.buildingObj;
				this.buildingWin.onShowUpdate();
				
				
				this.checkBuildingCondition();//先检查一次条件
				this.addListener();
				
				currentBuildingWin.selectedChild = this.buildingWin;

				log.debug("refresh() winId={0} , position={1}, name={2}, data={3}" , 
					data.buildingWinshowId , 
					data.buildingObj.position,
					data.buildingObj.getName(),
					data.data
					);
				
				if (lastWin!=null && this.lastWin != this.buildingWin) {
					lastWin.destroy();
				}
				this.lastWin = this.buildingWin; 
				
				this.destructBtnVisible = this.buildingObj.isCanDestruct();
				this.levelIcon=BuildingHelper.instance.getDiffLevelIcon(this.buildingObj.level);
				if(data.data!=null){
					this.buildingWin.gotoWin(data);
				}
			}
			
			private function addMore(str:String):String{
				return InputTextHelper.reviseAppointNumContentHandle(str,150,2.5);
			}
		
			/** 判断建筑升级条件是否满足 **/
			private function checkBuildingCondition():void{
				this.isConstructing = buildingObj.isConstructing();
				this.btnSpeedupEnable = this.isConstructing;
				this.upgradeBtnEnable = !this.isConstructing;

				if (this.buildingObj.isConstructing()) {
					//正在建筑， 显示取消按钮，显示加速按钮，显示时间
					curCan1.selectedChild = cancelCan;
					curCan2.selectedChild = speedCan;
					
					this.remainTimeStr ="("+ MultiLang.timeFormatToString(this.buildingObj.getRemainTimeSec())+")";
					this.finishTimeStr = GameContext.toConstructionLocalTimeStr(this.buildingObj.finishTime);
				} else {
					//正常状态
					if (this.buildingObj.level ==0) {
						//如果是降到0级就自动关闭窗口
						PopupWindows.closeAll();
					}
										
					curCan1.selectedChild = destructCan;
					curCan2.selectedChild = upgradeCan;
					
					if (this.buildingObj.level < BuildingConstant.HIGHEST_LEVEL) {
						this.ruleCheckResult = this.buildingObj.getRuleCheckResultForUpgrade();
						this.upgradeBtnEnable = this.ruleCheckResult.isMatch;
					} else {
						//当10级的时候直接禁掉升级按钮
						this.upgradeBtnEnable = false;
					}
					
					if(this.buildingObj.level>0&&this.buildingObj.level < BuildingConstant.HIGHEST_LEVEL+1){
						this.ruleCheckResultForDegrade=this.buildingObj.getRuleCheckResultForDegrade();
					}else{
						this.ruleCheckResultForDegrade=null;
					}
				}
			}
			  
			/**
			 * 界面隐藏调用，停止当前窗体一切相关动画等
			 */ 
			override public function destroy():void{
				log.debug("destroy()");
				super.destroy();
				if (this.lastWin != null) {
					this.lastWin.destroy();
				}
				this.ruleCheckResult = null;
				this.removeListener();
			}
			
			/**
			 *建筑相关功能操作
			 */ 
			private function onFunctionOperate(event:MouseEvent):void{
				switch(Button(event.target).id){
					case "upgradeBtn":
						if (this.upgradeBtnEnable) {
							//相关判断逻辑已经在基类实现
							this.buildingObj.upgradeBulidding();
							this.upgradeBtnEnable = false;
						}
						break;
					case "speedBtn":
						if (this.btnSpeedupEnable) {
							this.btnSpeedupEnable = false;
							this.buildingObj.speedUp();
						}
						break;
					case "cancelBtn":
						this.buildingObj.cancelBuilding();
						break;
					case "destructBtn":
						if(this.buildingObj.level == 1){
							if(!this.isCandestruct()){
								return;
							}
						}
						
						DismantlePanel.show(this.buildingObj,isCandestruct);
						break;
				}
			}			
			
			/**判断是否可以拆到0级*/
			private function isCandestruct():Boolean{
				//如果是学院、研究所
				if(this.buildingObj.typeId == BuildingConstant.TYPE_ACADEMY_BUILDING 
				|| this.buildingObj.typeId == BuildingConstant.TYPE_MILITARY_INSTITUTE){
					var objAry:ArrayCollection = GameContext.instance.getPlayerObj().techManager.techObjArray;

					for each(var obj:BaseTechObj in objAry){
						if(obj.startResearching == true && obj.cityId == this.buildingObj.castle.cityId && obj.techKind == this.buildingObj.typeId){
							MyAlert.show(MultiLang.msg('tech.destruct.tip'));
							return false;
							break;
						}
					}
				}

				//如果是兵营、马厩、作坊
				if(this.buildingObj.typeId == BuildingConstant.TYPE_BARRACKS 
				|| this.buildingObj.typeId == BuildingConstant.TYPE_STABLES 
				|| this.buildingObj.typeId == BuildingConstant.TYPE_WORKSHOPS){
					return this.buildingObj.isCanDestroy(this.buildingObj.typeId,this.buildingObj.castle.produceQueueManager.getProducesAry(this.buildingObj.position));
				}
				
				//如果是市场
				if(this.buildingObj.typeId == BuildingConstant.TYPE_MARKET_BUILDING){
					var tm:TradeManager = this.buildingObj.castle.tradeManager;
					return (this.buildingObj.isCanDestroy(this.buildingObj.typeId,tm.tradeList) 
					|| this.buildingObj.isCanDestroy(this.buildingObj.typeId,tm.transingList) 
					|| this.buildingObj.isCanDestroy(this.buildingObj.typeId,tm.transportList));
				}

				//如果是英雄馆
				if(this.buildingObj.typeId == BuildingConstant.TYPE_AMPHITHEATRE){
					return this.buildingObj.isCanDestroy(this.buildingObj.typeId,this.buildingObj.castle.heroManager.heroArray)
				}
								
				//如果是驿站
				if(this.buildingObj.typeId == BuildingConstant.TYPE_MARKET_BUILDING){
					var dakAry:ArrayCollection = GameContext.instance.getPlayerObj().dakManager.dakList;
					if(dakAry.length>0){
						for(var i:int = 0;i<dakAry.length;i++){
							var b:PostTransportBean = dakAry.getItemAt(i) as PostTransportBean;
							if(b.startCastleId == this.buildingObj.castle.cityId || b.targetCastleId == this.buildingObj.castle.cityId){
								MyAlert.show(MultiLang.msg('dak.supplyLine.isExist'));
								return false;
								break;
							}
						}
					}
				}

				//如果是训练场地
				if(this.buildingObj.typeId == BuildingConstant.TYPE_TRAINNINGS){
					var injuredTroopAry:ArrayCollection  = this.buildingObj.castle.injuredTroopManager.injuredTroopArray;
					if(injuredTroopAry.length>0){
						for(var t:int =0;t<injuredTroopAry.length;t++){
							var data:BruiseTroopData = injuredTroopAry.getItemAt(t) as BruiseTroopData;
							if(data.value>0){
								MyAlert.show(MultiLang.msg('hospital.injuredTroop.isExist'));
								return false;
								break;
							}
						}
					}
				}
				
				return true;
			}
			
			/**
			 * 关闭窗口
			 */ 
			private function onCloseWin():void{
				EvtDispacther.instance.eventDispatch(WindowSwitchEvent.WINDOW_CLOSE_ID);
			}
			
			private function onMouseOverBtnUpgrand(event:MouseEvent):void {
				if(this.buildingObj.status==BuildingConstant.STATUS_ORDINARY||this.buildingObj.status==BuildingConstant.STATUS_ORDINARY){
					if (this.ruleCheckResult!=null&&this.buildingObj.level<BuildingConstant.HIGHEST_LEVEL) {
						this.conditionTooptip.setBuildingObj(this.buildingObj);
						this.conditionTooptip.setRuleCheckResult(this.ruleCheckResult);
						this.conditionTooptip.onMouseOver(event);
					}
				}
				if(this.buildingObj.status==BuildingConstant.STATUS_DESTRUCT_ING){
					if (this.ruleCheckResultForDegrade!=null) {
						this.conditionTooptip.setBuildingObj(this.buildingObj);
						this.conditionTooptip.setDegradeRuleCheckResult(this.ruleCheckResultForDegrade);
						this.conditionTooptip.onMouseOver(event);
					}
				}
				
			}
			
			/**获得降级的规则*/
			private function onMouseOverBtnDegrand(event:MouseEvent):void {
				if (this.ruleCheckResultForDegrade!=null) {
					this.conditionTooptip.setBuildingObj(this.buildingObj);
					this.conditionTooptip.setDegradeRuleCheckResult(this.ruleCheckResultForDegrade);
					this.conditionTooptip.onMouseOver(event);
				}
			}

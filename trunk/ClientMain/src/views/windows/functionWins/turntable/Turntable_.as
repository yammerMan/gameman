// ActionScript file
		import flash.display.MovieClip;
		import flash.events.Event;
		import flash.events.KeyboardEvent;
		import flash.events.MouseEvent;
		import flash.events.TimerEvent;
		import flash.net.SharedObject;
		import flash.ui.Keyboard;
		import flash.utils.Dictionary;
		import flash.utils.Timer;
		
		import gs.TweenLite;
		import gs.easing.Back;
		
		import mx.collections.ArrayCollection;
		import mx.logging.ILogger;
		import mx.logging.Log;
		
		import roma.common.action.ControllerFactory;
		import roma.common.constants.ItemConstant;
		import roma.common.controller.shop.UseRoletteResponse;
		import roma.common.valueObject.MaterialBean;
		import roma.common.valueObject.PlayerInfoDataBean;
		import roma.common.valueObject.RoletteAppearItemBean;
		import roma.common.valueObject.RoletteResultBean;
		import roma.logic.CaesaryConfig;
		import roma.logic.GameContext;
		import roma.logic.rule.GameRuleHelper;
		import roma.logic.rule.ItemRule;
		import roma.message.EvtDispacther;
		import roma.util.JavaScriptHelper;
		import roma.util.MultiLang;
		
		import views.PopupWindows;
		import views.mainFrame.ChatPanel;
		import views.spreadUI.MyAlert;
		import views.spreadUI.SecondSubmitWin;
		import views.spreadUI.tips.SpeedUpItemTooltip;
		import views.windows.functionWins.shop.ShopHelper;
		import views.windows.functionWins.turntable.RaffleUtil;
		import views.windows.functionWins.turntable.TurnTableItemUI;
		import views.windows.functionWins.turntable.Turntable;
		import views.windows.functionWins.turntable.TurntableButton;
		
		private static var instance:Turntable;
		private static var log:ILogger = Log.getLogger("views.windows.functionWins.turntable.Turntable_");
		
		public static const BACKGROUND_SHELTER_SHOW:String ="轮盘背景遮挡显示";
		public static const BACKGROUND_SHELTER_HIDE:String ="轮盘背景遮挡隐藏";
		
		public static var NUM_COOKIE:String ="num_cookie";
		private static var TURN_NUM:int =8;
		private static var INTER_DELAY:int =30;
		private static var MIN_DELAY:int =20;
		private static var MAX_DELAY:int = 260;
		
		
		private var secondItemAry:Array = new Array();
		private var thirdItemAry:Array = new Array();
		private var allItemAry:Array = new Array();
		
		private var timer:Timer = new Timer(MAX_DELAY);
		private var intervalTimer:Timer = new Timer(1000);
		private var intervalRoleTimer:Timer = new Timer(1500,1);
		
		private var itemMap:Dictionary = new Dictionary();
			
		private var timerCount:int;
		private var timerTotalCount:int;
		private var turnCount:int;
		private var intervalCount:int;
		
		private var turnedNum:int;
		
		private var selectedItemIndex:int;
		private var selectedItem:RoletteAppearItemBean;	
		
		[Bindable]
		private var turnMaxNum:int; 
		
		[Bindable]
		private var player:PlayerInfoDataBean;
		
		[Bindable]
		private var itemBean:MaterialBean;
		
		[Bindable]
		private var startbtnVisible:Boolean;
		[Bindable]
		private var startEnabled:Boolean;	
		
		[Bindable]
		private var stopbtnVisible:Boolean;
		[Bindable]
		private var stopbtnEnabled:Boolean;
		[Bindable]
		private var itemRule:ItemRule;
		[Bindable]
		private var itemNum:String;
		[Bindable]	
		private var isShow:Boolean;
		
		private var isFirst:Boolean;
		private var isOpen:Boolean;

		private var isStop:Boolean = true;
		private var itemMc:MovieClip; 
		
		private var selectedItemUI:TurnTableItemUI;
		
		public static function getInstance():Turntable{
			if(instance==null) instance = new Turntable();

			return instance;
		}
		
		private function init():void{
			this.addItemMC();
			
			this.timer.addEventListener(TimerEvent.TIMER,timerHandler);
			this.intervalTimer.addEventListener(TimerEvent.TIMER,intervalTimerHandler);
			this.intervalRoleTimer.addEventListener(TimerEvent.TIMER_COMPLETE,onIntervalRoleHandler);
			this.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
			
			this.player = GameContext.instance.getPlayerObj().getPlayerInfo();
			this.itemBean = GameContext.instance.getPlayerObj().itemManager.getMaterialBeanById(ItemConstant.ROLETTE_ITEM);

			this.addItem();
			this.turnMaxNum = this.getMaxNum()>0?this.getMaxNum():1;
		
			//第一次打开
			this.isFirst = true;
			
			this.startbtnVisible = true;
			this.startEnabled = true;
			this.addEventListener(KeyboardEvent.KEY_DOWN,keyHandler);

			instance = this;
		}
		
		private function addItemMC():void{
			[Embed(source="fla/itemResource.swf",symbol="itemMc")]	
			var imgSrc:Class;
			itemMc = new imgSrc() as MovieClip; 
			itemMc.gotoAndStop(1);
			this.imgComponent.addChild(itemMc);
		}
		
		
		private function addListener():void{
			if(!this.hasEventListener(Event.ENTER_FRAME)){
				this.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
			}
		}
		
		private function enterFrameHandler(event:Event):void{
			for(var i:int = 0;i<this.allItemAry.length;i++){
				if(this.timer.running){
					var ui:TurnTableItemUI = this.allItemAry[i] as TurnTableItemUI;
					ui.circleAniEndStop();
				}		
			}
		}
		
		private function intervalTimerHandler(event:TimerEvent):void{
			this.intervalCount++;
			this.timerCount = 0;
			
			if(this.intervalCount>=3){
				this.intervalRolette();
				this.stopIntervalTimer();
				this.addListener();
			}
		}
		
		/**
		 *定时器侦听器函数，循环转动物品 
		 * @param event
		 * 
		 */	
		private function timerHandler(event:TimerEvent):void{
			if(this.timerCount > this.allItemAry.length-1)
				this.timerCount =0;
			
			var ui:TurnTableItemUI = this.itemMap["item"+this.timerCount] as TurnTableItemUI;
			ui.circleAniPlay();
			
			this.itemRule = ui.roletteItemRule;
			this.itemNum = ui.getItemNum();
						
			var itemRule:ItemRule = GameRuleHelper.instance.getItemRuleById(ui.bean.itemId);
			
 			if(ui.bean !=null){
				this.itemMc.gotoAndStop(ui.bean.itemId);
			}else{
				throw new Error("转动的物品为null");		
			}
 		
			if(this.timerTotalCount<TURN_NUM){
				this.timer.delay-=INTER_DELAY;
			}else{
				if(this.timerTotalCount>this.turnedNum){
					if(this.timer.delay < MAX_DELAY){
						this.timer.delay+=INTER_DELAY;
						
						if(ui.bean.itemId == this.selectedItem.itemId && ui.bean.count == this.selectedItem.count && timerTotalCount == (turnedNum+TURN_NUM)){
							this.selectedItemUI = ui;
							this.endTurning();
							this.isFirst = false;
							
							//转到的物品播放动画
							ui.circleAniPlay();
							
							//转到的物品显示在聊天框
							ChatPanel.instance.addOwnRaffleAnnounce(RaffleUtil.ownRaffleDesc(selectedItem));
							//启动间隔定时器
							if(this.turnCount>0){
								this.stopbtnEnabled = true;
								this.stopbtnVisible = true;
								this.startbtnVisible = false;
								
								if(!this.intervalTimer.running) this.intervalTimer.start();
							}else{
								this.isStop = true;
								this.input.enabled = true;

								this.addListener();
								this.setBtnProp();
							}
						}
					}
					
				}else{
					this.timer.delay =MIN_DELAY;
				}
			}
			
			this.turnMaxNum = this.getMaxNum()>0?this.getMaxNum():1;
			
			this.timerCount++;
			this.timerTotalCount++;
		}
		
		/**
		 *启动定时器 
		 * 
		 */	
		private function timerRun():void{
			if(!this.timer.running) this.timer.start();
		}

		/**
		 *把物品添加进对应的数组 
		 * 
		 */	
		private function addItem():void{
			this.secondItemAry.push(item5,item10,item15);
			
			this.thirdItemAry.push(item1,item2,item3,item4,
				item6,item7,item8,item9,item11,item12,
				item13,item14,item16,item17,item18,item19);
				
			this.allItemAry.push(item0,item1,item2,item3,item4,item5,
				item6,item7,item8,item9,item10,item11,item12,
				item13,item14,item15,item16,item17,item18,item19);
				
			for(var i:int;i<this.allItemAry.length;i++){
				this.itemMap["item"+i] = this.allItemAry[i];
			}		
		}
		
		private function setSelectedItemIndex():void{
			for(var i:int=0;i<this.allItemAry.length;i++){
				var ui:TurnTableItemUI = this.allItemAry[i];
				if(ui.bean.itemId == this.selectedItem.itemId && ui.bean.count == this.selectedItem.count){
					this.selectedItemIndex = i;
					break;
				}
			}
		}
		
		/**
		 * 更新排列物品
		 * @param firstLevelItemsAry
		 * @param secondLevelItemsAry
		 * @param thirdLevelItemsAry
		 * 
		 */	
		private function updateItem(firstLevelItemsAry:ArrayCollection,
									secondLevelItemsAry:ArrayCollection,
									thirdLevelItemsAry:ArrayCollection):void{

			//一级物品	
			if(firstLevelItemsAry !=null && firstLevelItemsAry.length>0){
				var b:RoletteAppearItemBean = RoletteAppearItemBean(firstLevelItemsAry.getItemAt(0));
				this.item0.bean = b;
			}else{
				throw new Error("服务器更新转盘一级物品数组出错");
			}
			
			//二级物品
			if(secondLevelItemsAry !=null && secondLevelItemsAry.length>0){
				for(var i:int =0;i<this.secondItemAry.length;i++){
					var b1:RoletteAppearItemBean = secondLevelItemsAry.getItemAt(i) as RoletteAppearItemBean;
					if(b1 !=null){
						this.secondItemAry[i].bean = b1;
					}else{
						throw new Error("服务器更新转盘二级物品出错");
					}
				}
			}else{
				throw new Error("服务器更新转盘二级物品数组出错");
			}
		
			//三级物品
			if(thirdLevelItemsAry!=null && thirdLevelItemsAry.length>0){
				for(var t:int =0;t<this.thirdItemAry.length;t++){
					var b2:RoletteAppearItemBean = thirdLevelItemsAry.getItemAt(t) as RoletteAppearItemBean;
					if(b2 !=null){
						this.thirdItemAry[t].bean = b2;
					}else{
						throw new Error("服务器更新转盘三级物品出错");
					}
				}
			}else{
				throw new Error("服务器更新转盘三级物品数组出错");
			}
			
			if(this.turnCount>0) this.turnCount --;
			
			if(!isOpen) this.openItemLid();
			
			this.setSelectedItemIndex();
			this.turnedNum = this.allItemAry.length+this.selectedItemIndex - TURN_NUM;
		}
		
		private function randRange(min:Number, max:Number):Number {
			var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min;
			return randomNum;
		}
		
		private function getMaxNum():int{
			var itemRule:ItemRule = GameRuleHelper.instance.getItemRuleById(ItemConstant.ROLETTE_ITEM);
			var bean:MaterialBean =GameContext.instance.getPlayerObj().itemManager.getMaterialBeanById(ItemConstant.ROLETTE_ITEM);
			if(bean !=null && bean.count>0){
				return bean.count+int(this.player.coin/itemRule.price);
			}else{
				return int(this.player.coin/itemRule.price);
			}
		}
		
		private function getItemNum():int{
			var itemRule:ItemRule = GameRuleHelper.instance.getItemRuleById(ItemConstant.ROLETTE_ITEM);
			var bean:MaterialBean =GameContext.instance.getPlayerObj().itemManager.getMaterialBeanById(ItemConstant.ROLETTE_ITEM);
			if(bean !=null && bean.count >0){
				return bean.count;
			}
			return 0;
		}
		
		/**
		 *更新物品并且转动 
		 */	
		private function useRolette():void{
			this.timerCount = 0;
			this.timerTotalCount = 0;
			
			var onUseRoletteResponse:Function = function(event:UseRoletteResponse):void{
				if(!event.success){
					setBtnProp();
					return;
				}
				var resultBean:RoletteResultBean = event.resultBean;
				if (resultBean !=null){
					selectedItem = resultBean.resultItem;
					updateItem(resultBean.firstLevelItemsArray,resultBean.secondLevelItemsArray,resultBean.thirdLevelItemsArray);

					setProp();				
					timerRun();

					var coinValue:int = getCoinValueFromItemName(selectedItem.itemId, selectedItem.coinValue);
					JavaScriptHelper.instance.trackEvent("gambling",selectedItem.itemId, "L" + selectedItem.level , coinValue);
				}else{
					MyAlert.showError(event); 
					//throw new Error("服务器更新RoletteResultBean为null");
				}
			}
			
			log.debug("turnTable start turning");
			ControllerFactory.getInstance().getShopController().useRolette(onUseRoletteResponse);
		}

		private function getCoinValueFromItemName(str:String, value:int):int {
			var res:int = value;
			if (value==0) {
				var index:int = str.indexOf("gambling.medal.");
				if (index>0) {
					res = int(str.substr(index + 15));
				}
			}
			return res;
		}
		
		private function keyHandler(event:KeyboardEvent):void{
			if(event.keyCode == Keyboard.ENTER){
				if(CaesaryConfig.instance.isClickToTurn){
	 		 		doEnterHandle();
	 		 	}else{
	 		 		SecondSubmitWin.show(MultiLang.msg("turntable.clickToTurnTip"),SecondSubmitWin.IS_FROM_TURNNER,judgeEnterReturn);
	 		 	}
			}
			
			function judgeEnterReturn(_true:Boolean):void{
 		 		if(_true){
 		 			doEnterHandle();
 		 		}
 		 	}
 		 	
 		 	function doEnterHandle():void{
 		 		if(isStop){
					rolette();
				}else{
					if(stopbtnEnabled==true){
						stopRolette();
					}
				}
 		 	}
		}
		
		private function rolette():void{
			this.turnCount = this.input.effectValue>getMaxNum()?getMaxNum():input.effectValue;
			this.intervalRolette();		
		}
		
		//把是否允许点击就 转轮盘写入cookie
		private function clickToTurnHandle():void{
			CaesaryConfig.instance.isClickToTurn=this.isClickToTurnCheckBox.selected;
			ShopHelper.instance.writeLocal();
		}
		
		//先判断是否允许点击就 转轮盘
 		 private function judgeToturn():void{
 		 	if(CaesaryConfig.instance.isClickToTurn){
 		 		startRolette();
 		 	}else{
 		 		SecondSubmitWin.show(MultiLang.msg("turntable.clickToTurnTip"),SecondSubmitWin.IS_FROM_TURNNER,judgeReturn);
 		 	}
 		 	function judgeReturn(_true:Boolean):void{
 		 		if(_true){
 		 			isClickToTurnCheckBox.selected=CaesaryConfig.instance.isClickToTurn;
 		 			startRolette();
 		 		}
 		 	}
 		 }
		
		
		private function startRolette():void{
			if(SpeedUpItemTooltip.instance.isPopUp){
				SpeedUpItemTooltip.instance.onMouseOut();
			}
			if(this.input.effectValue<=0){
				MyAlert.show(MultiLang.msg('public.least.input.one',GameRuleHelper.instance.getItemRuleById(ItemConstant.ROLETTE_ITEM).name));
				return;
			}
			
			if(this.getMaxNum()<=0){
				MyAlert.show(MultiLang.msg('turntable.turn.item.coin.lack'),recharge,MultiLang.msg('systemMsg.getGold'));	
				return;
			}
			
			this.isShow = false;
			
			rolette();
		}
		
		private function recharge(ok:Boolean):void{
			if (ok){
				ClientMain.recharge();
			}
		}
		
		private function intervalRolette():void{
			this.isStop = false;
			if(!isFirst){
				//当不是第一次打开时候要先关闭再隔4秒打开
				setProp();

				if(isOpen) this.closeItemLid();	
				
				//停止当前物品ui播放
				this.selectedItemUI.circleAniNowStop();
				this.intervalRoleTimer.start();
			}else{
				this.useRolette();
			}
			
			TurntableButton.instance.getTurntableMc().gotoAndStop(3);
		}
		
		private function onIntervalRoleHandler(event:Event):void{
			useRolette();
		}
		
		private function stopRolette():void{
			this.isStop = true;
			this.input.enabled = true;

			this.endTurning();
			this.stopIntervalTimer();
			this.addListener();
			this.setBtnProp();
		}
		
		/**
		 *结束轮盘转动 
		 * 
		 */	
		private function endTurning():void{
			this.timerCount =0;
			this.timerTotalCount =0;
			this.timer.delay =MAX_DELAY;
			
			if(this.timer.running) this.timer.stop();
			
			if(this.hasEventListener(Event.ENTER_FRAME)) this.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
			
			for(var i:int =0;i<this.allItemAry.length;i++){
				var ui:TurnTableItemUI = this.allItemAry[i] as TurnTableItemUI;
				ui.circleAniNowStop();
			}

			TurntableButton.instance.getTurntableMc().gotoAndStop(2);
		}
		
		private function stopIntervalTimer():void{
			this.intervalCount = 0;

			if(this.intervalTimer.running) this.intervalTimer.stop();
		}	
		
		private function setBtnProp():void{
			this.stopbtnVisible = false;
			this.stopbtnEnabled = false;
			this.startbtnVisible = true;
			this.startEnabled = true;
			this.isShow = true;
		}
		
		private function setProp():void{
			this.input.enabled = false;
			this.startEnabled = false;
			this.startbtnVisible = false;
			this.stopbtnEnabled = false;
			this.stopbtnVisible = true;	
		}  
		
		private function openItemLid():void{
			this.isOpen = true;
			for(var i:int =0;i<this.allItemAry.length;i++){
				var ui:TurnTableItemUI = this.allItemAry[i];
				ui.openItemLid();
				ui.isOpen = this.isOpen;
			}
		}
		
		private function closeItemLid():void{
			this.isOpen = false;
			for(var i:int =0;i<this.allItemAry.length;i++){
				var ui:TurnTableItemUI = this.allItemAry[i];
				ui.closeItemLid();
				ui.isOpen = this.isOpen;
			}
		}
		
		private function setMin():void{
			TurntableButton.instance.showTurntalbleMc();
			TweenLite.to(this,0.5,{y:610,ease:Back.easeIn,onComplete:onCloseComplete});
		}
		
	  	private function onMouseOver(event:MouseEvent):void {
	  		if(this.itemRule!=null && this.timerTotalCount<=1){
		  		SpeedUpItemTooltip.show(this.itemRule);
				SpeedUpItemTooltip.instance.onMouseOver(event);
	  		}
		}
		
		private function onMouseMove(event:MouseEvent):void{
			SpeedUpItemTooltip.instance.onMouseMove(event);
		}
		
		private function onMouseOut(event:MouseEvent):void{
			SpeedUpItemTooltip.instance.onMouseOut();
		}
		
		public function show(start:Boolean=false):void{
			PopupWindows.closeAll();
			TweenLite.to(this,0.5,{y:(600-this.height)/2,ease:Back.easeOut,onComplete:onOpenComplete});	
		
			if(itemBean==null) itemBean = GameContext.instance.getPlayerObj().itemManager.getMaterialBeanById(ItemConstant.ROLETTE_ITEM);
			
			readLocal();
			
			turnMaxNum = getMaxNum();

			this.input.intValue = this.getItemNum();
			this.isShow = true;
			
			if(start){
				if(isStop) this.startRolette();				
			}			
		}
		
		private function onOpenComplete():void{
			EvtDispacther.instance.dispatchEvent(new Event(BACKGROUND_SHELTER_SHOW));
		}
		
		private function onCloseComplete():void{
			EvtDispacther.instance.dispatchEvent(new Event(BACKGROUND_SHELTER_HIDE));
		}
		
		private function readLocal():void{
			ShopHelper.instance.readLocal();
			this.isClickToTurnCheckBox.selected=CaesaryConfig.instance.isClickToTurn;
		}
		
		
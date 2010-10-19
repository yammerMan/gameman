// ActionScript file
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.controls.Button;
	import mx.controls.TextArea;
	import mx.controls.TextInput;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.utils.StringUtil;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.BuffConstants;
	import roma.common.constants.PlayerConstant;
	import roma.common.controller.CommonResponse;
	import roma.common.valueObject.PlayerInfoDataBean;
	import roma.logic.CaesaryConfig;
	import roma.logic.GameContext;
	import roma.logic.object.buff.BaseBuffObj;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.object.player.ItemResManager;
	import roma.logic.object.player.PlayerObj;
	import roma.logic.rule.ItemRule;
	import roma.util.InputTextHelper;
	import roma.util.MultiLang;
	
	import views.MainContainer;
	import views.PopupWindows;
	import views.mainModules.map.diamond2.DiamondWorldMap2;
	import views.spreadUI.MyAlert;
	import views.spreadUI.playerInfo.PasswordInput;
	import views.spreadUI.speedUp.ItemSelectSpeedUpWin;
	import views.spreadUI.tips.CommonTooltip;
	import views.spreadUI.tips.PlayerStutasTips;
	import views.spreadUI.tips.ToolTipContainer;
	import views.windows.functionWins.task.TaskWin;
	
	public static const WINDOW_SHOW:String = "kinginfowin.show";
	private static var log:ILogger = Log.getLogger("views.windows.functionWins.playInfo.KingInfoWin");
	
	[Bindable]
	private var logoSource:String;
	private var curShowWin:DisplayObject;
	
	[Bindable]
	private var info:PlayerInfoDataBean;
	[Bindable]
	private var playerObj:PlayerObj;
	[Bindable]
	private var herosCount:int;
	[Bindable]
	private var titleName:String;
	private var cityId:int;
	
	[Bindable]
	private var isBuffPeace:Boolean = false;
	[Bindable]
	private var isBuffCoolDown:Boolean = false;
	private var playerStutasTips:PlayerStutasTips = ToolTipContainer.instance.playerStatusTootip;
	
	private var commonTip:CommonTooltip=ToolTipContainer.instance.commonTooltip;
	
	private var tempTimer:Timer=new Timer(500);
	
	/**
	 *每次界面弹出调用，刷新数据
	 */ 
	override public function refresh():void{
		cityId = GameContext.instance.getPlayerObj().getCurCastleObj().cityId;
		playerObj = GameContext.instance.getPlayerObj();
		isBuffPeace = playerObj.buffManager.hasBuff(BuffConstants.PLAYER_PEACE);
		isBuffCoolDown = playerObj.buffManager.hasBuff(BuffConstants.PLAYER_PEACE_COOLDOWN);
		if(this.initialized)
		{
//			this.setWinVisible();
			this.getBeansCount();
			this.initWin();
			if(this.winData != null && winData == TaskWin.MODIFY_PLAYERNAME){
				Button(modifyNameBtn).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			}
		}
	}
	
	/**
	 * 界面隐藏调用，停止当前窗体一切相关动画等
	 */ 
	override public function destroy():void{
	
	}
	
	private function init():void
	{
		info=GameContext.instance.getPlayerObj().getPlayerInfo();
		this.titleName = GameContext.instance.getPlayerObj().getTitleName();
		if(info.logoUrl == null || info.logoUrl == ""){
			this.logoSource =ImgManager.clazz("logo.unKnown.a1");
		}else{
			this.logoSource =ImgManager.clazz(info.logoUrl);
		}
	    var circleMask:Sprite=new Sprite();
		circleMask.graphics.beginFill(0,0);
		circleMask.graphics.drawCircle(38,39,39);
		circleMask.graphics.endFill();
		this.PlayerLogo.addChild(circleMask);
		this.PlayerLogo.mask=circleMask;
	}
	
	private function getBeansCount():void{
		herosCount=0;
		for each(var castleObj:CastleObj in playerObj.castelArray){
			herosCount += castleObj.heroManager.heroArray.length;
		}
	}
	
	//界面复位
	private function initWin():void{
		this.modifyNameBtn.styleName="collectionModifyBtn";
		this.changeMyInfoBtn.styleName="collectionModifyBtn";
		this.changeFlagBtn.styleName="collectionModifyBtn";
		this.flagText.setTextInputEditable(false);
//		this.flagText.alpha=0;
//		this.flagText.editable=false;
		this.flagText.textString=this.info.flag;
//		this.flagText.text=this.info.flag;
		this.playerNameText.setTextInputEditable(false);
		this.playerNameText.textString=this.info.playerName;
		this.playerSign.editable=false;
		this.playerSign.text=this.info.signature;
		if(info.logoUrl == null || info.logoUrl == ""){
			this.logoSource =ImgManager.clazz("logo.unKnown.a1");
		}else{
			this.logoSource =ImgManager.clazz(info.logoUrl);
		}
	}
	
	
	private function onSetPeace():void{
		isBuffPeace = playerObj.buffManager.hasBuff(BuffConstants.PLAYER_PEACE);
		isBuffCoolDown = playerObj.buffManager.hasBuff(BuffConstants.PLAYER_PEACE_COOLDOWN);
		if(isBuffPeace || isBuffCoolDown){
			var buffObj:BaseBuffObj;
			if(isBuffCoolDown){
			}else if(isBuffPeace){
				 buffObj=playerObj.buffManager.getBuffById(BuffConstants.PLAYER_PEACE);
				 MyAlert.show(MultiLang.msg("playInfo.cancelTruce.tip",GameContext.getRemainTimeStr(buffObj.buffBean.endTime)),sureToCancleTruce)
			}
		}else{
//			if (GameContext.instance.getPlayerObj().itemManager.getMaterialBeanById(PlayerConstant.TRUCE_PLAYER_ITEM) != null) {
//				AlertWin.show(Lang.msg("myItems.sureToUseItem{0}",GameRuleHelper.instance.getItemRuleById(PlayerConstant.TRUCE_PLAYER_ITEM).name), sureToUse);
//	  		} else {
//				AlertWin.show(Lang.msg("myItems.buyForUseItem{0}",GameRuleHelper.instance.getItemRuleById(PlayerConstant.TRUCE_PLAYER_ITEM).name), sureToBuy);
//	  		}
			ItemSelectSpeedUpWin.show(ItemResManager.playerChangeStatusItemArrayCollection,openPasswordInputWin,null);	
		}
		
		function openPasswordInputWin(itemrule:ItemRule):void{
			tempTimer.addEventListener(TimerEvent.TIMER,timeToOpen);
			tempTimer.start();
		}
		
		function timeToOpen(event:TimerEvent):void{
			tempTimer.stop();
			tempTimer.removeEventListener(TimerEvent.TIMER,timeToOpen);
			PasswordInput.show(changeStatus);
		}
		
		
		function sureToCancleTruce(isSure:Boolean):void{
  			if(isSure){
  				PasswordInput.show(cancelTruce);
  			}
  		}
  		
  		function sureToUse(isSure:Boolean):void{
  			if(isSure){
  				PasswordInput.show(changeStatus);
  			}
  		}
  		function sureToBuy(isSure:Boolean):void{
			if(isSure){
				if(GameContext.instance.getPlayerObj().itemManager.ifEnoughGold(PlayerConstant.TRUCE_PLAYER_ITEM)){
					PasswordInput.show(changeStatus);
				}else{
					MyAlert.show(MultiLang.msg("public.coin.lack"));
				}
			}
		}
	}
	/**
	 * 修改玩家名字
	 */ 
	private function onModifyName(event:MouseEvent):void{
		if(Button(event.currentTarget).styleName =="collectionModifyBtn"){
			Button(event.currentTarget).styleName = "agreeBtn";
			Button(event.currentTarget).toolTip=MultiLang.msg('favorite.modify.neme');
			playerNameText.setTextInputEditable(true);
		}else if(Button(event.currentTarget).styleName == "agreeBtn"){
			var str:String = StringUtil.trim(playerNameText.getTextInputText()).replace(/\s/g,"");
			if(str.length<1){
				MyAlert.show(MultiLang.msg("playInfo.modifyName.cannotEmpty"));return;
			}
			Button(event.currentTarget).styleName = "collectionModifyBtn";
			Button(event.currentTarget).toolTip=MultiLang.msg('favorite.modify.click');
			playerNameText.setTextInputEditable(false);
			if(str==info.playerName){
				MyAlert.show(MultiLang.msg("systemMsg.haveNotModify"));
			}
			else{
				ItemSelectSpeedUpWin.show(ItemResManager.playerChangeNameItemArrayCollection,reNameReback,null,cancelFunction);
			}
		}
		
		//改名返回
		function cancelFunction():void{
			modifyNameBtn.styleName = "collectionModifyBtn";
			modifyNameBtn.toolTip=MultiLang.msg('favorite.modify.click');
			playerNameText.setTextInputEditable(false);
			playerNameText.textString=info.playerName;
		}
		
		//改名返回
		var nameStr:String = "";
		function reNameReback(itemRule:ItemRule):void{
			nameStr = playerNameText.getTextInputText().replace(/\s/g,"");
			ControllerFactory.getInstance().getPlayerController().modifyPlayerName(str,modifyPlayerName);
			
		}
		
		/**改名响应*/ 
		function modifyPlayerName(event:CommonResponse):void {
			if (event.isSuccess()) {
				info.playerName=nameStr;
				MainContainer.instance.risePlay(MultiLang.msg('playInfo.modifyName.success'));
			} else {
				MyAlert.showError(event);
			}
		}
	}
	
		/**
		 * 修改玩家签名
		 */ 
		
		private function onModifyPlayerIdiograph(event:MouseEvent):void{
			if(Button(event.currentTarget).styleName =="collectionModifyBtn"){
				Button(event.currentTarget).styleName = "agreeBtn";
				Button(event.currentTarget).toolTip=MultiLang.msg('playInfo.modifySignature.tip');
				playerSign.editable = true;
				playerSign.setSelection(0,playerSign.text.length);
				playerSign.setFocus();
			}else if(Button(event.currentTarget).styleName == "agreeBtn"){
				Button(event.currentTarget).styleName = "collectionModifyBtn";
				Button(event.currentTarget).toolTip=MultiLang.msg('favorite.modify.click');
				playerSign.enabled=false;
//				ItemSelectSpeedUpWin.show(ItemManager.playerChangeNameItemArray,reNameReback,null,cancelFunction);
				ControllerFactory.getInstance().getPlayerController().modifyPlayerSignature (playerSign.text,modifyPlayerName);
			}
			//改签名返回
			function cancelFunction():void{
				playerSign.styleName = "collectionModifyBtn";
				playerSign.toolTip=MultiLang.msg('favorite.modify.click');
				playerSign.text=info.signature;
				
			}
			//改签名返回
			function reNameReback(itemRule:ItemRule):void{
				ControllerFactory.getInstance().getPlayerController().modifyPlayerSignature (playerSign.text,modifyPlayerName);
				
			}
			/**改签名响应*/ 
			function modifyPlayerName(event:CommonResponse):void {
				if (event.isSuccess()) {
					info.signature=playerSign.text;
					MainContainer.instance.risePlay(MultiLang.msg('playInfo.modifySignature.success'));
				} else {
					MyAlert.showError(event);
				}
			}
		}
		
		private function onSignTextChage(e:Event):void{
			var c:int = 0;
	 		TextArea(e.currentTarget).maxChars = PlayerConstant.PLAYER_SIGNATURE_MAX_LENGTH;
			for (var i:int=0;i<e.target.text.length;i++){
				var str:String = e.target.text.substr(i,1);
				if(InputTextHelper.isDoubleByte(str)){
					c +=2;
				} else {
					c +=1;
				}
				if (c>PlayerConstant.PLAYER_SIGNATURE_MAX_LENGTH) { 
					this.playerSign.text = this.playerSign.text.substring(0,i);
					break;
				}					
			}
		}
		
		private function textInputChange(e:Event):void{
	 		var c:int = 0;
	 		TextInput(e.currentTarget).maxChars = 20;
			for (var i:int=0;i<e.target.text.length;i++){
				var str:String = e.target.text.substr(i,1);
				if(InputTextHelper.isDoubleByte(str)){
					c +=2;
				} else {
					c +=1;
				}
				if (c>CaesaryConfig.instance.nameLimit) { 
					this.playerNameText.textString = this.playerNameText.getTextInputText().substring(0,i);
					this.playerNameText.setMaxValue(i);
					break;
				}					
			}
		}   
		
		private function flagTextChange(e:Event):void{
	 			var c:int = 0;
	 			this.flagText.setMaxValue(3);
	 			var chineseCount:int=0;
				for(var i:int=0;i<e.target.text.length;i++){
					var str:String = e.target.text.substr(i,1);
					if(InputTextHelper.isDoubleByte(str)){
						c +=2;
						chineseCount++;
					}
					else{
						c +=1;
					}
					if(c >= 3){
						if(chineseCount>1){
							this.flagText.textString = this.flagText.getTextInputText().substring(0,1);
//							this.flagText.setMaxValue(1);
						}else if(chineseCount==1){
							this.flagText.textString = this.flagText.getTextInputText().substring(0,2);
//							this.flagText.setMaxValue(2);
						}else{
							this.flagText.textString = this.flagText.getTextInputText().substring(0,3);
//							this.flagText.setMaxValue(3);
						}
						break;
					}					
				}
			}  
	
	
	//修改状态
	private function changeStatus(param:String):void{
		ControllerFactory.getInstance().getPlayerController().truce(param,onModifyStatus);
		function onModifyStatus(event:CommonResponse):void{
			if(event.isSuccess()){
				MainContainer.instance.risePlay(MultiLang.msg('playInfo.modifyStatu.success'));
				isBuffPeace = playerObj.buffManager.hasBuff(BuffConstants.PLAYER_PEACE);
				isBuffCoolDown = playerObj.buffManager.hasBuff(BuffConstants.PLAYER_PEACE_COOLDOWN);
			}
			else{
				MyAlert.showError(event);
			}
		}
	}
	
	//修改状态
	private function cancelTruce(param:String):void{
		ControllerFactory.getInstance().getPlayerController().cancelTruce("yes",cancelTruceHandle);
		function cancelTruceHandle(event:CommonResponse):void{
			if(event.isSuccess()){
				MainContainer.instance.risePlay(MultiLang.msg('playInfo.modifyStatu.success'));
				isBuffPeace = playerObj.buffManager.hasBuff(BuffConstants.PLAYER_PEACE);
				isBuffCoolDown = playerObj.buffManager.hasBuff(BuffConstants.PLAYER_PEACE_COOLDOWN);
			}
			else{
				MyAlert.showError(event);
			}
		}
	}
	
	private function statusBtnOver(event:MouseEvent):void{
		playerStutasTips.setObj(this.playerObj);
		playerStutasTips.onMouseOver(event);
	}
	
	private function statusBtnOut(event:MouseEvent):void{
		playerStutasTips.onMouseOut();
	}
	
	//修改旗号
	private function onModifyFlag(event:MouseEvent):void{
		if(Button(event.currentTarget).styleName =="collectionModifyBtn"){
			Button(event.currentTarget).styleName = "agreeBtn";
			Button(event.currentTarget).toolTip=MultiLang.msg('favorite.modify.neme');
//			flagText.editable = true;
//			flagText.alpha=1;
//			flagText.setSelection(0,flagText.text.length);
//			flagText.setFocus();
			flagText.setTextInputEditable(true);
		}else if(Button(event.currentTarget).styleName == "agreeBtn"){
			var str:String = StringUtil.trim(playerNameText.getTextInputText());
			if(str.length<1){
				MyAlert.show(MultiLang.msg("playInfo.changeFlag.cannotEmpty"));return;
			}
			Button(event.currentTarget).styleName = "collectionModifyBtn";
			Button(event.currentTarget).toolTip=MultiLang.msg('favorite.modify.click');
//			flagText.alpha=0;
//			flagText.editable=false;
			flagText.setTextInputEditable(false);
			if(flagText.getTextInputText()==info.flag){
				MyAlert.show(MultiLang.msg("systemMsg.haveNotModify"));
			}else{
				ItemSelectSpeedUpWin.show(ItemResManager.playerChangeFlagItemArrayCollection,changeflagReback,null,cancelFunction);
			}
			
		}
		
		//改旗号返回
		function cancelFunction():void{
			changeFlagBtn.styleName = "collectionModifyBtn";
			changeFlagBtn.toolTip=MultiLang.msg('favorite.modify.neme');
			flagText.setTextInputEditable(false);
			flagText.textString=info.flag;
			
		}
		
		//改旗号返回
		function changeflagReback(itemRule:ItemRule):void{
			ControllerFactory.getInstance().getPlayerController().changeFlag(flagText.getTextInputText(),onModifyFlagBack);	
		}
		
		function onModifyFlagBack(event:CommonResponse):void{
			if(event.isSuccess()){
				info.flag=flagText.getTextInputText();
				MainContainer.instance.risePlay(MultiLang.msg('playInfo.modifyFlag.success'));
				//更改旗号刷新
				var idField:int = GameContext.instance.getPlayerObj().getCurCastleObj().idField;
				DiamondWorldMap2.instance.setCenterPoint(idField/10000,idField%10000);
			}
			else{
				MyAlert.showError(event);
			}
		}
	}
	
	private function renascenceHandle():void{
		MyAlert.show(MultiLang.msg("KingInfoWin.implementBtn.tip"),doCheckPassWord);
		function doCheckPassWord(_true:Boolean):void{
			if(_true){
				PasswordInput.show(doImplementBtn)
			}
		}
		function doImplementBtn(param:String):void{
			ControllerFactory.getInstance().getPlayerController().restart(restartReback);
		}
	}
	
	private function restartReback(event:CommonResponse):void{
		if(!event.success){
			MyAlert.showError(event);
		}else{
			PopupWindows.closeAll();
		}
	}
	
	private function implementBtnOnMouseOver(event:MouseEvent):void{
		this.commonTip.onMouseOver(event);
		this.commonTip.setTip(MultiLang.msg("kingInfoWin.renascenceBtn.tip"));
	}
	
	private function implementBtnOnMouseOut():void{
		this.commonTip.onMouseOut();
	}
	
	private function implementBtnOnMouseMove(event:MouseEvent):void{
		this.commonTip.onMouseMove(event);
	}
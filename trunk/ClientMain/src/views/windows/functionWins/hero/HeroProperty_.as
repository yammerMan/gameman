/** as 代码 */
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.BuffConstants;
	import roma.common.constants.BuildingConstant;
	import roma.common.constants.HeroGrowthConstant;
	import roma.common.constants.HeroManConstants;
	import roma.common.controller.CommonResponse;
	import roma.common.valueObject.HeroInfoBean;
	import roma.common.valueObject.HeroTroopBean;
	import roma.common.valueObject.MaterialBean;
	import roma.logic.CaesaryConfig;
	import roma.logic.GameContext;
	import roma.logic.object.buff.BaseBuffObj;
	import roma.logic.object.building.impl.Amphitheater;
	import roma.logic.object.hero.HeroObj;
	import roma.logic.object.player.ItemResManager;
	import roma.logic.rule.ItemRule;
	import roma.message.EvtDispacther;
	import roma.message.events.ChiefChangeEvent;
	import roma.resource.ImgManager;
	import roma.util.InputTextHelper;
	import roma.util.MultiLang;
	
	import views.MainContainer;
	import views.spreadUI.MyAlert;
	import views.spreadUI.speedUp.ItemSelectSpeedUpWin;
	import views.windows.buildings.amphitheater.HeroDetail;
	import views.windows.buildings.amphitheater.HeroTemper;
	
	[Bindable]
	private var curHero:HeroObj;
	private var cityId:int;
	
	[Bindable]
	private var remains:int = 0;
	[Bindable]
	private var attackPoint:int = 0;
	[Bindable]
	private var intelligencePoint:int = 0;
	[Bindable]
	private var politicsPoint:int = 0;
	[Bindable]
	private var heroBuffAtt:int =0;
	[Bindable]
	private var heroBuffDef:int =0;
	[Bindable]
	private var heroBuffPol:int =0;
	[Bindable]
	private var canUpgrade:Boolean = false;
	[Bindable]
	private var curHeroStatus:String;
	
	private var luxuryItemId:String;
	private var needluxury:int;
	
	private var imgCls:Class=ImgManager.clazz('background.heroExperienceBarProgress');
	
	
	private var amphitheaterObj:Amphitheater;
	[Bindable]
	private var hasAmphitheater:Boolean;
	
	private var selectItemrule:ItemRule;
	
	[Bindable]
	private var curHeroExp:Number=0;
	
	
	private function init():void{
		EvtDispacther.instance.addEventListener(EvtDispacther.HERO_STATUS_CHANGE,heroStatusChangeHandle);
	}
	
	private function heroStatusChangeHandle(event:Event):void{
		if(this.curHero!=null){
			curHeroStatus = this.curHero.heroStatus;
		}
	}
	
	public function set curHeroObj(heroObj:HeroObj):void{
		this.curHero = heroObj;
		this.cityId = curHero.castleObj.cityId;
		curHeroStatus = heroObj.heroStatus;
		curHeroExp=heroObj.heroExpNeetRate
		reset();
		this.curHero.tempLeadership = this.curHero.leadership;
		this.initModifyBtn();
		
		this.amphitheaterObj = Amphitheater(curHero.castleObj.buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_AMPHITHEATRE));
		hasAmphitheater = amphitheaterObj != null;
	}
	
	//还原为非修改名字显示状态
	private function initModifyBtn():void{
		this.modifyNameBtn.styleName = "collectionModifyBtn";
		this.modifyNameBtn.toolTip=MultiLang.msg('favorite.modify.click');
//		this.heroNameText.alpha=0;
//		this.heroNameText.editable=false;
		this.heroNameText.setTextInputEditable(false);
	}
	
	/**
	 * 英雄加点并保存
	 */ 
	private function save():void{
		if(!curHero.isInCastle){
			MyAlert.show(MultiLang.msg('hero.notInCastle.tips'));
			return;
		}
		this.saveBtn.enabled=false;
		this.resetBtn.enabled = false;
		ControllerFactory.getInstance().getHeroController().addPoints(cityId,curHero.heroInfo.id,(politicsPoint-curHero.heroInfo.manages-curHero.heroInfo.managesAdd),(attackPoint-curHero.heroInfo.powers-curHero.heroInfo.powersAdd),(intelligencePoint-curHero.heroInfo.stratagems-curHero.heroInfo.stratagemsAdd),onAddPointResponse);
		//加点响应
		function onAddPointResponse(event:CommonResponse):void{
			if(event.isSuccess()){
				MainContainer.instance.risePlay(MultiLang.msg("hero.save.success"));
				reset();
			}
			else{
				MyAlert.showError(event);
			}
		}
	}
	
	/**
	 * 英雄洗点
	 */ 
	private function washPoint():void{
		if(!curHero.isInCastle){
			MyAlert.show(MultiLang.msg('hero.notInCastle.tips'));
			return;
		}
		ItemSelectSpeedUpWin.show(new ArrayCollection([HeroManConstants.RESET_HERO_POINT_ITEM]),onWashPoint);
		function onWashPoint(i:ItemRule):void{
			var b:MaterialBean = GameContext.instance.getPlayerObj().itemManager.getMaterialBeanById(HeroManConstants.RESET_HERO_POINT_ITEM);
			if(b != null){
				if(b.count >= Math.ceil(curHero.heroInfo.level/10)){
					MyAlert.show(MultiLang.msg("hero.needItem{0}{1}",i.name,Math.ceil(curHero.heroInfo.level/10)),onWashHero);
					}
				else{
					MyAlert.show(MultiLang.msg("hero.needItem{0}{1}",i.name,Math.ceil(curHero.heroInfo.level/10))+MultiLang.msg('hero.sureToBuy'),sureToBuy);
					}
			}
			else{
				MyAlert.show(MultiLang.msg("hero.needItem{0}{1}",i.name,Math.ceil(curHero.heroInfo.level/10))+MultiLang.msg('hero.sureToBuy'),sureToBuy);
			}
		}
		
		function sureToBuy(isSure:Boolean):void{
			if(isSure){
				if(GameContext.instance.getPlayerObj().itemManager.ifEnoughGold(HeroManConstants.RESET_HERO_POINT_ITEM,Math.ceil(curHero.heroInfo.level/10))){
					ControllerFactory.getInstance().getHeroController().resetHeroPoints(cityId,curHero.heroInfo.id,resetHeroPointsResponse);
				}
				else{
					MyAlert.show(MultiLang.msg('hero.iconNotEnough'));
				}
			}
		}
		function onWashHero(isOk:Boolean):void{
			if(isOk)
			ControllerFactory.getInstance().getHeroController().resetHeroPoints(cityId,curHero.heroInfo.id,resetHeroPointsResponse);
		}
		
		/** 洗点重置响应*/ 
		function resetHeroPointsResponse(event:CommonResponse):void{
			if(event.isSuccess()){
				reset();
			}
			else{
				MyAlert.showError(event);
			}
		}
	}

	/**
	 * 英雄升级
	 */ 
	private function onUpgrade():void{
		if(!curHero.isInCastle){
			MyAlert.show(MultiLang.msg('hero.notInCastle.tips'));
			return;
		}
		ControllerFactory.getInstance().getHeroController().reachLevel(cityId,curHero.heroInfo.id,upgradeResponse);
		 //升级响应
		function upgradeResponse(event:CommonResponse):void{
			if(event.isSuccess()){
				reset();
			}
			else{
//				AlertWin.show(event.errorMsg);
				MyAlert.showError(event);
			}
		}
	}
	
	/**
	 * 解雇英雄
	 */ 
	private function onDismiss():void{
		if(!curHero.isInCastle){
			MyAlert.show(MultiLang.msg('hero.notInCastle.tips'));
			return;
		}
		if(curHero.isChief || curHero.isMoving || curHero.isGuardStatus){
			MyAlert.show(MultiLang.msg('hero.hasTask.warn'));
			return;
		}
		if(curHero.armyManager.troopsArray.length>0){
			var c:int = 0;
			for each(var h:HeroTroopBean in curHero.armyManager.troopsArray){
				c += h.count;
			}
			if(c>0){
				MyAlert.show(MultiLang.msg("hero.kickOut.haveTroopTip"));
				return;
			}
		}
		MyAlert.show(MultiLang.msg('hero.isSureToDismiss.tips'),sureToDis);
		function sureToDis(isTrue:Boolean):void{
			if(isTrue){
				ControllerFactory.getInstance().getHeroController().kickHero(cityId,curHero.heroInfo.id,onDismissResponse);
			}
		
		}
		/**解雇英雄响应*/
		function onDismissResponse(event:CommonResponse):void{
			if(event.isSuccess()){
				curHero.selectedInUi = true;
			} else {
				MyAlert.showError(event);
			}
		}
	}
	
	/**
	 * 释放英雄
	 */ 
	private function onSetFree():void{
		ControllerFactory.getInstance().getHeroController().treatSeizedHero(cityId,curHero.heroInfo.id ,0 , onTreatResponse);
		function onTreatResponse(event:CommonResponse):void {
			if(event.isSuccess()){
				MainContainer.instance.risePlay(MultiLang.msg("hero.releaseSuccess"));
				curHero.selectedInUi = true;
			} else {
				MyAlert.showError(event);
			}
		}
	}
	
	/**
	 * 劝降英雄
	 */ 
	private function onPersuade():void{
		//官职是否足够
		var tId:int = GameContext.instance.getPlayerObj().getPlayerInfo().title;
		var titleStr:String = MultiLang.getPlayerTitle(tId);
		if(curHero.heroInfo.level>(tId+1)*10&&tId<10){
			MyAlert.show(MultiLang.msg('hero.cannotPersuade.tips',titleStr,(tId+1)*10));
			return;
		}
		HeroDetail.show(curHero.heroInfo,persuadeBack,false);
	}
	
	private function persuadeBack(h:HeroInfoBean):void{
		ControllerFactory.getInstance().getHeroController().persuadeHero(cityId,h.id,onPersuadeResponse);
		function onPersuadeResponse(event:CommonResponse):void{
			if(event.isSuccess()){
				MainContainer.instance.risePlay(MultiLang.msg("persuade.success"));
			}
			else{
				MyAlert.showError(event);
			}
		}
	}
	
	/**
	 * 重置显示
	 */ 
	private function reset():void{
 		if(curHero != null){
			attackPoint = curHero.heroInfo.powers+curHero.heroInfo.powersAdd;
			politicsPoint = curHero.heroInfo.manages+curHero.heroInfo.managesAdd;
			intelligencePoint = curHero.heroInfo.stratagems+curHero.heroInfo.stratagemsAdd;
			remains = curHero.heroInfo.remains;
//			canUpgrade = curHero.heroInfo.experience > Math.pow(curHero.heroInfo.level,2)*100?true:false;
			heroBuffAtt = curHero.powersBuffAdd;
			heroBuffPol = curHero.politicsBuffAdd;
			heroBuffDef = curHero.defendBuffAdd;
		}
	} 
	/**
	 *  英雄加经验
	 */ 
	private function addExp(event:MouseEvent):void{
		if(!curHero.isInCastle){
			MyAlert.show(MultiLang.msg('hero.notInCastle.tips'));
			return;
		}
		selectItemrule=null;
		ItemSelectSpeedUpWin.show(ItemResManager.heroExpItemArrayCollection,onAddExp);
		function onAddExp(iRule:ItemRule):void{
			selectItemrule=iRule;
			ControllerFactory.getInstance().getHeroController().awardItem(cityId,curHero.heroInfo.id,iRule.itemId,onUseItemResponseHandle);
			/**使用物品响应 */ 
		} 					
		function onUseItemResponseHandle(event:CommonResponse):void{
			if(event.isSuccess()){
				
				if(selectItemrule.itemId=="incHeroExp1k"){
					MainContainer.instance.risePlay(MultiLang.msg("hero.addExperienceTip",Math.max(int(Math.pow(curHero.heroInfo.level,2)*100*curHero.heroExpNeetRate*8/100),1000)));
				}
				if(selectItemrule.itemId=="incHeroExp10k"){
					MainContainer.instance.risePlay(MultiLang.msg("hero.addExperienceTip",Math.max(int(Math.pow(curHero.heroInfo.level,2)*100*curHero.heroExpNeetRate*30/100),10000)));
				}
				if(selectItemrule.itemId=="incHeroExp100k"){
					MainContainer.instance.risePlay(MultiLang.msg("hero.addExperienceTip",Math.max(int(Math.pow(curHero.heroInfo.level,2)*100*curHero.heroExpNeetRate),100000)));
				}
				reset();
			}
			else{
				MyAlert.showError(event);
			}
		}
	}

	/**
	 * 子界面调回函数
	 */ 
	public function subCall(param:String):void{
		if(param == HeroTroops.AWARD_Hero_SUCCESS){
			reset();
		}
	}
	/**
	 * 增加点数
	 */ 
	private function addHeroPoint(type:String,point:int):void{
		this.saveBtn.enabled=true;
		this.resetBtn.enabled = true;
		if(this.remains<=0){
			return;
		}
		switch(type){
			case "addAtt":
				this.attackPoint +=point;
				if(this.attackPoint >(this.intelligencePoint+this.politicsPoint)){
					this.attackPoint -=point;
					MyAlert.show(MultiLang.msg('hero.addPoint.limitWarn'));
					return;
				}
				if(curHero.powersBuffAdd>0) {
					heroBuffAtt = Math.round(attackPoint*HeroManConstants.BUFF_ADD_PERCENT*.01);
				}
				break;
			case "addInt":
				this.intelligencePoint +=point;
				if(this.intelligencePoint >(this.attackPoint+this.politicsPoint)){
					this.intelligencePoint -=point;
					MyAlert.show(MultiLang.msg('hero.addPoint.limitWarn'));
					return;
				}
				if(curHero.defendBuffAdd>0) {
					heroBuffDef = Math.round(intelligencePoint*HeroManConstants.BUFF_ADD_PERCENT*.01);
				}
				break;
			case "addPol":
				this.politicsPoint +=point;
				if (this.politicsPoint >(this.attackPoint+this.intelligencePoint)){
					this.politicsPoint -=point;
					MyAlert.show(MultiLang.msg('hero.addPoint.limitWarn'));
					return;
				}
				if (curHero.politicsBuffAdd>0) {
					heroBuffPol = Math.round(politicsPoint*HeroManConstants.BUFF_ADD_PERCENT*.01);
				}
				this.curHero.tempLeadership = this.curHero.calcLeadership(this.politicsPoint + this.heroBuffPol);
				break;
		}
		this.remains -=point;
	}
	
	/**
	 * 增加英雄体力值
	 */ 
	private function addPhisical():void{
		if(!curHero.isInCastle){
			MyAlert.show(MultiLang.msg('hero.notInCastle.tips'));
			return;
		}
		if(curHero.heroInfo.strengthPoint>=curHero.heroInfo.level+HeroManConstants.STRENGTH_POINT_FOR_LEVEL_ONE_HERO){
			MyAlert.show(MultiLang.msg('donotNeet.addPhisical.tips'));
			return;
		}
		ItemSelectSpeedUpWin.show(ItemResManager.phisicalItemArrayCollection,onPhisicalSelect);
		function onPhisicalSelect(i:ItemRule):void{
			ControllerFactory.getInstance().getHeroController().awardItem(cityId,curHero.heroInfo.id,i.itemId,onPhisicalItemUse);
		}
		function onPhisicalItemUse(event:CommonResponse):void{
			if(event.isSuccess()){
				MainContainer.instance.risePlay(MultiLang.msg("hero.useItem.success"));
			}else{MyAlert.showError(event)}
		}
	}
	
	/**
	 * 赏赐英雄忠诚度（黄金和珠宝）
	 */ 
	private function getAwardLoyalty():void{
		if(!curHero.isInCastle){
			MyAlert.show(MultiLang.msg('hero.notInCastle.tips'));
			return;
		}
		var s:String = coolDownTime(); 
		if(s!=""){
			MyAlert.show(MultiLang.msg('hero.inCoolDownTime{0}',s));
			return;
		}
		ItemSelectSpeedUpWin.instance.speedUpType = ItemSelectSpeedUpWin.GOLD_AWARD_HERO;
		ItemSelectSpeedUpWin.show(ItemResManager.jewelryItemArrayCollection,onAwardJewelry);
		ItemSelectSpeedUpWin.instance.goldsUi.curHero = curHero;
	}
	
	private function onAwardJewelry(iRule:ItemRule):void{
		if(iRule == null){
			ControllerFactory.getInstance().getHeroController().awardMoney(cityId,curHero.heroInfo.id,onAwardGoldResponse);
		}else{
			ControllerFactory.getInstance().getHeroController().awardItem(cityId,curHero.heroInfo.id,iRule.itemId,onAwardJewelryResponse);}		
		function onAwardGoldResponse(event:CommonResponse):void{
			if(!event.isSuccess()){
				MyAlert.showError(event);
			}else{
				MainContainer.instance.risePlay(MultiLang.msg("hero.awardSuccess"));
			}
		}
		function onAwardJewelryResponse(event:CommonResponse):void{
			if(!event.isSuccess()){
				MyAlert.showError(event);
			}else{
				MainContainer.instance.risePlay(MultiLang.msg("hero.awardSuccess"));
			}
		}
	}
	
	/**
	 * 城守任命及解除
	 */ 
	private function onChief():void{
		if(!curHero.isInCastle){
			MyAlert.show(MultiLang.msg('hero.notInCastle.tips'));
			return;
		}
		if(chiefBtn.label == MultiLang.msg('hero.promoteChief')){
			ControllerFactory.getInstance().getHeroController().setToChief(cityId,curHero.heroInfo.id,onPromoteToChiefResponse);
		}else if(chiefBtn.label == MultiLang.msg('hero.removeChief')){
			ControllerFactory.getInstance().getHeroController().dischargeLeader(cityId,onDischangeChief);
		}
		/** 解除城守响应 */ 
		function onDischangeChief(event:CommonResponse):void{
			if(event.isSuccess()){
				MainContainer.instance.risePlay(MultiLang.msg("hero.dischargeChiefSuccess"));
				curHeroStatus = curHero.heroStatus;
				EvtDispacther.instance.dispatchEvent(new ChiefChangeEvent(ChiefChangeEvent.CHIEF_CHANGE,curHero));
			}else{
				MyAlert.showError(event);
			}
		}
		/**更改城守相应*/ 
		function onPromoteToChiefResponse(event:CommonResponse):void{
			if(event.isSuccess()){
				MainContainer.instance.risePlay(MultiLang.msg("hero.promoteToChiefSuccess"));
				curHeroStatus = curHero.heroStatus;
				EvtDispacther.instance.dispatchEvent(new ChiefChangeEvent(ChiefChangeEvent.CHIEF_CHANGE,curHero));
			}else{MyAlert.showError(event)}
		}
	}
	
	/**
	 * 英雄改名
	 */ 
	
	private function onModifyName(event:MouseEvent):void{
		if(Button(event.currentTarget).styleName =="collectionModifyBtn"){
			Button(event.currentTarget).styleName = "agreeBtn";
			Button(event.currentTarget).toolTip=MultiLang.msg('favorite.modify.neme');
			heroNameText.setTextInputEditable(true);
//			heroNameText.editable = true;
//			heroNameText.alpha=1;
//			heroNameText.setSelection(0,heroNameText.text.length);
//			heroNameText.setFocus();
		}else if(Button(event.currentTarget).styleName == "agreeBtn"){
			Button(event.currentTarget).styleName = "collectionModifyBtn";
			Button(event.currentTarget).toolTip=MultiLang.msg('favorite.modify.click');
//			heroNameText.alpha=0;
			heroNameText.setTextInputEditable(false);
			ControllerFactory.getInstance().getHeroController().reName(cityId,curHero.heroInfo.id,heroNameText.getTextInputText(),onRenameResponse);
		}
		/**改名响应*/ 
		 function onRenameResponse(event:CommonResponse):void{
			if(event.isSuccess()){
				MainContainer.instance.risePlay(MultiLang.msg("hero.changeSuccess"));
				heroNameText.textString=curHero.heroInfo.name;
				heroNameText.setTextInputEditable(false);
			}
			else{
				MyAlert.showError(event);
			}
		}
	}
	
   private function textInputChange(event:Event):void{
 		var c:int = 0;
		for (var i:int=0;i<event.target.text.length;i++){
			var str:String = event.target.text.substr(i,1);
			if(InputTextHelper.isDoubleByte(str)){
				c +=2;
			} else {
				c +=1;
			}
			if (c>CaesaryConfig.instance.nameLimit) {  						
				this.heroNameText.textString = this.heroNameText.getTextInputText().substring(0,i);
				this.heroNameText.setMaxValue(i);
				break;
			}					
		}
	} 
	
	private function coolDownTime():String{
		var str:String = "";
		var bo:BaseBuffObj = this.curHero.buffManager.getBuffById(BuffConstants.HERO_AWARD_COOL_DOWN); 
		if (bo!=null) {
			var now:Number = new Date().valueOf();
			var diff:Number = GameContext.instance.getTimeDis();
			var remainT:Number = (bo.buffBean.endTime + diff - now)/1000 ;
			str = MultiLang.timeFormatToString(remainT);
		}
		return str;
	}  
	
	private function onHeroExercise(t:int):void{
		if(curHero.isInCastle || curHero.heroInfo.status == HeroManConstants.STATUS_GROWTH){
			if(t == HeroManConstants.STATUS_GROWTH){
				ItemSelectSpeedUpWin.show(new ArrayCollection([HeroGrowthConstant.ADD_HERO_GROWTH_LIMIT_ITEM]),onSelectFun);
			}else{
				// 历练 
				if(!amphitheaterObj.checkUseItem() && amphitheaterObj.getBeanTemperList()>=HeroGrowthConstant.GROWING_HERO_COUNT_LIMIT){
					ItemSelectSpeedUpWin.show(new ArrayCollection([ItemResManager.heroTemperAddLimit]),null,null,null,onUseItemToGrowth);
				}else if(amphitheaterObj.checkUseItem() && amphitheaterObj.getBeanTemperList()>=HeroGrowthConstant.GROWING_HERO_COUNT_LIMIT_AFTER_ITEM_USED){
					MyAlert.show(MultiLang.msg('hero.temper.isFull'));
				}else{
					HeroTemper.show(curHero,onExerciseCallBack);
				}
			}
		}
		else{
			MyAlert.show(MultiLang.msg('hero.notInCastle.tips'));
			return;
		}

		function onSelectFun(i:ItemRule):void{
			ControllerFactory.getInstance().getHeroController().speedUpHeroGrowth(curHero.castleObj.cityId,curHero.heroInfo.id,onSpeedUpGrowth);
		}
		function onSpeedUpGrowth(event:CommonResponse):void{
			if(event.isSuccess()){
					MainContainer.instance.risePlay(MultiLang.msg("market.speedUpSuccess"));
				}else{
					MyAlert.showError(event);
			}
		}
	}
	
	private function onUseItemToGrowth():void{
		HeroTemper.show(data,onExerciseCallBack);
	}
	
	private function onExerciseCallBack():void{
		this.curHeroStatus = curHero.heroStatus;
	}
	
	

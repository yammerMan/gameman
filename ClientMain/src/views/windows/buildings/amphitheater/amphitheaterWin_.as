	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.events.ItemClickEvent;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.BuffConstants;
	import roma.common.constants.HeroGrowthConstant;
	import roma.common.constants.HeroManConstants;
	import roma.common.controller.CommonResponse;
	import roma.common.controller.hero.TavernHeroList;
	import roma.common.controller.shop.UseMaterialResultResponse;
	import roma.common.valueObject.HeroInfoBean;
	import roma.logic.GameContext;
	import roma.logic.object.buff.BaseBuffObj;
	import roma.logic.object.building.impl.Amphitheater;
	import roma.logic.object.hero.HeroObj;
	import roma.logic.object.player.ItemResManager;
	import roma.logic.rule.ItemRule;
	import roma.message.EvtDispacther;
	import roma.util.MultiLang;
	
	import views.MainContainer;
	import views.PopupWindows;
	import views.spreadUI.MyAlert;
	import views.spreadUI.speedUp.ItemSelectSpeedUpWin;
	import views.windows.buildings.amphitheater.HeroDetail;
	import views.windows.buildings.amphitheater.HeroTemper;
	import views.windows.functionWins.hero.HerosMansionWin;
	
	public static const WINDOW_SHOW:String = "Amphitheater.show";

	[Bindable]
	private var buttonTitle:Array=new Array(MultiLang.msg('hero.heroList'),MultiLang.msg('hero.exerciseManage'),MultiLang.msg('upgradingWin.upgradeRequest'));
	
	[Bindable]
	private var heroList:ArrayCollection = new ArrayCollection();
	[Bindable]
	private var heroTemperList:ArrayCollection = new ArrayCollection();
	
	private var curHero:HeroInfoBean;
	private var cityId:int = GameContext.instance.getPlayerObj().getCurCastleObj().cityId;
	
	[Bindable]
	private var processTime:Number;		
	
	[Bindable]
	private var trainLimit:int;
	[Bindable]
	private var isEffect:Boolean=false;
	
	private var isUseItemAndRefresh:Boolean=false;
	
	[Bindable]
	private var refreshTimeLeft:Number = 0;

	/**
	 *每次界面弹出调用，刷新数据
	 */ 
	override public function refresh():void{
		cityId = GameContext.instance.getPlayerObj().getCurCastleObj().cityId;
		isUseItemAndRefresh=false;
		if (this.initialized){
			if(this.winData.data != null && this.winData.data == "heroTrain"){
				this.buttonBar.selectedIndex=1;
				this.myViewstack.selectedIndex=1;
				this.winData.data = null;
			}
			else{
				this.refreshHero();
				this.buttonBar.selectedIndex=0;
				this.myViewstack.selectedIndex=0;
			}
		}
		heroTemperList = GameContext.instance.getPlayerObj().getCurCastleObj().heroManager.heroArray;
	}
	
	private function refreshHero():void{
		if (this.buildingObj.level>0 && this.buildingObj != null) {
			ControllerFactory.getInstance().getHeroController().getTavernHerosList(cityId,onTavernHerosList,false);
		}	
	}
	
	/**
	 * 界面隐藏调用，停止当前窗体一切相关动画等
	 */ 
	override public function destroy():void{
		
	}
	
	override public function update():void{
		if(this.buildingObj.level<1){
			this.buttonBar.selectedIndex = this.buttonTitle.length-1;
			this.myViewstack.selectedChild = this.upgradingWin;
			this.buttonBar.enabled = false;
		}else{
			if(!this.buttonBar.enabled){
				this.buttonBar.enabled = true;
			}
		}
	}

	/**
	 * 获得酒馆中英雄列表的响应
	 */ 
	private function onTavernHerosList(event:TavernHeroList):void{
		if(event.isSuccess()){
			heroList = event.tavernHerosArray;
			refreshTimeLeft = event.remainTime;
			if(isUseItemAndRefresh){
				MainContainer.instance.risePlay(MultiLang.msg("amphitheatre.refreshHeroSuccess"));
				isUseItemAndRefresh=false;	
			}
		}else{
			MyAlert.showError(event);
		}
	}
	
	/**
	 * 刷新英雄列表的响应
	 */ 
	private function onRefreshHeroList(event:TavernHeroList):void{
		if(event.isSuccess()){
			heroList = event.tavernHerosArray;
		}else{
			MyAlert.showError(event);
		}
	}
	
	private function init():void{
		this.buttonBar.selectedIndex=0;
		this.myViewstack.selectedIndex=0;
		EvtDispacther.instance.addEventListener(EvtDispacther.PLAYER_BUFF_CHANGE,calcTrainProcessLeftTime);
	}
	
	private function temperReset():void{
		heroTemperList = GameContext.instance.getPlayerObj().getCurCastleObj().heroManager.heroArray;
		calcTrainProcessLeftTime();   
	}
	
	private function calcTrainProcessLeftTime(event:Event = null):void{
		if(this.initialized){
			var buffObj:BaseBuffObj = GameContext.instance.getPlayerObj().buffManager.getBuffById(BuffConstants.PLAYER_INC_GROWING_HERO_COUNT);
			if(buffObj !=null){
				this.isEffect=false;
				this.trainLimit=5;
				this.processTime = buffObj.buffBean.endTime;
			}else{
				this.isEffect=true;
				this.trainLimit=2;
				this.processTime=0;
			}				
			
		}
	}		
	
	private function tbClick(event:ItemClickEvent):void{
		switch(event.index){
			case 0:
				myViewstack.selectedIndex = 0;
				this.refresh();
			break;
			case 1:
				myViewstack.selectedIndex = 1;
				temperReset();
			break;
			case 2:
				myViewstack.selectedIndex = 2;
				this.upgradingWin.refresh();
			break;
		}
	}
	
	private function removeHero(listId:int):void{
		heroList.removeItemAt(listId);
		/* for(var i:int=0;i< heroList.length;i++){
			if(HeroInfoBean(heroList[i]).id == listId){
				heroList.removeItemAt(i);
			}
		} */
	}
	
	public function heroShow(data:Object):void{
		HeroDetail.show(HeroInfoBean(data),removeHero);
		HeroDetail.instance.heroIndex = heroListDG.selectedIndex;
		curHero = HeroInfoBean(data);
	}
	
	private function onRefresh():void{
		isUseItemAndRefresh=true;
		ItemSelectSpeedUpWin.show(new ArrayCollection([HeroManConstants.REFRESH_TAVERN_HEROES_ITEM]),null,null,null,refreshHero);
	}
	
	private function gotoHerosMansionWin():void{
		PopupWindows.openFuncWin(HerosMansionWin.WINDOW_SHOW,null,true);
	}
	
	public function checkStatus(t:int):Boolean{
		var isTrue:Boolean = false;
		
		if(t == HeroManConstants.STATUS_GROWTH){
			isTrue = true;
		}
		return isTrue;
	}
	
	/*增加训练排程  */
	private function addTrainProc(event:MouseEvent):void{
		if(event.currentTarget==this.processBtn){
			ItemSelectSpeedUpWin.show(new ArrayCollection([ItemResManager.heroTemperAddLimit]),onUseToAdd);
		}else{
			ItemSelectSpeedUpWin.show(new ArrayCollection([ItemResManager.heroTemperAddLimit]),onUseToContinue);
		}
	}
	
	public function temperOrSpeedUp(data:Object,btnId:int):void{
		if(HeroObj(data).isInCastle || HeroObj(data).heroInfo.status == HeroManConstants.STATUS_GROWTH){
			if(btnId == 0){
				// 历练
				if(!Amphitheater(this.buildingObj).checkUseItem() && Amphitheater(this.buildingObj).getBeanTemperList()>=HeroGrowthConstant.GROWING_HERO_COUNT_LIMIT){
					ItemSelectSpeedUpWin.show(new ArrayCollection([ItemResManager.heroTemperAddLimit]),null,null,null,onUseItemToGrowth);
				}else if(Amphitheater(this.buildingObj).checkUseItem() && Amphitheater(this.buildingObj).getBeanTemperList()>=HeroGrowthConstant.GROWING_HERO_COUNT_LIMIT_AFTER_ITEM_USED){
					MyAlert.show(MultiLang.msg('hero.temper.isFull'));
				} else{
					HeroTemper.show(data,temperReset);
				} 
			}else if(btnId == 1){
				// 加速
				var heroTemp:HeroObj = HeroObj(data);
				ItemSelectSpeedUpWin.show(new ArrayCollection([HeroGrowthConstant.ADD_HERO_GROWTH_LIMIT_ITEM]),onSelectFun);
			}
		}else{
			MyAlert.show(MultiLang.msg('hero.notInCastle.tips'));
			return;
		}
		function onSelectFun(i:ItemRule):void{
			ControllerFactory.getInstance().getHeroController().speedUpHeroGrowth(cityId,heroTemp.heroInfo.id,onSpeedUpGrowth);
		}
	}
	
	/**
	 * 使用了之后并训练
	 */ 
	private function onUseItemToGrowth():void{
		HeroTemper.show(data,temperReset);
	}
	
	private	function onUseToAdd(i:ItemRule):void{
		ControllerFactory.getInstance().getShopController().usePlayerItem(cityId,i.itemId,onUserPlayItem);
	}
	
	private function onUseToContinue(i:ItemRule):void{
		ControllerFactory.getInstance().getShopController().usePlayerItem(cityId,i.itemId,onContinueUseItemResponse);
	}
	
	private function onContinueUseItemResponse(event:UseMaterialResultResponse):void{
		if(event.isSuccess()){
			MainContainer.instance.risePlay(MultiLang.msg("hero.useItem.success"));
		}
		else{MyAlert.showError(event);}
	}
	
	private function onUserPlayItem(e:UseMaterialResultResponse):void{
		if(e.isSuccess()){
			MainContainer.instance.risePlay(MultiLang.msg("hero.useItem.success"));
		}else{MyAlert.showError(e);}
	}
	
	private function onSpeedUpGrowth(event:CommonResponse):void{
		if(event.isSuccess()){MyAlert.show(MultiLang.msg('market.speedUpSuccess'))}
		else{MyAlert.showError(event);}
	}
	
	public function cancelOrShow(data:Object,btnId:int):void{
		if(btnId == 2){
			// 查看
			PopupWindows.openFuncWin(HerosMansionWin.WINDOW_SHOW,data);
		}
		else if(btnId == 3){
			// 取消
			var h:HeroObj = HeroObj(data);
			MyAlert.show(MultiLang.msg('hero.temper.cancel.tips'),onCancelTemper);
		}
		function onCancelTemper(isSure:Boolean):void{
			if(isSure)
			ItemSelectSpeedUpWin.show(new ArrayCollection([HeroGrowthConstant.CALL_BACK_GROWING_HERO_ITEM]),onSelectItem);
		}
		function onSelectItem(i:ItemRule):void{
			ControllerFactory.getInstance().getHeroController().cancelHeroGrowth(cityId,h.heroInfo.id,onCancelHeroGrowth);
			function onCancelHeroGrowth(event:CommonResponse):void{
				if(event.isSuccess()){
					MainContainer.instance.risePlay(MultiLang.msg('hero.temper.callBack.success.tips'));
				}
				else{MyAlert.showError(event);}
			}
		}
	}
	
	private function callTimeLeftBack():void{
		if(this.myViewstack.selectedIndex==0){
			refreshHero();
		}
	}

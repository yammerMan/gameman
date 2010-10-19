/*  外交界面  as代码 */
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.utils.ObjectProxy;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.BuffConstants;
	import roma.common.constants.CityConstant;
	import roma.common.controller.CommonResponse;
	import roma.common.controller.castle.ResourceStaticResponse;
	import roma.common.valueObject.RelatedCastleBean;
	import roma.common.valueObject.RelatedCastleTimeBean;
	import roma.logic.GameContext;
	import roma.logic.object.buff.BaseBuffObj;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.object.player.ConquestObj;
	import roma.logic.rule.ItemRule;
	import roma.message.EvtDispacther;
	import roma.message.events.ConquestEvent;
	import roma.util.MultiLang;
	
	import views.MainContainer;
	import views.mainFrame.ToggleButton;
	import views.mainModules.map.diamond2.DiamondWorldMap2;
	import views.spreadUI.MyAlert;
	import views.spreadUI.speedUp.ItemSelectSpeedUpWin;
	import views.windows.functionWins.diplomacy.VassalMesWin;
	
	public static const WINDOW_SHOW:String = "DiplomacyWin.show";
	private static var log:ILogger = Log.getLogger("views.windows.functionWins.diplomacy.DiplomacyWin");
	
	[Bindable]
	private var tbbLabelArr:ArrayCollection = new ArrayCollection([MultiLang.msg('diplomacy.conquest.leaderCity.label'),MultiLang.msg('diplomacy.conquest.vassal.all.label')]);
	[Bindable]
	private var conquestArr:ArrayCollection = new ArrayCollection();
	[Bindable]
	private var applyAssalArr:ArrayCollection = new ArrayCollection();
	[Bindable]
	private var leaderCityBean:RelatedCastleTimeBean;
	[Bindable]
	private var troopSeizeArr:ArrayCollection = new ArrayCollection();
	
	[Bindable]
	public var checkOutLabel:String = MultiLang.msg('public.label.checkOut');
	
	[Bindable]
	private var curCastleObj:CastleObj = GameContext.instance.getPlayerObj().getCurCastleObj();
	[Bindable]
	private var isConquested:Boolean = false;
	[Bindable]
	private var canIndependenseFight:Boolean = false;
	
	[Bindable]
	private var remainTimeStr:String;

	[Bindable]
	private var isShowTime:Boolean;

	private var buffObj:BaseBuffObj;
	
	private var buffTimer:Timer = new Timer(1000);
	
	[Bindable]
	private var resourceObj:ObjectProxy = new ObjectProxy()
	private var selectConquestObj:ConquestObj = null;
	
	/**
	 *每次界面弹出调用，刷新数据
	 */
	override public function refresh():void{
		curCastleObj = GameContext.instance.getPlayerObj().getCurCastleObj();
		if(this.winData!=null){
			this.curCastleObj = GameContext.instance.getPlayerObj().getCastleObjById(ConquestObj(this.winData.conquectObj).selfCastleId);
			this.tbbClick(1);
		}else{
			this.tbbClick(0);
		}
		if(curCastleObj.conquestManager.hostCastle != null){
			// 此时城市有宗主，即是其他人的附属城
			isConquested = true;
			canIndependenseFight = isConquested && this.buffObj !=null;
			leaderCityBean = curCastleObj.conquestManager.hostCastle;
		}else{
			isConquested = false;
			canIndependenseFight = false;
		}
	}
	
	/**
	 * 界面隐藏调用，停止当前窗体一切相关动画等
	 */
	override public function destroy():void{
		super.destroy();
		acceptVassal.visible = false;
		applyAssalView.visible = false;
		
		this.buffTimer.stop();
		if(this.winData!=null){
			this.winData=null;
		}
	}
	
	private function init():void{
		EvtDispacther.instance.addEventListener(ConquestEvent.APPLY_CONQUEST_UPDATE,onApplyListUpdate);
		EvtDispacther.instance.addEventListener(ConquestEvent.CONQUEST_LIST_UPDATE,onConquestListUpdate);
		EvtDispacther.instance.addEventListener(ConquestEvent.CONQUEST_HOST_UPDATE,onConquestHostUpdate);
		
		this.buffTimer.addEventListener(TimerEvent.TIMER,timerHandler);
	}
		
	/**
	 * 标签选择
	 */ 
	private function tbbClick(index:int):void{
		buttonBar.selectedIndex = index;
		diplomacyVS.selectedIndex = index;
		buffObj = curCastleObj.buffManager.getBuffById(BuffConstants.CASTLE_ANTI_BE_CONQUSET_PERIOD_BUFF);
		
		var c:CastleObj;
		var con:ConquestObj;
		if(index == 0){
			isShowTime = (buffObj != null);
			if(buffObj !=null){
				if(!buffTimer.running)
				buffTimer.start();
			}
			applyAssalArr.removeAll();
			for each(c in GameContext.instance.getPlayerObj().getAllCastle()){
				if(c.conquestManager.applyBeConquestCastleArray.length>0){
					for each(con in c.conquestManager.applyBeConquestCastleArray)
						applyAssalArr.addItem(con);
				}
			} 
			suzerainMesView.refresh(this.curCastleObj);
		}
		else{
			conquestArr = curCastleObj.conquestManager.getCurConquestList(curCastleObj.cityId);
			/*if(conquestArr.length<=0)return;
			 for each(con in conquestArr)
				con.isSelect = false;
			if(this.selectConquestObj == null){
				selectConquestObj = conquestArr[0];
				selectConquestObj.isSelect = true;
			}else
				selectConquestObj.isSelect = true; 
			
			ControllerFactory.getInstance().getCityController().conquestResource(selectConquestObj.selfCastleId,selectConquestObj.relatedCityBean.castle.cityId,onConquestResource);*/
			curCastleObj.buildingManager.getTownHall().getResourceStatics(onConquestResource);
		}
	}
	
	private function timerHandler(evt:TimerEvent):void{
		if(this.buffObj!=null){
			var time:int = this.buffObj.getRemainTimeSec();
			this.remainTimeStr = MultiLang.timeFormatToString(time);
			if(canIndependenseFight != true)canIndependenseFight = true;
			if(time<=0){
				this.isShowTime = false;
				canIndependenseFight = false;
			}
		}else{
			this.buffTimer.stop();
			this.isShowTime = false;		
		}
	}
	
	/**
	 *使用物品独立
	 */  
	private function useIndependenceItem():void{
		ItemSelectSpeedUpWin.show(new ArrayCollection([CityConstant.LIBERATION_CASTLE_ITEM]),onSelectItem);
		function onSelectItem(item:ItemRule):void{
			ControllerFactory.getInstance().getCityController().liberateSelfCastle(curCastleObj.cityId,onLiberateCastle);
		}
		function onLiberateCastle(event:CommonResponse):void{
			if(event.isSuccess()){
				MainContainer.instance.risePlay(MultiLang.msg("hero.useItem.success"));
				refresh();
			}else{
				MyAlert.showError(event);
			}
		}
	}
	
	/**
	 * 独立战争
	 */ 
	private function independenceFight():void{
		if(GameContext.instance.getPlayerObj().getCurCastleObj().troopManager.getVacantTroop()<=0){
			MyAlert.show(MultiLang.msg("diplomacy.don't.independent.battle"));
			return;
		}
		ControllerFactory.getInstance().getCityController().independentWar(curCastleObj.cityId,onIndependentWar);
		function onIndependentWar(event:CommonResponse):void{
			if(event.isSuccess()){
				MyAlert.show(MultiLang.msg('diplomacy.conquest.battle.start.tips'));
				refresh();
			}else{
				MyAlert.showError(event);
			}
		}
	}
	
	/**
	 * 调出申请界面
	 */ 
	public function checkOutApplyAssal(data:Object):void{
		acceptVassal.visible = true;
		acceptVassal.vassalBean = data;
		acceptVassal.callBackFun = acceptSuccess;
		function acceptSuccess(obj:RelatedCastleBean):void{
			for(var i:int=0;i<applyAssalArr.length;i++){
				var a:RelatedCastleTimeBean = ConquestObj(applyAssalArr[i]).relatedCityBean;
				if(a.castle.cityId == obj.cityId){
					applyAssalArr.removeItemAt(i);
				}
			}
		}
	}
	
	/**
	 * 调出确认申请界面
	 */ 
	private function applyAssal():void{
		applyAssalView.visible = true;
		applyAssalView.refresh(curCastleObj);
	}
	
	/**
	 * 申请列表有更新
	 */ 
	private function onApplyListUpdate(event:ConquestEvent):void{
		applyAssalArr.removeAll();
		for each(var castle:CastleObj in GameContext.instance.getPlayerObj().getAllCastle()){
			if(castle.conquestManager.applyBeConquestCastleArray.length>0){
				for each(var c:ConquestObj in castle.conquestManager.applyBeConquestCastleArray){
					applyAssalArr.addItem(c);
				}
			}
		}
	}
	
	/**
	 * 附庸城列表有更新
	 */ 
	private function onConquestListUpdate(event:ConquestEvent):void{
		conquestArr = curCastleObj.conquestManager.getCurConquestList(curCastleObj.cityId);
	}
	
	/**
	 * 宗主国的信息更新
	 */ 
	private function onConquestHostUpdate(event:ConquestEvent):void{
		suzerainMesView.refresh(curCastleObj);
	}
	
	/**
	 * 附庸城的选中
	 */ 
	/* private function onConquestSelect(e:ListEvent):void{
		if(e.columnIndex == 5 || e.columnIndex ==2)return;
		var co:ConquestObj = ConquestObj(e.itemRenderer.data);
		var c:CastleObj = GameContext.instance.getPlayerObj().getCastleObjById(co.selfCastleId);
		selectConquestObj = co;
		var con:ConquestObj;
		for each(con in c.conquestManager.conquestCastleArray)
			con.isSelect = false;
		selectConquestObj.isSelect = true;
		ControllerFactory.getInstance().getCityController().conquestResource(selectConquestObj.selfCastleId,selectConquestObj.relatedCityBean.castle.cityId,onConquestResource);
	} */
	
	private function onConquestResource(e:ResourceStaticResponse):void{
		resourceObj["food"]=e.foodBean.conquestAdd;
		resourceObj["wood"]=e.woodBean.conquestAdd;
		resourceObj["stone"]=e.stoneBean.conquestAdd;
		resourceObj["iron"]=e.ironBean.conquestAdd;
	}
	
	/**
	 * 查看附庸城信息
	 */ 
	public function checkOutAssal(data:Object):void{
		EvtDispacther.instance.eventDispatch(VassalMesWin.WINDOW_SHOW,data);
	}
	
	/**
	 * 坐标跳转
	 */ 
	public function gotoPos(fId:int):void{
		if(ToggleButton.instance.isTown){
			ToggleButton.instance.switchHandler(true);
		}
		DiamondWorldMap2.instance.setOnShow(true);
		DiamondWorldMap2.instance.goPoint(GameContext.getFieldPostionX(fId),GameContext.getFieldPostionY(fId));
	}

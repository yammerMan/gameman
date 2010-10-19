// ActionScript file
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

import mx.collections.ArrayCollection;
import mx.events.FlexEvent;
import mx.events.ItemClickEvent;
import mx.logging.ILogger;
import mx.logging.Log;

import roma.common.constants.BuildingConstant;
import roma.common.constants.HeroManConstants;
import roma.common.controller.CommonResponse;
import roma.common.valueObject.BattleFieldBean;
import roma.logic.GameContext;
import roma.logic.object.building.BaseBuilding;
import roma.logic.object.castle.CastleObj;
import roma.logic.object.hero.HeroObj;
import roma.logic.object.player.BattleFieldObj;
import roma.logic.object.player.OtherArmyObj;
import roma.logic.object.player.PlayerObj;
import roma.logic.object.player.ScoutTeamObj;
import roma.logic.rule.ItemRule;
import roma.message.EvtDispacther;
import roma.message.events.IntelligenceEvent;
import roma.util.MultiLang;

import views.MainContainer;
import views.PopupWindows;
import views.spreadUI.MyAlert;
import views.spreadUI.castleIcon.CastleIconPanel;
import views.spreadUI.speedUp.ItemSelectSpeedUpWin;
import views.windows.buildings.trainningField.TrainningFieldWin;
import views.windows.functionWins.hero.HeroHelper;
import views.windows.functionWins.hero.HerosMansionWin;

/**
 * @default
 */
public static const WINDOW_SHOW:String="intelligenceWin.show";
private static var log:ILogger=Log.getLogger("views.windows.functionWins.intelligence.IntelligenceWin");

private static const ATTACKTYPE:int = 0;
private static const DEFENSETYPE:int = 1;
private static const MIDTYPE:int = 2;

[Bindable]
public var checkOutLabel:String=MultiLang.msg("public.label.checkOut");
[Bindable]
public var callBackLabel:String = MultiLang.msg("intelligence.troops.callBack");

[Bindable]
private var allianceArmyArray:ArrayCollection;
[Bindable]
private var battleSituationArray:ArrayCollection=new ArrayCollection();
[Bindable]
private var selfBattleSituationArray:ArrayCollection=new ArrayCollection();
[Bindable]
private var onCampaignArray:ArrayCollection=new ArrayCollection();
[Bindable]
private var scoutsArray:ArrayCollection;
[Bindable]
private var selfArmyArray:ArrayCollection;

[Bindable]
private var isOthersBattle:Boolean;
[Bindable]
private var selectedIndex:int=0;

private var timer:Timer=new Timer(1000);

[Bindable]
private var titleBtnArray:ArrayCollection=new ArrayCollection([MultiLang.msg('battleSituation.info.label'), MultiLang.msg('intelligence.selfArmy'), MultiLang.msg('intelligence.armyAction'), MultiLang.msg('intelligence.allianceArmy'), MultiLang.msg('military.mission.scout')]);

/**
 * 界面隐藏调用，停止当前窗体一切相关动画等
 */
override public function destroy():void
{
	log.debug("IntelligenceWin.destroy()");
	this.timer.stop();
}

/**
 * 每次界面弹出调用，刷新数据
 */
override public function refresh():void
{
	log.debug("IntelligenceWin.refresh()");
	this.buttonBar.selectedIndex=this.selectedIndex;
	this.refreshData();
}

/**
 * 
 */ 
override protected function onCreationComplete(event:FlexEvent):void
{
	super.onCreationComplete(event);
	EvtDispacther.instance.addEventListener(EvtDispacther.HERO_STATUS_CHANGE, onHeroStatusChange);
	EvtDispacther.instance.addEventListener(EvtDispacther.ALLIANCE_ARMY_CHANGE, onAllianceArmyChange);
	EvtDispacther.instance.addEventListener(EvtDispacther.SCOUTS_CHANGE, onScoutsChange);
	EvtDispacther.instance.addEventListener(IntelligenceEvent.HAS_BATTLE_CHANGE,onBattleFieldChange);

	this.timer.addEventListener(TimerEvent.TIMER, timerHandler);

	function onBattleFieldChange(event:IntelligenceEvent):void{
		if(Boolean(event.battleField) == true){
			if(selectedIndex == 0)
			showBattleSituation();
		}
	}
	function onScoutsChange(event:Event):void
	{
		if (selectedIndex == 4)
		showScoutTeam();
	}
	function onHeroStatusChange(event:Event):void
	{
		if(selectedIndex == 1 || selectedIndex == 2)
		showSelfArmy(selectedIndex);
	}
	function onAllianceArmyChange(event:Event):void
	{
		if (selectedIndex == 3)
		showAllianceArmy();
	}
}


/**
 * 直接跳转到广场中的驻军情况
 */
public function checkOutAllianceArmy(obj:Object):void
{
	var p:PlayerObj = GameContext.instance.getPlayerObj();
	var b:OtherArmyObj = OtherArmyObj(obj);
	var c:CastleObj = p.getCastleByFieldId(b.bean.targetFieldId);
	CastleIconPanel.instance.gotoTown(b.bean.targetFieldId);
	var trainingFieldObj:BaseBuilding=c.buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_TRAINNINGS);
	PopupWindows.openBuildingInfoWin(TrainningFieldWin.WINDOW_SHOW, trainingFieldObj, "residenceArmyWin");
}

public function isCallBackBtnShow(data:Object):Boolean{
	var h:HeroObj = HeroObj(data);
	return h.heroInfo.status == HeroManConstants.STATUS_IN_BATTLE_FIELD;
}

/**
 * 召回英雄
 */ 
public function callBackHero(obj:Object):void{
	var h:HeroObj = HeroObj(obj);
	if(!h.isCanCallBack()){
		MyAlert.show(MultiLang.msg("intelligence.battle.hasSomeOneJoin"));
		return;
	}
	
	if(h.battleGoTime()<HeroManConstants.HERO_CALL_BACK_NEED_ITEM_MINS){
		MyAlert.show(MultiLang.msg("intelligence.battle.noOverOneMin"),callNoOverTimeBackFun);
	}else{
		MyAlert.show(MultiLang.msg("intelligence.battle.isOverOneMin"),callOverTimeBackFun);
	}
	
	function callNoOverTimeBackFun(isTrue:Boolean):void{
		if(isTrue)
		HeroHelper.instance.callbackHero(h,reCallArmyResponse);
//		ControllerFactory.getInstance().getArmyController().reCallArmy(h.castle.cityId, h.heroInfo.id,reCallArmyResponse);
	}
	
	function callOverTimeBackFun(isTrue:Boolean):void{
		if(isTrue)
		ItemSelectSpeedUpWin.show(new ArrayCollection([HeroManConstants.CALL_BACK_HERO_ITEM]),onUseResponse);
	}
	
	function onUseResponse(i:ItemRule):void{
		HeroHelper.instance.callbackHero(h,reCallArmyResponse);
//		ControllerFactory.getInstance().getArmyController().reCallArmy(h.castle.cityId,h.heroInfo.id,reCallArmyResponse);
	}
	
	function reCallArmyResponse(e:CommonResponse):void{
		if(e.isSuccess()){
			if(h.heroInfo.battleFieldLeader){
				MainContainer.instance.risePlay(MultiLang.msg("intelligence.battle.launcher.callBackSuccess"));
			}else{
				MainContainer.instance.risePlay(MultiLang.msg("intelligence.battle.joiner.callBackSuccess"));
			} 
		}
		else{
			MyAlert.showError(e);
		}
	}
}

/**
 * 查看自己军队的动态
 */
public function checkOutTroopMove(obj:Object):void
{
	var hero:HeroObj=HeroObj(obj);
	PopupWindows.openFuncWin(HerosMansionWin.WINDOW_SHOW, hero);
}

/**
 * 查看军队出征情况
 */
public function checkOutCampaign(obj:Object):void
{
}

/**
 * 当标签被点击的时候
 */
private function clickHandler(event:ItemClickEvent):void
{
	if (isOthersBattle)
	{
		return;
	}
	this.selectedIndex=event.index;
	this.buttonBar.selectedIndex = event.index;
	switch(event.index){
		case 0:
			this.viewStach.selectedIndex = event.index;
		break;
		case 1:
			this.viewStach.selectedIndex = 1;
		break;
		case 2:
			this.viewStach.selectedIndex = 1;
		break;
		case 3:
			this.viewStach.selectedIndex = 2;
		break;
		case 4:
			this.viewStach.selectedIndex = 3;
		break;
	}
	this.refreshData();
}

/**
 * 标签切换的时候，刷新数据
 */
private function refreshData():void
{
	if (this.selectedIndex == 0)
	{
		showBattleSituation();
	}
	else if (this.selectedIndex == 1)
	{
		this.showSelfArmy(1);
	}
	else if (this.selectedIndex == 2)
	{
		this.showSelfArmy(2);
	}
	else if (this.selectedIndex == 3)
	{
		this.showAllianceArmy();
	}
	else if(this.selectedIndex == 4)
	{
		this.showScoutTeam();
	}
	else{}
}

private function showBattleSituation():void
{
	battleSituationArray.removeAll();
	var b1:BattleFieldBean;
	var b2:BattleFieldBean;
	var b3:BattleFieldBean;
	var bo:BattleFieldObj
	for each (b1 in GameContext.instance.getPlayerObj().battleFieldManager.attackBattlesArray)
	{
		bo = new BattleFieldObj(b1);
		bo.isAttack=true;
		battleSituationArray.addItem(bo);
	}
	for each (b2 in GameContext.instance.getPlayerObj().battleFieldManager.defendBattlesArray)
	{
		bo = new BattleFieldObj(b2);
		bo.isDefend=true;
		battleSituationArray.addItem(bo);
	}
	for each (b3 in GameContext.instance.getPlayerObj().battleFieldManager.otherBattlesArray)
	{
		bo = new BattleFieldObj(b3);
		// 需要判断是否为附庸城
		var c:CastleObj = GameContext.instance.getPlayerObj().getCurCastleObj();
		if(c.conquestManager.isVassalByFieldId(b3.targetId)){
			bo.isDefend = true;
		}else{
			bo.isMid =true;
		}
		battleSituationArray.addItem(bo);
	}
	battleSituationArray.toArray().sortOn("battleTime", Array.NUMERIC);
	battleSituation.refresh(battleSituationArray);
}

private function setBattleList():void{
	
}

private function showAllianceArmy():void
{
	this.allianceArmyArray=GameContext.instance.getPlayerObj().otherArmyManager.getLeagueArmyArray();
	this.timer.start();
}

private function showScoutTeam():void
{
	this.scoutsArray=GameContext.instance.getPlayerObj().armyManager.scoutTempList;
	timer.start();
}

private function showSelfArmy(index:int):void
{
	if (index == 1)
	{
		this.selfArmyArray=GameContext.instance.getPlayerObj().armyManager.heroInbattleList;
	}
	else
	{
		this.selfArmyArray=GameContext.instance.getPlayerObj().armyManager.heroMoveList;
	}
	this.timer.start();
}

/**
 * 用于刷新剩余时间的计数器
 */
private var timeCount:int = 0;
private function timerHandler(event:Event):void
{
	if (selectedIndex == 0){
		// 战局
		timeCount ++;
		if(timeCount >10){
			timeCount = 0;
			GameContext.instance.getPlayerObj().battleFieldManager.hasModify(true);
		}
	}
	else if (selectedIndex == 1 || selectedIndex == 2)
	{
		// 军队动态 || 出征作战
		if (this.selfArmyArray.length > 0)
		{
			for each (var hero:HeroObj in this.selfArmyArray)
				hero.resetRemainTimeStr();
		}
		else
			this.timer.stop();
	}
	else if (selectedIndex == 3)
	{
		//盟军
		if (this.allianceArmyArray.length > 0)
		{
			for each (var obj:OtherArmyObj in this.allianceArmyArray)
				obj.resetRemainTimeStr();
		}
		else
			this.timer.stop();
	}
	else if (selectedIndex == 4)
	{
		//侦察
		if (this.scoutsArray.length > 0)
		{
			for each (var scout:ScoutTeamObj in this.scoutsArray)
				scout.resetRemainTimeStr();
		}
		else
			this.timer.stop();
	}
}

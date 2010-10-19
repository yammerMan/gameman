// ActionScript file
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.events.ListEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.AllianceConstant;
	import roma.common.constants.BattleConstants;
	import roma.common.constants.BuffConstants;
	import roma.common.constants.BuildingConstant;
	import roma.common.constants.ChatConstant;
	import roma.common.constants.HeroManConstants;
	import roma.common.constants.PlayerConstant;
	import roma.common.controller.CommonResponse;
	import roma.common.controller.army.CreateWarFieldResponse;
	import roma.common.controller.common.MapFieldInfoResponse;
	import roma.common.valueObject.FieldCollectBean;
	import roma.common.valueObject.MapFieldInfoBean;
	import roma.data.MapTileData;
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.object.castle.BattleHelper;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.object.hero.HeroObj;
	import roma.message.EvtDispacther;
	import roma.message.events.TroopCampaignEvent;
	import roma.util.JavaScriptHelper;
	import roma.util.MultiLang;
	
	import views.BeginnerGuide;
	import views.MainContainer;
	import views.PopupWindows;
	import views.mainModules.map.diamond2.DiamondWorldMap2;
	import views.mainModules.map.diamond2.MapDataByteArray;
	import views.mainModules.map.smallMap.NpcFieldConstant;
	import views.spreadUI.MyAlert;
	import views.spreadUI.beginnerGuide.MyAlert1;
	import views.spreadUI.popups.MarketPosition;
	import views.spreadUI.popups.PopupContainer;
	import views.windows.functionWins.military.GoingToWarWin;
	
	public static const WINDOW_SHOW:String = "createArmyWin.windowShow";
	public static var instance:GoingToWarWin;
	private var log:ILogger = Log.getLogger("views.windows.functionWins.military.NewArmyWin");

	[Bindable]
	private var mapTileData:MapTileData;
	[Bindable]
	private var curHero:HeroObj;

	[Bindable]
	private var isAttackMission:Boolean;
	[Bindable]
	private var isJoin:Boolean = false;
	
	[Bindable]
	private var cityComData:Array=new Array();
	[Bindable]
	private var heroArray:ArrayCollection = new ArrayCollection();
	[Bindable]
	private var curSelectFieldName:String = "";
	private var curSelectCastle:CastleObj;
	
	[Bindable]
	private var moveNeedTimeStr:String = "";
	private var moveNeedTime:int = 0;
	
	private var marketPosition:MarketPosition;                      // 收藏列表 
	
	override public function refresh():void{
		refreshFromMapTile(winData);
	}
	
	private function init():void{
		marketPosition = PopupContainer.instance.marketPosition;
		stage.addEventListener(MouseEvent.MOUSE_DOWN,onStageDown);
		instance = this;

		EvtDispacther.instance.addEventListener(BeginnerGuide.IS_SURE_LOOT,onSureLoot);
		EvtDispacther.instance.addEventListener(BeginnerGuide.START_LOOT,onStartLoot);
	}
	
	/**
	 * 初始化数据
	 */ 
	private function returnInit():void{
		moveNeedTimeStr = "";
		moveNeedTime = 0;
		ti_lostLimit.text="";
		cb_lostLimit.selected=false;
		cb_closeInAllDead.selected=false;
		cb_longDistanceAllDead.selected=false;
		appealAllianceCB.selected = false;
		appealFriendsCB.selected = false;
		isJoin = false;
	}
	
	/**
	 * 程序入口
	 */
	public function refreshFromMapTile(d:Object):void {
		returnInit();
		mapTileData = MapTileData(d);
		mapTileData.isNpc = mapTileData.missionType == BattleConstants.ARMY_MISSION_TRAINNING;
		heroInfo.setMapTileData(mapTileData,missionSelectCallBack);
		
		getCityArr();
		isJoin = mapTileData.isJoin;
		//是否是进攻行的任务
		isAttackMission = mapTileData.missionType != BattleConstants.ARMY_MISSION_REINFORCE&&mapTileData.missionType != BattleConstants.ARMY_MISSION_TRAINNING;
	}
	
	/**
	 * 选择了英雄
	 */
	public function onHeroSelected(data:Object):void {
		var hero:HeroObj = HeroObj(data);
		if (this.curHero!=null) {
			this.curHero.selectedInUi = false;
		}
		hero.updateHeroObj();
		curHero = hero;
		curHero.selectedInUi = true;
		reCalcTime();
		heroInfo.setHero(curHero);
	}
	
	/**
	 * 获得城池列表
	 */ 
	private function getCityArr():void{
		cityComData=GameContext.instance.getPlayerObj().getAllCastle();
		for(var i:int=0;i<cityComData.length;i++){
			if (CastleObj(cityComData[i]).cityId==GameContext.instance.getPlayerObj().getCurCastleObj().cityId){
				this.cityCom.selectedIndex=i;
				this.curSelectCastle = cityComData[i];
				break;
			}
		}
		this.checkSelectHero();
	}
	
	/**
	 * 选择了城池
	 */
	public function onCitySelected(event:ListEvent):void {
		this.curSelectCastle=this.cityComData[event.currentTarget.selectedIndex];
		this.checkSelectHero();
	}
	
	/**
	 * 可选择的英雄
	 */ 
	private function checkSelectHero():void{
		var ac:ArrayCollection = this.curSelectCastle.heroManager.heroArray;
		this.heroArray.removeAll();
		this.curHero = null;
		for each(var hero:HeroObj in ac) {
			if (hero.heroInfo.canGoOut && hero.heroInfo.status != HeroManConstants.STATUS_CHIEF) {
				hero.selectedInUi=false;
				this.heroArray.addItem(hero);
				if (this.curHero==null) {
					this.onHeroSelected(hero);
				}
			}
		}
	}
	
	/**
	 * 是否确定派兵
	 */ 
	private function onSendBtnClick():void {
		var n:String = mapTileData.fieldName+"[" + mapTileData.fieldX + "," + mapTileData.fieldY + "]";
		var m:String = BattleHelper.instance.getBattleMission(heroInfo.getBeanMissionType());
		if(mapTileData.isNpc&&MapDataByteArray.instance.isRatterNpcCastle(mapTileData.fieldX,mapTileData.fieldY)){
			m=BattleHelper.instance.getBattleMission(heroInfo.getBeanMissionType(),NpcFieldConstant.TYPE_RATTER_NPC_FIELD);
		}
		MyAlert.show(MultiLang.msg("military.whetherToGo.tip",n,m),sureToSendTroops);
	}
	
	private function onSureLoot(event:Event):void{
		var n:String = mapTileData.fieldName+"[" + mapTileData.fieldX + "," + mapTileData.fieldY + "]";
		var m:String = BattleHelper.instance.getBattleMission(heroInfo.getBeanMissionType());
		MyAlert1.instance.show(MultiLang.msg("military.whetherToGo.tip",n,m),call);
		
		function call():void{
		}
	}
	
	private function onStartLoot(event:Event):void{
		MyAlert1.instance.visible = false;
		sureToSendTroops(true);
	}
	
	/**
	 * 判断是否派兵
	 */ 
	private function sureToSendTroops(isTure:Boolean):void{
		if(!isTure)return;
		// 有没有校场
		if(!isHasTrainingFeild(curSelectCastle)) return ;
		// 只是派遣到自己的城池
		if(sendToMyCity(curHero,mapTileData))return;			
		// 判断是否可以出征
		if(checkBattle(curSelectCastle,curHero)) return;
		// 判断对方城池的关系
		if(!canNewArmy(curSelectCastle,mapTileData))return;
		
		if(isJoin)sendJoinBattle(curHero,mapTileData);
		else sendTroops(curHero,mapTileData);
	}

	/**
	 * 建立战局,或派遣
	 */ 
	private function sendTroops(h:HeroObj,m:MapTileData):void{
//		m.arrivedTime = moveNeedTime*1000;
		//伤亡率
		var lostLimit:int = 0;
		if (cb_lostLimit.selected && ti_lostLimit.text.length>0){
			lostLimit = int(ti_lostLimit.text);
		}
		log.debug("NewArmy.onSendBtnClick "+m.fieldX+" , "+m.fieldY);
		if(heroInfo.getBeanMissionType()== BattleConstants.ARMY_MISSION_REINFORCE)
			// 派遣部队
			ControllerFactory.getInstance().getArmyController().createArmy(h.castleObj.cityId,h.heroInfo.id
				,lostLimit,cb_closeInAllDead.selected,cb_longDistanceAllDead.selected,
				GameContext.getFieldId(m.fieldX,m.fieldY),
				0,onNewArmyResponse,false);
		else{
			// 攻击建立战局
			ControllerFactory.getInstance().getArmyController().createWarField(h.castleObj.cityId,h.heroInfo.id
				,lostLimit,cb_closeInAllDead.selected,cb_longDistanceAllDead.selected,
				GameContext.getFieldId(m.fieldX,m.fieldY),heroInfo.getBeanMissionType(),
				0,onCreateWarResponse,false);
		} 
	}
	
	/**
	 * 加入战局
	 */ 
	private function sendJoinBattle(h:HeroObj,m:MapTileData):void{
		// 加入征服战也不需要考虑体力值
		var lostLimit:int = 0;
		log.debug("NewArmyWin.sendJoinBattle "+m.fieldX+" , "+m.fieldY);
		if (cb_lostLimit.selected && ti_lostLimit.text.length>0){
			lostLimit = int(ti_lostLimit.text);
		}
		
		if(heroInfo.getBeanMissionType() == BattleConstants.ARMY_MISSION_REINFORCE){
			ControllerFactory.getInstance().getArmyController().joinWarField(h.castleObj.cityId,h.heroInfo.id,
			lostLimit,cb_closeInAllDead.selected,cb_longDistanceAllDead.selected,
			GameContext.getFieldId(m.fieldX,m.fieldY),m.battleId,false
			,onJoinWarFieldResponse); 
		}else{
			ControllerFactory.getInstance().getArmyController().joinWarField(h.castleObj.cityId,h.heroInfo.id,
			lostLimit,cb_closeInAllDead.selected,cb_longDistanceAllDead.selected,
			GameContext.getFieldId(m.fieldX,m.fieldY),m.battleId,true
			,onJoinWarFieldResponse); 
		} 
		function onJoinWarFieldResponse(event:CommonResponse):void{
			if(!event.isSuccess()){
				MyAlert.showError(event);
			} else {
				MainContainer.instance.risePlay(MultiLang.msg('military.sendArmySuccess.tips'));
				PopupWindows.closeAll();
			}
		}	
	}
	
	private function onCreateWarResponse(event:CreateWarFieldResponse):void{
		if(!event.isSuccess()){
			MyAlert.showError(event);
		}else{
			MainContainer.instance.risePlay(MultiLang.msg('military.sendArmySuccess.tips'));
			if(appealAllianceCB.selected){
				// 通知联盟
				mapTileData.arrivedTime = event.arriveTime;
				mapTileData.missionType = heroInfo.getBeanMissionType();
				mapTileData.battleId = event.battleId;
				EvtDispacther.instance.dispatchEvent(new TroopCampaignEvent(TroopCampaignEvent.TROOP_CAMPAIGN,mapTileData,ChatConstant.TYPE_ALLIANCE_CHAT));
			}
			if(appealFriendsCB.selected){
				// 通知好友
				mapTileData.battleId = event.battleId;
				mapTileData.missionType = heroInfo.getBeanMissionType();
				mapTileData.arrivedTime = event.arriveTime;
				EvtDispacther.instance.dispatchEvent(new TroopCampaignEvent(TroopCampaignEvent.TROOP_CAMPAIGN,mapTileData,ChatConstant.TYPE_PRIVATE_CHAT));
			}
			PopupWindows.closeAll();
			refreshMap()
			this.addGoogleLog();
		}
	}
	
	private function onNewArmyResponse(event:CommonResponse):void {
		if (!event.isSuccess()) {
			MyAlert.showError(event);
		} else {
			MainContainer.instance.risePlay(MultiLang.msg("military.sentTroop.success.tip"));
			PopupWindows.closeAll();
			this.addGoogleLog();
		}
	}
	
	/**
	 * 派兵到自己城，英雄可以不用带兵
	 */ 
	private function sendToMyCity(h:HeroObj,m:MapTileData):Boolean{
		var fId:int = GameContext.getFieldId(m.fieldX,m.fieldY);
		if(!GameContext.instance.getPlayerObj().isMyCity(fId)){
			return false;
		}
		var lostLimit:int = 0;
		
		if(heroInfo.getBeanMissionType() == BattleConstants.ARMY_MISSION_REINFORCE){
			ControllerFactory.getInstance().getArmyController().createArmy(h.castleObj.cityId,
				h.heroInfo.id,lostLimit,cb_closeInAllDead.selected,cb_longDistanceAllDead.selected,
				GameContext.getFieldId(m.fieldX,m.fieldY),0,onNewArmyResponse,false);
				return true;
		} 
		else return false;
	}
	
	private function isHasTrainingFeild(c:CastleObj):Boolean{
		var trainingField:BaseBuilding = c.buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_TRAINNINGS);
		if(trainingField ==null){
			MyAlert.show(MultiLang.msg("military.not.trainingField.tip",BattleHelper.instance.getBattleMission(heroInfo.getBeanMissionType())));
			return false;
		}
		return true;
	}
	
	/**
	 * 判断是否可以出征 
	 * @return 
	 */	
	private function canNewArmy(c:CastleObj,m:MapTileData):Boolean{
		var type:String = BattleHelper.instance.getBattleMission(heroInfo.getBeanMissionType());
		if(GameContext.instance.getPlayerObj().buffManager.getBuffById(BuffConstants.PLAYER_BEGINNER) !=null && m.isCastle){
			MyAlert.show(MultiLang.msg('military.own.novice.tip',MultiLang.msg("playInfo.buffFreshManStatus"),type));
			return false;
			//自己免战
		}else if(GameContext.instance.getPlayerObj().buffManager.getBuffById(BuffConstants.PLAYER_PEACE) !=null && m.isCastle){
			MyAlert.show(MultiLang.msg('military.own.novice.tip',MultiLang.msg("playInfo.peaceStatus"),type));
			return false;
			//玩家是否是新手
		}else if(m.status == PlayerConstant.PLAYER_STATUS_FRESH_MAN && m.isCastle){
			MyAlert.show(MultiLang.msg("military.player.novice.ceaseFire.tip",MultiLang.msg('chatType.beginner'),type));
			return false;
			//玩家是否是免战
		}else if(m.status== PlayerConstant.PLAYER_STATUS_FREE_OF_WAR && m.isCastle){
			MyAlert.show(MultiLang.msg("military.player.novice.ceaseFire.tip",MultiLang.msg('playInfo.peaceStatus'),type));	
			return false;	
			//是同盟、以及同盟的附庸城、不是协防的情况
		}else if(m.isCastle && m.relation ==AllianceConstant.ALLIANCE_RELATION_SAME 
			&& m.hostRelation == AllianceConstant.ALLIANCE_RELATION_SAME 
			&& heroInfo.getBeanMissionType() !=BattleConstants.ARMY_MISSION_REINFORCE
			){
			MyAlert.show(MultiLang.msg("military.don't.createArmy.tip",MultiLang.msg('alliance.same'),type));
			return false;
			//是友盟、以及友盟的附庸城、(但是宗主国可以优先攻击)不是协防的情况
		}else if(m.isCastle && m.relation==AllianceConstant.ALLIANCE_RELATION_FRIENDLY
			&& m.hostRelation == AllianceConstant.ALLIANCE_RELATION_FRIENDLY 
			&& heroInfo.getBeanMissionType() !=BattleConstants.ARMY_MISSION_REINFORCE 
			&& !c.conquestManager.isHostByFieldId(GameContext.getFieldId(m.fieldX,m.fieldY))){
			MyAlert.show(MultiLang.msg("military.don't.createArmy.tip",MultiLang.msg('alliance.friendly'),type));
			return false;	
			//可以对附庸城只能协防
		}else if(m.isCastle && c.conquestManager.isVassalByFieldId(GameContext.getFieldId(m.fieldX,m.fieldY)) 
			&& heroInfo.getBeanMissionType() !=BattleConstants.ARMY_MISSION_REINFORCE){
			MyAlert.show(MultiLang.msg("military.don't.createArmy.tip",MultiLang.msg('ranking.label.vassal'),type));
			return false;
		}
		return true;
	}
	
	/**
	 * 检查战斗条件(迁城冷却中，英雄没兵，英雄体力值，征服战和元老院不需要体力值)
	 */ 
	private function checkBattle(c:CastleObj,h:HeroObj):Boolean{
		if(c.buffManager.getBuffById(BuffConstants.CASTLE_ADV_MOVE)!=null){
 			MyAlert.show(MultiLang.msg('buff.moveCity.coolDown'));
 			return true;
 		}
		if(h.troopStrength<=0){
			MyAlert.show(MultiLang.msg('military.armyIsEmpty.desc'));
			return true;
		}
		if(h.heroInfo.strengthPoint<HeroManConstants.ARMY_ACTION_CONSUME_STRENGTH_POINT && 
			heroInfo.getBeanMissionType() != BattleConstants.ARMY_MISSION_CONQUEST){
			MyAlert.show(MultiLang.msg("hero.strength.notEnough"));
			return true;
		}
		return false;
	}

	private function addGoogleLog():void {
		var action:String= "";
		/* switch (this.missionTypeCom.selectedItem.data) {
			case BattleConstants.ARMY_MISSION_LOOT:
				action = "掠夺";
				break;
			case BattleConstants.ARMY_MISSION_CONQUEST:
				action = "征服";
				break;
			case BattleConstants.ARMY_MISSION_ATTACK:
				action = "占领"
				break;
			case BattleConstants.ARMY_MISSION_REINFORCE:
				action = "增援";
				break;
		} */
		if (mapTileData.isCastle) {
			JavaScriptHelper.instance.trackEvent("militry", action, "player" , curHero.troopStrength);
		} else {
			JavaScriptHelper.instance.trackEvent("militry", action, mapTileData.fieldName , curHero.troopStrength);
		} 
	}
	
	
	/**
	 * 刷新地图
	 */ 
	private function refreshMap():void{
		DiamondWorldMap2.instance.sendCommandToServer();
	}
	
	/**
	 * 重新计算移动需要时间
	 */
	private function reCalcTime():void {
		if (curHero!=null) {
			var t:int = curHero.getMoveNeedTimeInSecond(mapTileData.fieldX , mapTileData.fieldY);
			if(!this.mapTileData.isCastle){
				moveNeedTime = Math.min(t,BattleConstants.MAX_BATTLE_PREPARE_TIME_HOURS*60*60);
			}else{
				var t1:int = Math.max(t,BattleConstants.MIN_BATTLE_PREPARE_TIME_MINUTES*60);
				moveNeedTime = Math.min(t1,BattleConstants.MAX_BATTLE_PREPARE_TIME_HOURS*60*60);
			}
			moveNeedTimeStr = MultiLang.timeFormatToString(this.moveNeedTime);
		} else {
			moveNeedTimeStr = "";
		}
	} 
	
	private function onShowPositionList(event:MouseEvent):void{
		var p:Point = Button(event.target).localToGlobal(new Point(event.target.x,event.target.y));
		marketPosition.visible = !marketPosition.visible;
		marketPosition.setPos(p.x-200,p.y+event.target.height);
		marketPosition.showMyCity(true);
		marketPosition.callBackFun = onGetMarketCoor;
	}
	
	private function onGetMarketCoor(obj:Object):void{
		var px:int= 0;
		var py:int = 0;
		if(obj.hasOwnProperty('cityId')){
			px = CastleObj(obj).idField/10000;
			py = CastleObj(obj).idField%10000;
			mapTileData.fieldName = CastleObj(obj).name;
		}else{
			px = FieldCollectBean(obj).fieldId/10000;
			py = FieldCollectBean(obj).fieldId%10000;
			mapTileData.fieldName = FieldCollectBean(obj).remark;
		}  
		mapTileData.fieldX = px;
		mapTileData.fieldY = py;
		if(curHero==null)return;
		ControllerFactory.getInstance().getCommonController().mapFieldInfo(curHero.castleObj.cityId,px,py,onResponse,false);	
	}
	
	private function onResponse(event:MapFieldInfoResponse):void{
		if(event.isSuccess()){
			getMapTileDate(event.mapFieldInfoBean);
		}else{
			MyAlert.showError(event);
		}
	}	
	
	private function onStageDown(event:MouseEvent):void{
		if(marketPosition.hitTestPoint(event.stageX,event.stageY)){
		}else{
			marketPosition.visible = false;
		}
	}
	
	/**
	 * 选择出征类型时返回函数
	 */ 
	private function missionSelectCallBack(t:int):void{
		isAttackMission = t != BattleConstants.ARMY_MISSION_REINFORCE && t != BattleConstants.ARMY_MISSION_TRAINNING;
	}
	
	private function getMapTileDate(bean:MapFieldInfoBean):void {
		if(bean == null){
			// 此时为npc城
			mapTileData.isNpc = true;
		}else {
			mapTileData.isNpc = false;
			mapTileData.status = bean.status;
			mapTileData.relation = bean.relation;
			mapTileData.hostRelation = bean.hostRelation;
			mapTileData.canAttack = bean.canAttack;
			mapTileData.hostPlayer = bean.hostPlayer;
			mapTileData.hostFieldId = bean.hostFieldId;
			mapTileData.isCastle = MapDataByteArray.instance.getTileObj(mapTileData.fieldX,mapTileData.fieldY).isCastle();
			mapTileData.canReinforce = true;
			this.isAttackMission = mapTileData.missionType != BattleConstants.ARMY_MISSION_REINFORCE&&mapTileData.missionType != BattleConstants.ARMY_MISSION_TRAINNING;
		}
		heroInfo.setMapTileData(mapTileData,missionSelectCallBack);
		reCalcTime();
	}
	

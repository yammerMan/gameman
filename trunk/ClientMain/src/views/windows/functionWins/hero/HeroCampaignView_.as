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
	import views.spreadUI.MyAlert;
	import views.spreadUI.beginnerGuide.MyAlert1;
	import views.spreadUI.popups.MarketPosition;
	import views.spreadUI.popups.PopupContainer;
	import views.windows.functionWins.hero.HeroHelper;
	import views.windows.functionWins.hero.HerosMansionWin;

	
	private var log:ILogger = Log.getLogger("views.windows.functionWins.military.NewArmyWin");

	[Bindable]
	private var mapTileData:MapTileData;
	[Bindable]
	private var missionTypeComTip:String;
	[Bindable]
	private var curHero:HeroObj;
	[Bindable]
	private var heroSelectorVisable:Boolean = false;
	[Bindable]
	private var isAttackMission:Boolean;
	[Bindable]
	private var isJoin:Boolean = false;
	[Bindable]
    private var missionTypeComData:ArrayCollection=new ArrayCollection();
	[Bindable]
	private var cityComData:Array=new Array();
	[Bindable]
	private var heroArray:ArrayCollection = new ArrayCollection();
	[Bindable]
	private var curSelectFieldName:String = "";
	[Bindable]
	private var moveNeedTimeStr:String = "";
	
	[Bindable]
	private var missionComIndex:int;

	private var curSelectCastle:CastleObj;
	private var marketPosition:MarketPosition;                      // 收藏列表 
	private var moveNeedTime:int = 0;
	private var missionType:int;
	private var _bean:FieldCollectBean;
	
	
	/**
	 *出征到收藏夹的野地 
	 */		
	private function goToWar():void{
		getFieldFavoriteAry();
		if(_bean !=null){
			var fx:int = _bean.fieldId/10000;
			var fy:int = _bean.fieldId%10000;
			var castleId:int = this.curHero.castleObj.cityId;
			if(MapDataByteArray.instance.isTrainNpcCastle(fx,fy)||MapDataByteArray.instance.isRatterNpcCastle(fx,fy)){
				npcMapTileDataHandle();
			}else{		
				ControllerFactory.getInstance().getCommonController().mapFieldInfo(castleId,fx,fy , onResponse,false);//需要判断是否是npc或普通野地	
			}
		}
		function onResponse(event:MapFieldInfoResponse):void{
			if(event.isSuccess()){
				getMapTileDate(event.mapFieldInfoBean);
				refreshFromMapTile(curHero,mapTileData);
			}else{
				MyAlert.showError(event);
			}
		}	
	}
	
	private function getFieldFavoriteAry():void{
		var favAry:ArrayCollection= GameContext.instance.getPlayerObj().favoriteManager.filterArray;
		if(favAry.length>0){
			_bean = favAry.getItemAt(0) as FieldCollectBean;
			getMapTileDateFromfaver(_bean);
			onGetMarketCoor(_bean);
			setMissionType(this.mapTileData);
		}else{
			_bean = null;
		}
	}
	
	
//	public function refresh():void{
//		refreshFromMapTile(this.eventData);
//	}
	
	private function init():void{
		marketPosition = PopupContainer.instance.marketPosition;
		this.stage.addEventListener(MouseEvent.MOUSE_DOWN,onStageDown);

		EvtDispacther.instance.addEventListener(BeginnerGuide.IS_SURE_LOOT,onSureLoot);
		EvtDispacther.instance.addEventListener(BeginnerGuide.START_LOOT,onStartLoot);
	}
	
	/**
	 * 初始化数据
	 */ 
	private function returnInit():void{
		if(!this.initialized)return;
		this.moveNeedTimeStr = "";
		this.cb_lostLimit.selected=false;
		this.ti_lostLimit.text="";
		this.cb_closeInAllDead.selected=false;
		this.cb_longDistanceAllDead.selected=false;
		this.appealAllianceCB.selected = false;
		this.appealFriendsCB.selected = false;
		isJoin = false;
	}
	
	/**
	 * 程序入口
	 */
	public function refreshFromMapTile(hero:HeroObj,d:MapTileData=null):void {
		this.returnInit();	
		this.curHero=hero;
		this.curSelectCastle=hero.castleObj;
		HeroHelper.instance.curSelectCastle=this.curSelectCastle;
		if(d==null){
			this.goToWar();
		}else{
			this.mapTileData = d;
			this.isJoin = mapTileData.isJoin;
			this.missionType=this.mapTileData.missionType;
			this.setMissionType(mapTileData);
			//是否是进攻行的任务
			this.isAttackMission = mapTileData.missionType != BattleConstants.ARMY_MISSION_REINFORCE&&mapTileData.missionType != BattleConstants.ARMY_MISSION_TRAINNING;
			this.checkCurMissonType(this.mapTileData.missionType);
		}
		this.reCalcTime();
	}
	
	

	
	private function onAssignBtnClick():void {
		HeroHelper.instance.curSelectHero=curHero;
		PopupWindows.openFuncWin(HerosMansionWin.WINDOW_SHOW_WEAVE);
	}
	
	/**
	 * 点击派兵
	 */ 
	private function onSendBtnClick():void {
		var n:String = mapTileData.fieldName+"[" + mapTileData.fieldX + "," + mapTileData.fieldY + "]";
		var m:String = BattleHelper.instance.getBattleMission(this.missionTypeCom.selectedItem.data);
		MyAlert.show(MultiLang.msg("military.whetherToGo.tip",n,m),sendTroops);
	}
	
	private function onSureLoot(event:Event):void{
		var n:String = mapTileData.fieldName+"[" + mapTileData.fieldX + "," + mapTileData.fieldY + "]";
		var m:String = BattleHelper.instance.getBattleMission(this.missionTypeCom.selectedItem.data);
		MyAlert1.instance.show(MultiLang.msg("military.whetherToGo.tip",n,m),call);
		
		function call():void{
		}
	}
	
	private function onStartLoot(event:Event):void{
		MyAlert1.instance.visible = false;
		sendTroops(true);
	}
	
	/**
	 * 判断是否可以出征 
	 * @return 
	 */	
	private function canNewArmy():Boolean{
		var type:String = getArmyType();
		var trainingField:BaseBuilding = curSelectCastle.buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_TRAINNINGS);
			//没有校场
		if(trainingField ==null){
			MyAlert.show(MultiLang.msg("military.not.trainingField.tip",type));
			return false;
			//自己是新手，可以出征野地，但不可以出征城市
		}else if(GameContext.instance.getPlayerObj().buffManager.getBuffById(BuffConstants.PLAYER_BEGINNER) !=null && this.mapTileData.isCastle){
			MyAlert.show(MultiLang.msg('military.own.novice.tip',MultiLang.msg("playInfo.buffFreshManStatus"),type));
			return false;
			//自己免战
		}else if(GameContext.instance.getPlayerObj().buffManager.getBuffById(BuffConstants.PLAYER_PEACE) !=null && this.mapTileData.isCastle){
			MyAlert.show(MultiLang.msg('military.own.novice.tip',MultiLang.msg("playInfo.peaceStatus"),type));
			return false;
			//玩家是否是新手
		}else if(this.mapTileData.status == PlayerConstant.PLAYER_STATUS_FRESH_MAN && this.mapTileData.isCastle){
			MyAlert.show(MultiLang.msg("military.player.novice.ceaseFire.tip",MultiLang.msg('chatType.beginner'),type));
			return false;
			//玩家是否是免战
		}else if(this.mapTileData.status== PlayerConstant.PLAYER_STATUS_FREE_OF_WAR && this.mapTileData.isCastle){
			MyAlert.show(MultiLang.msg("military.player.novice.ceaseFire.tip",MultiLang.msg('playInfo.peaceStatus'),type));	
			return false;	
			//是城市、是同盟、不是协防的情况
		}else if(this.mapTileData.isCastle && this.mapTileData.relation ==AllianceConstant.ALLIANCE_RELATION_SAME 
			&& this.mapTileData.hostRelation == AllianceConstant.ALLIANCE_RELATION_SAME 
			&& this.missionTypeCom.selectedItem.data !=BattleConstants.ARMY_MISSION_REINFORCE){
			MyAlert.show(MultiLang.msg("military.don't.newArmy.tip",MultiLang.msg('alliance.same'),type));
			return false;
			//是城市、是友盟、不是协防的情况
		}else if(this.mapTileData.isCastle && this.mapTileData.relation==AllianceConstant.ALLIANCE_RELATION_FRIENDLY
			&& this.mapTileData.hostRelation == AllianceConstant.ALLIANCE_RELATION_FRIENDLY 
			&& this.missionTypeCom.selectedItem.data !=BattleConstants.ARMY_MISSION_REINFORCE 
			&& !GameContext.instance.getPlayerObj().getCurCastleObj().conquestManager.isHost(this.mapTileData.hostPlayer)){
			MyAlert.show(MultiLang.msg("military.don't.newArmy.tip",MultiLang.msg('alliance.friendly'),type));
			return false;	
			//不能出征附庸城市、不是协防的情况
		}else if(this.mapTileData.hostPlayer == GameContext.instance.getPlayerObj().getPlayerInfo().playerName 
			&& this.missionTypeCom.selectedItem.data !=BattleConstants.ARMY_MISSION_REINFORCE 
			&& this.mapTileData.isCastle){
			MyAlert.show(MultiLang.msg("military.don't.newArmy.tip",MultiLang.msg('ranking.label.vassal'),type));
			return false;
		}
		
		return true;
	}
	
	private function getArmyType():String{
		var action:String= "";
		switch (this.missionTypeCom.selectedItem.data) {
			case BattleConstants.ARMY_MISSION_LOOT:
				return action = MultiLang.msg('military.mission.loot');
			case BattleConstants.ARMY_MISSION_CONQUEST:
				return action = MultiLang.msg('diplomacy.conquest.label');
			case BattleConstants.ARMY_MISSION_ATTACK:
				return action = MultiLang.msg('military.mission.attack');
			case BattleConstants.ARMY_MISSION_REINFORCE:
				return action = MultiLang.msg('military.mission.reinforce');
		}
		return "";
	}

	/**
	 * 派兵，建立战局,或派遣
	 */ 
	private function sendTroops(isTrue:Boolean):void{
		if(!isTrue) return;
		if(sendToMyCity()) return;
		if(checkBattle()) return;
	
		//判断可否出征
		if(!canNewArmy()) return ;
		
		if(isJoin == true){
			sendJoinBattle();
			return;
		}
		
		this.mapTileData.arrivedTime = moveNeedTime*1000;
		//伤亡率
		var lostLimit:int = 0;
		if (this.cb_lostLimit.selected && this.ti_lostLimit.text.length>0){
			lostLimit = int(this.ti_lostLimit.text);
		}
		log.debug("NewArmy.onSendBtnClick "+this.mapTileData.fieldX+" , "+this.mapTileData.fieldY);
		MainContainer.instance.risePlay(MultiLang.msg("military.sentTroop.success.tip"));
		if(missionTypeCom.selectedItem.data == BattleConstants.ARMY_MISSION_REINFORCE)
			// 派遣部队
			ControllerFactory.getInstance().getArmyController().createArmy(this.curHero.castleObj.cityId,this.curHero.heroInfo.id
				,lostLimit,this.cb_closeInAllDead.selected,this.cb_longDistanceAllDead.selected,
				GameContext.getFieldId(this.mapTileData.fieldX,this.mapTileData.fieldY),
				0,onNewArmyResponse,false);
		else{
			// 攻击建立战局
			ControllerFactory.getInstance().getArmyController().createWarField(this.curHero.castleObj.cityId,this.curHero.heroInfo.id
				,lostLimit,this.cb_closeInAllDead.selected,this.cb_longDistanceAllDead.selected,
				GameContext.getFieldId(this.mapTileData.fieldX,this.mapTileData.fieldY),missionTypeCom.selectedItem.data,
				0,onCreateWarResponse,false);
		}
	}
	
	private function onCreateWarResponse(event:CreateWarFieldResponse):void{
		if(!event.isSuccess()){
			MyAlert.showError(event);
		}else{
			MyAlert.show(MultiLang.msg('military.sendArmySuccess.tips'));
			if(appealAllianceCB.selected){
				// 通知联盟
				mapTileData.arrivedTime = event.arriveTime;
				mapTileData.missionType = missionTypeCom.selectedItem.data;
				mapTileData.battleId = event.battleId;
				EvtDispacther.instance.dispatchEvent(new TroopCampaignEvent(TroopCampaignEvent.TROOP_CAMPAIGN,mapTileData,ChatConstant.TYPE_ALLIANCE_CHAT));
			}
			if(appealFriendsCB.selected){
				// 通知好友
				mapTileData.battleId = event.battleId;
				mapTileData.missionType = missionTypeCom.selectedItem.data;
				mapTileData.arrivedTime = event.arriveTime;
				EvtDispacther.instance.dispatchEvent(new TroopCampaignEvent(TroopCampaignEvent.TROOP_CAMPAIGN,mapTileData,ChatConstant.TYPE_PRIVATE_CHAT));
			}
			PopupWindows.closeAll();
			refreshMap()
			this.addGoogleLog();
		}
	}
	
	/**
	 * 派兵到自己城，英雄可以不用带兵
	 */ 
	private function sendToMyCity():Boolean{
		var fId:int = GameContext.getFieldId(this.mapTileData.fieldX,this.mapTileData.fieldY);
		if(!GameContext.instance.getPlayerObj().isMyCity(fId)){
			return false;
		}
		var lostLimit:int = 0;
		if (this.cb_lostLimit.selected && this.ti_lostLimit.text.length>0){
			lostLimit = int(this.ti_lostLimit.text);
		}
		
		if(!isHasTrainingFeild()) return true;
				
		if(missionTypeCom.selectedItem.data == BattleConstants.ARMY_MISSION_REINFORCE && !isJoin){
			// 派遣部队
			ControllerFactory.getInstance().getArmyController().createArmy(this.curHero.castleObj.cityId,this.curHero.heroInfo.id
				,lostLimit,this.cb_closeInAllDead.selected,this.cb_longDistanceAllDead.selected,
				GameContext.getFieldId(this.mapTileData.fieldX,this.mapTileData.fieldY),
				0,onNewArmyResponse,false);
				return true;
		}
		else{return false;}
	}
	
	private function isHasTrainingFeild():Boolean{
		var trainingField:BaseBuilding = curSelectCastle.buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_TRAINNINGS);
			//没有校场
		if(trainingField ==null){
			MyAlert.show(MultiLang.msg("military.not.trainingField.tip",MultiLang.msg('military.mission.reinforce')));
			return false;
		}
		return true;	
	}
	
	/**
	 * 加入战局
	 */ 
	private function sendJoinBattle():void{
		if(this.curHero.armyManager.troopsArray.length<=0){
			MyAlert.show(MultiLang.msg('military.armyIsEmpty.desc'));
			return;
		}
		// 加入征服战也不需要考虑体力值
		if(this.curHero.heroInfo.strengthPoint<HeroManConstants.ARMY_ACTION_CONSUME_STRENGTH_POINT && missionTypeCom.selectedItem.data != BattleConstants.ARMY_MISSION_CONQUEST){
			MyAlert.show(MultiLang.msg("hero.strength.notEnough"));
			return;
		}
		var lostLimit:int = 0;
		log.debug("NewArmyWin.sendJoinBattle "+this.mapTileData.fieldX+" , "+this.mapTileData.fieldY);
		if (this.cb_lostLimit.selected && this.ti_lostLimit.text.length>0){
			lostLimit = int(this.ti_lostLimit.text);
		}
		
		if(missionTypeCom.selectedItem.data == BattleConstants.ARMY_MISSION_REINFORCE){
			ControllerFactory.getInstance().getArmyController().joinWarField(this.curHero.castleObj.cityId,curHero.heroInfo.id,
			lostLimit,this.cb_closeInAllDead.selected,this.cb_longDistanceAllDead.selected,
			GameContext.getFieldId(this.mapTileData.fieldX,this.mapTileData.fieldY),mapTileData.battleId,false
			,onJoinWarFieldResponse); 
		}else{
			ControllerFactory.getInstance().getArmyController().joinWarField(this.curHero.castleObj.cityId,curHero.heroInfo.id,
			lostLimit,this.cb_closeInAllDead.selected,this.cb_longDistanceAllDead.selected,
			GameContext.getFieldId(this.mapTileData.fieldX,this.mapTileData.fieldY),mapTileData.battleId,true
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
	
	/**
	 * 检查战斗条件(迁城冷却中，英雄没兵，英雄体力值，征服战不需要体力值)
	 */ 
	private function checkBattle():Boolean{
		if(GameContext.instance.getPlayerObj().getCurCastleObj().buffManager.getBuffById(BuffConstants.CASTLE_ADV_MOVE)!=null){
 			MyAlert.show(MultiLang.msg('buff.moveCity.coolDown'));
 			return true;
 		}
		if(this.curHero.troopStrength<=0){
			MyAlert.show(MultiLang.msg('military.armyIsEmpty.desc'));
			return true;
		}
		if(this.curHero.heroInfo.strengthPoint<HeroManConstants.ARMY_ACTION_CONSUME_STRENGTH_POINT && missionTypeCom.selectedItem.data != BattleConstants.ARMY_MISSION_CONQUEST&& missionTypeCom.selectedItem.data != BattleConstants.ARMY_MISSION_TRAINNING){
			MyAlert.show(MultiLang.msg("hero.strength.notEnough"));
			return true;
		}
		if(this.curHero.heroInfo.strengthPoint<this.mapTileData.heroPhysicalRequest  && missionTypeCom.selectedItem.data == BattleConstants.ARMY_MISSION_TRAINNING){
			MyAlert.show(MultiLang.msg("hero.strength.notEnough"));
			return true;
		}
		return false;
	}
	
	private function onNewArmyResponse(event:CommonResponse):void {
		if (!event.isSuccess()) {
			MyAlert.showError(event);
		} else {
			PopupWindows.closeAll();
			this.addGoogleLog();
		}
	}

	private function addGoogleLog():void {
		var action:String= "";
		switch (this.missionTypeCom.selectedItem.data) {
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
		}
		if (this.mapTileData.isCastle) {
			JavaScriptHelper.instance.trackEvent("militry", action, "player" , this.curHero.troopStrength);
		} else {
			JavaScriptHelper.instance.trackEvent("militry", action, this.mapTileData.fieldName , this.curHero.troopStrength);
		} 
	}
	
	
	/**
	 * 刷新地图
	 */ 
	private function refreshMap():void{
		DiamondWorldMap2.instance.sendCommandToServer();
	}
	
	private function onMisstionTypeChange(event:ListEvent):void {
		this.missionType=missionTypeCom.selectedItem.data;
		this.isAttackMission = (this.missionTypeCom.selectedItem.data != BattleConstants.ARMY_MISSION_REINFORCE);
		
		this.missionTypeComTip = BattleHelper.getMissionString(missionType);
	}
	
	private function checkCurMissonType(t:int):void{
		var find:Boolean=false;
		for(var i:int=0;i<missionTypeComData.length;i++){
			if (t == missionTypeComData[i].data){
				this.missionComIndex=i;
				find=true;
				break;
			}
		}
		if(!find){
			this.missionComIndex=0;
			this.missionType=missionTypeComData[0].data;
			this.isAttackMission = (missionTypeComData[0].data != BattleConstants.ARMY_MISSION_REINFORCE);
			this.missionTypeComTip = BattleHelper.getMissionString(missionType);
		}
		if(this.initialized){
			this.missionTypeCom.selectedIndex=this.missionComIndex;
		}
	}
	
	/**
	 * 重新计算移动需要时间
	 */
	private function reCalcTime(event:Event=null):void {
		if (this.curHero!=null&&this.mapTileData!=null) {
			var t:int = this.curHero.getMoveNeedTimeInSecond(this.mapTileData.fieldX , this.mapTileData.fieldY);
			if(!this.mapTileData.isCastle){
				this.moveNeedTime = Math.min(t,BattleConstants.MAX_BATTLE_PREPARE_TIME_HOURS*60*60);
			}else{
				var t1:int = Math.max(t,BattleConstants.MIN_BATTLE_PREPARE_TIME_MINUTES*60);
				this.moveNeedTime = Math.min(t1,BattleConstants.MAX_BATTLE_PREPARE_TIME_HOURS*60*60);
			}
			this.moveNeedTimeStr = MultiLang.timeFormatToString(this.moveNeedTime);
		} else {
			this.moveNeedTimeStr = "";
		}
	} 
	
	/**
	 * 查看可以选择什么行动
	 */ 
	private function setMissionType(data:MapTileData):void{
		if(data==null)return;
		trace("this.mapTileData.isCastle: "+this.mapTileData.isCastle);
		this.missionTypeComData.removeAll();
		if(data.missionType==BattleConstants.ARMY_MISSION_TRAINNING){
			this.missionTypeComData.addItem({label:MultiLang.msg("military.mission.manoeuvre"),data:BattleConstants.ARMY_MISSION_TRAINNING});
			this.missionTypeComTip = BattleHelper.getMissionString(missionType);
			return;
		}
		if(data.canAttack){
			if(data.isCastle){
				this.missionTypeComData.addItem({label:MultiLang.msg("diplomacy.conquest.label"),data:BattleConstants.ARMY_MISSION_CONQUEST});
			}else{
				this.missionTypeComData.addItem({label:MultiLang.msg('military.mission.attack'),data:BattleConstants.ARMY_MISSION_ATTACK});
			}
			this.missionTypeComData.addItem({label:MultiLang.msg("military.mission.loot"),data:BattleConstants.ARMY_MISSION_LOOT});
		}
		if(data.canReinforce){
			this.missionTypeComData.addItem({label:MultiLang.msg("military.mission.reinforce"),data:BattleConstants.ARMY_MISSION_REINFORCE});
		}
		this.missionTypeComTip = BattleHelper.getMissionString(missionType);
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
			this.mapTileData.fieldName = CastleObj(obj).name;
		}else{
			px = FieldCollectBean(obj).fieldId/10000;
			py = FieldCollectBean(obj).fieldId%10000;
			this.mapTileData.fieldName = FieldCollectBean(obj).remark;
		}  
		this.mapTileData.fieldX = px;
		this.mapTileData.fieldY = py;
		
		var curCastleId:int =curHero.castleObj.cityId;
		if(MapDataByteArray.instance.isTrainNpcCastle(px,py)||MapDataByteArray.instance.isRatterNpcCastle(px,py)){
			npcMapTileDataHandle();	
		}else{
			ControllerFactory.getInstance().getCommonController().mapFieldInfo(curCastleId,px,py,onResponse,false);	//需要判断是否是npc或普通野地	
		}
	}

	private function onResponse(event:MapFieldInfoResponse):void{
		if(event.isSuccess()){
			this.getMapTileDate(event.mapFieldInfoBean);
			if(mapTileData.missionType==BattleConstants.ARMY_MISSION_TRAINNING){
				if(GameContext.instance.getPlayerObj().isMyCity(GameContext.getFieldId(mapTileData.fieldX,mapTileData.fieldY))){
					mapTileData.missionType=BattleConstants.ARMY_MISSION_REINFORCE;
				}else{
					mapTileData.missionType=BattleConstants.ARMY_MISSION_LOOT;
				}
			}
			getMapTileDate(event.mapFieldInfoBean);
			refreshFromMapTile(curHero,mapTileData);
//			this.setMissionType(this.mapTileData);
//			this.reCalcTime();
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
	
	private function getMapTileDate(bean:MapFieldInfoBean):void {
		if(this.mapTileData==null){
			this.mapTileData=new MapTileData();
		}
		if(bean==null)return;
		this.mapTileData.status = bean.status;
		this.mapTileData.relation = bean.relation;
		this.mapTileData.hostRelation = bean.hostRelation;
		this.mapTileData.canAttack = bean.canAttack;
		this.mapTileData.hostPlayer = bean.hostPlayer;
		this.mapTileData.isCastle = MapDataByteArray.instance.getTileObj(this.mapTileData.fieldX,this.mapTileData.fieldY).isCastle();
		this.mapTileData.canReinforce = true;
	}
	
	private function getMapTileDateFromfaver(bean:FieldCollectBean):void {
		if(this.mapTileData==null){
			this.mapTileData=new MapTileData();
		}
		if(bean==null)return;
		this.mapTileData.fieldX =GameContext.getFieldPostionX(bean.fieldId);
		this.mapTileData.fieldY = GameContext.getFieldPostionY(bean.fieldId);
		this.mapTileData.fieldName = bean.remark;
		this.mapTileData.isCastle = MapDataByteArray.instance.getTileObj(this.mapTileData.fieldX,this.mapTileData.fieldY).isCastle();
	}
	
	private function npcMapTileDataHandle():void{
		if(this.mapTileData==null){
			this.mapTileData=new MapTileData();
		}
		this.mapTileData.relation = AllianceConstant.ALLIANCE_RELATION_HOSTILE;
		this.mapTileData.canAttack = true;
		this.mapTileData.scoutable = false;
		this.mapTileData.canTransport = false;
		this.mapTileData.canReinforce = false;
		this.mapTileData.isCastle = false;
		this.mapTileData.missionType=BattleConstants.ARMY_MISSION_TRAINNING;
		if(_bean!=null){
			this.mapTileData.fieldName = _bean.remark;
		}
		refreshFromMapTile(curHero,mapTileData);
	}
	

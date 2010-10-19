// as
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.BattleConstants;
	import roma.common.constants.BuffConstants;
	import roma.common.constants.BuildingConstant;
	import roma.common.constants.FieldConstant;
	import roma.common.constants.PlayerConstant;
	import roma.common.controller.CommonResponse;
	import roma.common.controller.common.MapFieldInfoResponse;
	import roma.common.valueObject.MapFieldInfoBean;
	import roma.common.valueObject.PlayerInfoDataBean;
	import roma.common.valueObject.RelatedCastleTimeBean;
	import roma.data.MapTileData;
	import roma.logic.GameContext;
	import roma.logic.object.buff.BaseBuffObj;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.object.field.BaseField;
	import roma.logic.object.field.FieldHelper;
	import roma.logic.object.hero.HeroObj;
	import roma.logic.object.player.OtherArmyObj;
	import roma.logic.object.player.PlayerObj;
	import roma.logic.object.tech.BaseTechObj;
	import roma.message.EvtDispacther;
	import roma.message.events.FavoriteEvent;
	import roma.message.events.WindowSwitchEvent;
	import roma.resource.ImgManager;
	import roma.util.MultiLang;
	
	import views.MainContainer;
	import views.PopupWindows;
	import views.mainFrame.ToggleButton;
	import views.mainModules.map.IMapTile;
	import views.mainModules.map.MapAddLabelHelper;
	import views.mainModules.map.diamond2.DiamondMapTile2;
	import views.mainModules.map.diamond2.DiamondWorldMap2;
	import views.mainModules.map.diamond2.TileHelper;
	import views.mainModules.map.diamond2.ZoneGenerator;
	import views.spreadUI.MyAlert;
	import views.spreadUI.castleIcon.CastleIconPanel;
	import views.spreadUI.favorite.FieldFavorite;
	import views.windows.buildings.market.MarketWin;
	import views.windows.functionWins.hero.HeroHelper;
	import views.windows.functionWins.hero.HerosMansionWin;
	import views.windows.functionWins.intelligence.IntelligenceWin;
	
	public static const WINDOW_SHOW:String = "castleInfoWin.show";
	private static var log:ILogger = Log.getLogger("views.mainModules.map.CastleInfoWin");	
	[Bindable]
	private var winTitle:String;
	[Bindable]
	private var positionStr:String = "";
	[Bindable]
	private var logoSource:*;

	[Bindable]
	private var isMyCurCastle:Boolean = false;
	[Bindable]
	private var isCastle:Boolean = false;            // 是城池，还是野地
	[Bindable]
	private var info:PlayerInfoDataBean;

	[Bindable]
	public var curSelectCastle:CastleObj;
	
	[Bindable]
	private var field_name:String;

	[Bindable]
	private var mapTile:DiamondMapTile2;
	[Bindable]
	private var iMapTile:IMapTile;
	[Bindable]
	private var zone:int;
	[Bindable]
	private var zoneName:String;
	[Bindable]
	private var curBuildingStr:String;
	[Bindable]
	private var curResearchStr:String;
	
	[Bindable]
	private var myMapFieldInfoBean:MapFieldInfoBean;//我的城池的MapFieldInfoBean
	[Bindable]
	private var castleStatusStr:String;
	[Bindable]
	private var thisPlaceName:String;
	
	[Bindable]
	private var mapTileData:MapTileData = new MapTileData();
	//盟军军队动态
	[Bindable]
	private var friendsArmyArray:ArrayCollection= new ArrayCollection();
	[Bindable]
	private var seizeArmyArray:ArrayCollection = new ArrayCollection();
	[Bindable]
	private var conquestArmyArray:ArrayCollection = new ArrayCollection();
	

	private var playerObj:PlayerObj = GameContext.instance.getPlayerObj();
	[Bindable]
	private var isInBattle:Boolean = false;
	
	[Bindable]
	private var fieldDis:String;//野地增产信息
	
	[Bindable]
	private var curCastle:CastleObj;
	
	[Bindable]
	private var belongCastleAddStr:String;
	
	[Bindable]
	private var distance:String;
	
	[Bindable]
	private var distanceTip:String;
	
	[Bindable]
	private var fieldBean:BaseField;
	
	[Bindable]
	private var canJoinBattle:Boolean=false;//能否加入战局
	
	[Bindable]
	private var isConstructing:Boolean;
	
	private function init():void{
		var maskSp:Sprite = new Sprite();
		maskSp.graphics.beginFill(0,0);
		maskSp.graphics.drawCircle(39,39,38);
		maskSp.graphics.endFill();
		this.playerLogo.addChild(maskSp);
		this.playerLogo.mask = maskSp;
		EvtDispacther.instance.addEventListener(EvtDispacther.HERO_STATUS_CHANGE, onArmyActionStatusChange);
		this.friendsArmyArray=GameContext.instance.getPlayerObj().otherArmyManager.getLeagueArmyArray();
		initClass();
	}
	private function onArmyActionStatusChange(event:Event):void{
		setSeizeArray();
	}
	/**
	 *每次界面弹出调用，刷新数据
	 */ 
	override public function refresh():void{
		this.friendsArmyArray=GameContext.instance.getPlayerObj().otherArmyManager.getLeagueArmyArray();
		isMyCurCastle = mapTile.idField == GameContext.instance.getPlayerObj().getCurCastleObj().idField;
		if(this.mapTile.getFieldType() == FieldConstant.TYPE_CITY){
			this.isConstructing = GameContext.instance.getPlayerObj().getCastleByFieldId(this.mapTile.idField).isConstructing();
		}else{
			this.isConstructing = false;
		}
		initClass();
	}

	/**
	 * 界面隐藏调用，停止当前窗体一切相关动画等
	 */ 
	override public function destroy():void{
		
	}
	
	private function initClass():void{
		if(this.initialized){
			setBtnUpState();
			if(isCastle){
				this.infoVS.selectedIndex = 0;
				infoVB.height = 285;
				this.conquestBtn.selected = true;
				troopViewStack.selectedIndex = 1;
			}
			else{
				this.infoVS.selectedIndex = 1;
				infoVB.height = 223;
				this.diplomacyBtn.selected = true;
				troopViewStack.selectedIndex = 0;
			}
			setSeizeArray();             		// 驻军情况,需要区分是城池宗主国的驻军还是野地自己玩家的驻军
		}
		
	}
	
	public function setMapTile(tile:IMapTile):void {
		this.mapTile=DiamondMapTile2(tile);

		this.zone=ZoneGenerator.getInstance().getZoneId(this.mapTile.idField);
		this.zoneName=TileHelper.getZoneName(this.zone);

		iMapTile = tile;
		isInBattle = mapTile.isInBattle;
		this.info=GameContext.instance.getPlayerObj().getPlayerInfo();
		if(mapTile.fieldType == FieldConstant.TYPE_CITY){
			this.isCastle = true;
			this.winTitle = mapTile.getMapCityBean().castleName+" [" + tile.getFieldX() + "," + tile.getFieldY() + "]";
			this.curSelectCastle=getCastleObj(tile);
			this.field_name = mapTile.getMapCityBean().castleName ;
			this.getCurBuilidngStr();
			this.getCurResearchStr();
			
			this.thisPlaceName=iMapTile.getMapCityBean().castleName+' '+MultiLang.msg('public.label.level')+" "+(iMapTile.getMapCityBean().expandLevel+1);
		}else{
			this.isCastle = false;
			this.logoSource=null;
			this.getMyWildBean(mapTile.idField);
		}
		
		/* mapTileData.fieldX = mapTile.getFieldX();
		mapTileData.fieldY = mapTile.getFieldY(); */
		this.canJoinBattle=this.mapTile.isInBattle;
		this.getMapTileDate();
		var myCastleId:int = GameContext.instance.getPlayerObj().getCurCastleObj().cityId;

		ControllerFactory.getInstance().getCommonController().mapFieldInfo(myCastleId,tile.getFieldX(),tile.getFieldY() , onMapResponse,false);	
	}
	
	private function onMapResponse(event:MapFieldInfoResponse):void {
		this.myMapFieldInfoBean=event.mapFieldInfoBean;
		
		this.canJoinBattle = event.mapFieldInfoBean.inBattle;
		if(this.isCastle){
			this.getCastleStatus(this.myMapFieldInfoBean);
		}
	}
	
	/**
	*检查是否为自己的城堡
	*/
	private function getCastleObj(tile:IMapTile):CastleObj{
		var targetCastle:CastleObj=null;
		var castleArr:Array=GameContext.instance.getPlayerObj().getAllCastle();
		for each(var castle:CastleObj in castleArr){
			if(castle.idField==tile.getMapCityBean().fieldId){
				targetCastle=castle;
			}
		}
		return targetCastle;
	}
	
	/**
	 * 运输
	 */
	private function newTransport():void {
		var building:BaseBuilding = this.getMarket(); 
		if (building!=null) {
			PopupWindows.openBuildingInfoWin(MarketWin.WINDOW_SHOW,building , this.mapTileData);
		}
	}
	
	/**
	 * 进入战局
	 */ 
	private function onGoinBattle():void{
		var o:Object = {};
		o["idField"] = this.mapTile.idField;
		PopupWindows.openFuncWin(IntelligenceWin.WINDOW_SHOW,o); 
	}
	
	/**
	 * 放弃野地
	 */ 
	private function giveUpSelfField():void{
		MyAlert.show(MultiLang.msg('field.giveUp.warm'),giveUp);
		function giveUp(isTrue:Boolean):void{
			if(isTrue){
				var fId:int = mapTileData.getFieldId();
				ControllerFactory.getInstance().getCityController().giveUpSelfField(GameContext.getFieldBelongCastleId(fId),fId,giveUpSelfFieldResponse);
			}
		}	
		function giveUpSelfFieldResponse(event:CommonResponse):void{
			if(event.isSuccess()){
				MainContainer.instance.risePlay(MultiLang.msg("townHall.giveUp.success"));
				EvtDispacther.instance.eventDispatch(WindowSwitchEvent.WINDOW_CLOSE_ID);
				DiamondWorldMap2.instance.setCenterToCurCastle();
			}else{MyAlert.showError(event);}
		}
	}
	
	private function getMarket():BaseBuilding {
		return GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_MARKET_BUILDING);	
	}
	
	/**
	 * 进入自己的城堡
	 */
	 private function getInMyCastle():void{
	 	if(this.iMapTile!=null){
	 		ToggleButton.instance.switchHandler(false);
	 		CastleIconPanel.instance.gotoTown(this.iMapTile.getMapCityBean().fieldId);
	 	}	
	 }
	 
	 /**
	 * 出征
	 */
	private function createArmy():void {
		/* this.mapTileData.missionType = BattleConstants.ARMY_MISSION_REINFORCE;
		PopupWindows.openFuncWin(GoingToWarWin.WINDOW_SHOW,mapTileData); */
		this.mapTileData.missionType = BattleConstants.ARMY_MISSION_REINFORCE;
		HeroHelper.instance.targetMapTileData=this.mapTileData;
		PopupWindows.openFuncWin(HerosMansionWin.WINDOW_SHOW_CAMPAIGN);
	}
	
	private function getMapTileDate():void {
		this.mapTileData.canAttack = false;
		this.mapTileData.scoutable = false;
		if(isCastle){
			this.mapTileData.canTransport = this.iMapTile.getMapCityBean().cityId==GameContext.instance.getPlayerObj().getCurCastleObj().cityId?false:true;
			this.mapTileData.canReinforce = this.iMapTile.getMapCityBean().cityId==GameContext.instance.getPlayerObj().getCurCastleObj().cityId?false:true;
		}else{
			this.mapTileData.canTransport = false;
			this.mapTileData.canReinforce = true;
		}
		this.mapTileData.fieldName = this.field_name;
		
		mapTileData.fieldX = mapTile.getFieldX();
		mapTileData.fieldY = mapTile.getFieldY(); 
	}
	
	/**
	 * 城池的建筑任务显示
	 */ 
	private function getCurBuilidngStr():void{
		var buffObj:BaseBuffObj = GameContext.instance.getPlayerObj().buffManager.getBuffById(BuffConstants.PLAYER_INCREASE_CONSTRUCT_LIMIT);
		var allBuilingArr:Array = curSelectCastle.buildingManager.getUnNormalBuilidngArr();
		if(buffObj !=null){
			this.curBuildingStr=allBuilingArr.length+"/"+3;
		}else{
			this.curBuildingStr=allBuilingArr.length+"/"+1;
		}				
	}
	
	/**
	 * 城池的科技任务显示
	 */ 
	private function getCurResearchStr():void{
		var startResearching:int=0;
		if(GameContext.instance.getPlayerObj().techManager.armyTechAry.length>0){				
			for each(var obj:BaseTechObj in GameContext.instance.getPlayerObj().techManager.armyTechAry){
				if(obj.startResearching&&obj.cityId==curSelectCastle.cityId){
					startResearching++;
				}
			}	
		}
		if(GameContext.instance.getPlayerObj().techManager.peopleTechAry.length>0){
			for each(var objP:BaseTechObj in GameContext.instance.getPlayerObj().techManager.peopleTechAry){
				if(objP.startResearching&&objP.cityId==curSelectCastle.cityId){
					startResearching++;
				}
			}	
		}
		var total:int=0;
		var buildingObject1:BaseBuilding=curSelectCastle.buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_MILITARY_INSTITUTE);
		var buildingObject2:BaseBuilding=curSelectCastle.buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_ACADEMY_BUILDING);
		if(buildingObject1!=null){
			total++;
		}
		if(buildingObject2!=null){
			total++;
		}
		this.curResearchStr=startResearching+"/"+total;
	}
	
	private function getCastleStatus(bean:MapFieldInfoBean):void{
		this.logoSource =ImgManager.clazz(bean.playerLogoUrl);
		
		switch(bean.status){
			case PlayerConstant.PLAYER_STATUS_NORMAL:
				this.castleStatusStr=MultiLang.msg("playInfo.buffNormalStatus");
			break;
			
			case PlayerConstant.PLAYER_STATUS_FRESH_MAN:
				this.castleStatusStr=MultiLang.msg("playInfo.buffFreshManStatus.short");
			break;
			
			case PlayerConstant.PLAYER_STATUS_FREE_OF_WAR:
				this.castleStatusStr=MultiLang.msg("playInfo.buffPeaceStatus");
			break;
			default:
			this.castleStatusStr=MultiLang.msg("playInfo.buffNormalStatus");
		}
	}
	//获取当前野地的bean
	private function getMyWildBean(idField:int):void{
		this.curCastle=GameContext.instance.getPlayerObj().getCurCastleObj();
		this.fieldBean=null;
		var fieldArr:ArrayCollection=GameContext.getAllField();
		var belongCastle:CastleObj = GameContext.instance.getPlayerObj().getCastleObjById(GameContext.getFieldBelongCastleId(idField));
		if(fieldArr.length>0){
			for each(var baseField:BaseField in fieldArr){
				if(baseField.idField==idField){
					this.fieldBean=baseField;
					this.winTitle = this.fieldBean.fieldName+" "+GameContext.getFieldPostionString(idField);
					this.positionStr = GameContext.getFieldPostionString(idField);
					this.field_name=this.fieldBean.fieldName;
					this.distance=this.curCastle.getDistanceToField(GameContext.getFieldPostionX(this.fieldBean.idField),GameContext.getFieldPostionY(this.fieldBean.idField)).toFixed(0);
					this.distanceTip=MultiLang.msg("field.distanceFromHere",GameContext.getFieldPostionX(GameContext.instance.getPlayerObj().getCurCastleObj().idField),GameContext.getFieldPostionY(GameContext.instance.getPlayerObj().getCurCastleObj().idField));
					this.fieldDis=FieldHelper.getFieldDesc(this.fieldBean.fieldType,this.fieldBean.fieldLevel);
					this.thisPlaceName=this.fieldBean.fieldName+' '+MultiLang.msg('public.label.level')+" "+this.fieldBean.fieldLevel;
					belongCastleAddStr=belongCastle.name+GameContext.getFieldPostionString(belongCastle.idField);
//					this.logoSource=FieldHelper.getFieldMapIcon(this.fieldBean.fieldType,this.fieldBean.fieldLevel);
					if(this.fieldBean.fieldType == FieldConstant.TYPE_TREES){
							this.logoSource = FieldHelper.getBitMap(FieldHelper.getFieldMapIcon(this.fieldBean.fieldType,this.fieldBean.fieldLevel));
						}else{
							this.logoSource = FieldHelper.getFieldMapIcon(this.fieldBean.fieldType,this.fieldBean.fieldLevel);
						}
					break;
				}
			}
		}
	}
	
	/**
	 * 遣返军队
	 */ 
	public function repatriate(obj:Object):void{
		var otherArmyObj:OtherArmyObj=OtherArmyObj(obj);
		ControllerFactory.getInstance().getArmyController().sendAllianceBack(
			GameContext.instance.getPlayerObj().getCurCastleObj().cityId,
			otherArmyObj.bean.heroInfo.id,
			onRepatriateResponse);
		function onRepatriateResponse(event:CommonResponse):void{
			if (!event.isSuccess()) {
				MyAlert.showError(event);
			}else{
				MainContainer.instance.risePlay(MultiLang.msg("hero.temper.repatriate.success.tips"));
			}
		} 
	}

	//召回军队
	public function recallArmy(obj:Object):void{
		var armyObj:HeroObj=HeroObj(obj);
		HeroHelper.instance.callbackHero(armyObj,onRecallResponse);
//		ControllerFactory.getInstance().getArmyController().reCallArmy(
//				armyObj.castle.cityId,armyObj.heroInfo.id,onRecallResponse);
		function onRecallResponse(event:CommonResponse):void{
			if (!event.isSuccess()) {
				MyAlert.showError(event);
			}else{
				MainContainer.instance.risePlay(MultiLang.msg("hero.temper.callBack.success.tips"));
			}
		}
	}
	
	private function setSeizeArray():void{
		this.seizeArmyArray.removeAll();
		this.conquestArmyArray.removeAll();
		this.friendsArmyArray.removeAll();
		if(isCastle){
			var host:RelatedCastleTimeBean = curSelectCastle.conquestManager.hostCastle;
			for each(var a:OtherArmyObj in GameContext.instance.getPlayerObj().otherArmyManager.otherArmyList){
				if(curSelectCastle.idField == a.bean.targetFieldId){
					if(a.bean.targetFieldId == mapTile.idField){
						if(host != null && a.bean.hostCastleArmy)
						conquestArmyArray.addItem(a);
						else
						friendsArmyArray.addItem(a);
					}
				}
			}
		}else{
			for each(var h:HeroObj in GameContext.instance.getPlayerObj().armyManager.allHerosGuard){
				if(h.heroInfo.targetFieldId == fieldBean.idField){
					seizeArmyArray.addItem(h);
				}
			}
			friendsArmyArray = GameContext.instance.getPlayerObj().otherArmyManager.getLeagueArmyArrayInField(fieldBean.idField);
		}
	}
	
	private function onMouseOver(event:MouseEvent):void{
		this.setBtnUpState();
		Button(event.target).selected = true;
		with(Button(event.target)){
			if(id == "diplomacyBtn"){
				this.troopViewStack.selectedIndex=0;
			}else if(id == "conquestBtn"){
				this.troopViewStack.selectedIndex=1;
			}
			else if(id == "reinforceBtn"){
				this.troopViewStack.selectedIndex=2;
				
			}
		}
		setSeizeArray();
	}
	private function setBtnUpState():void{
		this.diplomacyBtn.selected = false;
		this.reinforceBtn.selected = false;
		this.conquestBtn.selected = false;
	}
	
	private function showMenu(event:MouseEvent):void{
		if(this.fieldBean==null)return;
		MapAddLabelHelper.instance.showMenu(this,event,this.fieldBean.idField,this.field_name);
	}
	
	/**
	 * 增加到收藏夹
	 */
	private function addFavorite():void {
		FieldFavorite.instance.addListener();
		FavoriteEvent.addFavorite(FieldFavorite.ADD_FAVORITE,this.fieldBean.idField,this.field_name);
	}
			
	
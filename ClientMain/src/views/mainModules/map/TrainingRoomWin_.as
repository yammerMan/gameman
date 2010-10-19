
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.AllianceConstant;
	import roma.common.constants.FieldConstant;
	import roma.common.constants.TroopForConstants;
	import roma.common.controller.army.ScoutNpcFieldResponse;
	import roma.common.valueObject.HeroManBean;
	import roma.common.valueObject.MaterialBean;
	import roma.common.valueObject.NpcFieldBean;
	import roma.data.MapTileData;
	import roma.logic.GameContext;
	import roma.logic.object.field.FieldHelper;
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.ItemRule;
	import roma.message.events.FavoriteEvent;
	import roma.util.MultiLang;
	
	import views.PopupWindows;
	import views.mainModules.map.IMapTile;
	import views.mainModules.map.MapAddLabelHelper;
	import views.mainModules.map.diamond2.DiamondMapTile2;
	import views.mainModules.map.diamond2.TileHelper;
	import views.mainModules.map.diamond2.ZoneGenerator;
	import views.spreadUI.MyAlert;
	import views.spreadUI.army.NpcHeroArmyUI;
	import views.spreadUI.favorite.FieldFavorite;
	import views.spreadUI.tips.ToolTipContainer;
	import views.spreadUI.tips.TrainingRoomWarBtnTip;
	import views.windows.functionWins.hero.HeroHelper;
	import views.windows.functionWins.hero.HerosMansionWin;
	import views.windows.functionWins.intelligence.FieldBattleWin;
	import views.windows.functionWins.shop.ShopHelper;
		[Bindable]
	private var winTitle:String;
	
	[Bindable]
	private var logoSource:*;
	
	[Bindable]
	private var zoneName:String;
	
	[Bindable]
	private var titleName:String;
	
	[Bindable]
	private var heroPhysicalRequest:int;
	
	[Bindable]
	private var trainingRoomWarTip:String;
	
	[Bindable]
	private var positionStr:String;
	
	[Bindable]
	private var armyArr:ArrayCollection;
	
	[Bindable]
	private var mapTile:DiamondMapTile2;
	
	[Bindable]
	private var iMapTile:IMapTile;
	
	[Bindable]
	private var zone:int;
	
	[Bindable]
	private var isInBattle:Boolean = false;
	
	[Bindable]
	private var canJoinBattle:Boolean=false;//能否加入战局
	
	private var mapTileData:MapTileData = new MapTileData();
	
	[Bindable]
	private var npcBean:NpcFieldBean;
	
	[Bindable]
	private var heroLevel:int;
	
	[Bindable]
	private var heroName:String;
	
	[Bindable]
	private var _hero:HeroManBean;
	
	private var requestItemRule:ItemRule;
	
	private var requestMaterialBean:MaterialBean;
	
	private var troopInHero:Array = new Array();
	
	[Bindable]
	private var titleStyeleName:String;
	
	private var iHaveThisItem:MaterialBean;
	
	private var trainingRoomWarBtnTip:TrainingRoomWarBtnTip=ToolTipContainer.instance.trainingRoomWarBtnTip;
	
	[Bindable]
	private var mainContentTitle:String="";
	
	[Bindable]
	private var warTitle:String="";
	
	[Bindable]
	private var remainTimeRefresh:Number;
	
	public static const WINDOW_SHOW:String = "trainingRoomWin.show";
	private static var log:ILogger = Log.getLogger("views.mainModules.map.TrainingRoomWin");	
	
	private function init():void{
		var maskSp:Sprite = new Sprite();
		maskSp.graphics.beginFill(0,0);
		maskSp.graphics.drawCircle(39,39,38);
		maskSp.graphics.endFill();
		this.playerLogo.addChild(maskSp);
		this.playerLogo.mask = maskSp;
		this.initTroop();
	}
	
	
	public function setMapTile(tile:IMapTile):void{
		this.npcBean=null;
		this.mapTile=DiamondMapTile2(tile);

		this.zone=ZoneGenerator.getInstance().getZoneId(this.mapTile.idField);
		this.zoneName=TileHelper.getZoneName(this.zone);
		this.positionStr=this.positionStr = GameContext.getFieldPostionString(this.mapTile.idField);

		iMapTile = tile;
		isInBattle = mapTile.isInBattle;
		if(mapTile.fieldType == FieldConstant.TYPE_NPC_FIELD){
//			this.winTitle = mapTile.fieldType.toString();
			this.mainContentTitle=MultiLang.msg('trainingRoomWin.synopsisContent');
			this.warTitle=MultiLang.msg('trainingRoomWin.manoeuvreName');
			this.logoSource=FieldHelper.getFieldMapIcon(FieldConstant.TYPE_NPC_FIELD);
		}else if(mapTile.fieldType==14){
			this.mainContentTitle=MultiLang.msg('trainingRoomWin.quellContent');
			this.warTitle=MultiLang.msg('trainingRoomWin.quellManoeuvreName');
			this.logoSource=FieldHelper.getFieldMapIcon(14);
		}
		ControllerFactory.getInstance().getArmyController().scoutNpcField(GameContext.getFieldId(tile.getFieldX(),tile.getFieldY()),onMapResponse);
//		ControllerFactory.getInstance().getCommonController().mapFieldInfo(GameContext.instance.getPlayerObj().getCurCastleObj().cityId,tile.getFieldX(),tile.getFieldY() , onMapResponse,false);		
	}
	private function getMapTileDate():void {
//		this.mapTileData.status = this.status;
		this.mapTileData.relation = AllianceConstant.ALLIANCE_RELATION_HOSTILE;
		this.mapTileData.canAttack = true;
		this.mapTileData.scoutable = false;
		this.mapTileData.canTransport = false;
		this.mapTileData.canReinforce = false;
		this.mapTileData.fieldName = this.npcBean.fieldName;
//		this.mapTileData.hostPlayer = this.hostPlayer;
//		this.mapTileData.hostRelation = false;
		this.mapTileData.fieldX = this.mapTile.getFieldX();
		this.mapTileData.fieldY = this.mapTile.getFieldY();
		this.mapTileData.isCastle = false;
	}
	
	private function onMapResponse(event:ScoutNpcFieldResponse):void {
		if(event.isSuccess()){	
			this.npcBean=event.bean;
			initInfo();
		}
	}
	
	private function initInfo():void{
		this.trainingRoomWarTip="";
		if(this.npcBean==null) return;
//		var now:Number = new Date().valueOf();
//		var remain:Number = (this.npcBean.resetTime + GameContext.instance.getTimeDiff() - now)/1000 ;
		this.remainTimeRefresh=this.npcBean.resetTime;
		this.titleName=MultiLang.getPlayerTitle(this.npcBean.title);
		this.titleStyeleName=GameContext.instance.getPlayerObj().getPlayerInfo().title>=this.npcBean.title?"goodNoticeLabel":"NoticeLabel";
//		this.titleLabel.styleName=GameContext.instance.getPlayerObj().getPlayerInfo().titleId>=this.npcBean.title?"goodNoticeLabel":"NoticeLabel";
		this.heroPhysicalRequest=this.npcBean.requiredStr;
		this.heroLevel=this.npcBean.currNpc.heroMansArray.length>0?HeroManBean(this.npcBean.currNpc.heroMansArray[0]).heroInfo.level:0;
		this.heroName=this.npcBean.currNpc.heroMansArray.length>0?HeroManBean(this.npcBean.currNpc.heroMansArray[0]).heroInfo.name:"";
		this.armyArr=this.npcBean.currNpc.heroMansArray.length>0?HeroManBean(this.npcBean.currNpc.heroMansArray[0]).troopsArray:null;
		this._hero=this.npcBean.currNpc.heroMansArray.length>0?HeroManBean(this.npcBean.currNpc.heroMansArray[0]):null;
		if(this.npcBean.requiredItemsArray.length>0){
			requestMaterialBean=this.npcBean.requiredItemsArray[0];
			iHaveThisItem=ShopHelper.getMaterialBeanFromPlayer(MaterialBean(this.npcBean.requiredItemsArray[0]).id);
			requestItemRule = GameRuleHelper.instance.getItemRuleById(MaterialBean(this.npcBean.requiredItemsArray[0]).id);
			if(requestItemRule==null){
				return;
			}
			if(iHaveThisItem!=null){
				if(iHaveThisItem.count>=MaterialBean(this.npcBean.requiredItemsArray[0]).count){
					this.trainingRoomWarTip=MultiLang.msg("trainingRoomWin.addWarTip","<font color =\"#5f8c00\">"+MaterialBean(this.npcBean.requiredItemsArray[0]).count+"</font>","<font color =\"#5f8c00\">"+requestItemRule.name+"</font>");	
				}else{
					this.trainingRoomWarTip=MultiLang.msg("trainingRoomWin.addWarTip","<font color =\"#e60012\">"+MaterialBean(this.npcBean.requiredItemsArray[0]).count+"</font>","<font color =\"#5f8c00\">"+requestItemRule.name+"</font>");	
				}
			}else{
				this.trainingRoomWarTip=MultiLang.msg("trainingRoomWin.addWarTip","<font color =\"#e60012\">"+MaterialBean(this.npcBean.requiredItemsArray[0]).count+"</font>","<font color =\"#e60012\">"+requestItemRule.name+"</font>");	
			}
		}
		refreshTroop();
	}
	
	private function judgeItem():Boolean{
		var haveEnoughItem:Boolean=false;
		if(this.npcBean.requiredItemsArray.length>0){
			requestMaterialBean=this.npcBean.requiredItemsArray[0];
			iHaveThisItem=ShopHelper.getMaterialBeanFromPlayer(MaterialBean(this.npcBean.requiredItemsArray[0]).id);
			requestItemRule = GameRuleHelper.instance.getItemRuleById(MaterialBean(this.npcBean.requiredItemsArray[0]).id);
			if(iHaveThisItem!=null){
				if(iHaveThisItem.count>=MaterialBean(this.npcBean.requiredItemsArray[0]).count){
					haveEnoughItem=true;
				}else{
					haveEnoughItem=false;
				}
			}else{
				haveEnoughItem=false;	
			}
		}
		return haveEnoughItem;
	}
	
	/**
	 * 增加到收藏夹
	 */
	private function addFavorite():void {
		FieldFavorite.instance.addListener();				
		FavoriteEvent.addFavorite(FieldFavorite.ADD_FAVORITE,this.mapTile.idField,this.npcBean.fieldName);
	}
	
	
	/**
	 * 训练
	 */
	private function createArmy(mission:int):void {
		this.getMapTileDate();
		this.mapTileData.missionType = mission;
		this.mapTileData.heroPhysicalRequest=this.heroPhysicalRequest;
		//PopupWindows.openFuncWin(GoingToWarWin.WINDOW_SHOW,this.mapTileData);
		HeroHelper.instance.targetMapTileData=mapTileData;
		PopupWindows.openFuncWin(HerosMansionWin.WINDOW_SHOW_CAMPAIGN);
		this.visible = false;
	}
	
	private function addNpcWar():void{
		if(GameContext.instance.getPlayerObj().getPlayerInfo().title<this.npcBean.title){
			MyAlert.show(MultiLang.msg("military.anoeuvre.tip.titleNotReach",this.titleName));
			return;
		}
		if(!judgeItem()){
			MyAlert.show(MultiLang.msg("military.anoeuvre.tip.noItem",requestItemRule.name));
//			AlertWin.show(Lang.msg("military.anoeuvre.tip.noItem",requestItemRule.name,requestMaterialBean.count,(iHaveThisItem==null?0:iHaveThisItem.count),requestMaterialBean.count-(iHaveThisItem==null?0:iHaveThisItem.count)),buyItemItemToWar);
			return;
		}
		this.createArmy(BattleConstants.ARMY_MISSION_TRAINNING);
	}
	
	private function buyItemItemToWar(_true:Boolean):void{
		if(_true){
			var totalPrice:int =  MaterialBean(this.npcBean.requiredItemsArray[0]).count*requestItemRule.price;
			var curCoin:int = GameContext.instance.getPlayerObj().getPlayerInfo().coin;  					
			if (totalPrice > curCoin) {
  				MyAlert.show(MultiLang.msg("shop.msg.noEnoughCoin"),recharge,MultiLang.msg('systemMsg.getGold'));
  			} else {
  				this.createArmy(BattleConstants.ARMY_MISSION_TRAINNING);
  			}	
			
		}
	}
	
	private function recharge(_true:Boolean):void{
		if(_true){
			ClientMain.recharge();
		}
	}
	
	/**
	 * 加入战局
	 */ 
	private function goinBattle():void{
		if(GameContext.instance.getPlayerObj().getPlayerInfo().title<this.npcBean.title){
			MyAlert.show(MultiLang.msg("military.anoeuvre.tip.titleNotReach",this.titleName));
			return;
		}
		var o:Object = new Object();
		o.heroPhysicalRequest=this.heroPhysicalRequest;
		o.idField = GameContext.getFieldId(this.iMapTile.getFieldX(),this.iMapTile.getFieldY());
		PopupWindows.openFuncWin(FieldBattleWin.WINDOW_SHOW,o);
	}
	
	private function showMenu(event:MouseEvent):void{
		MapAddLabelHelper.instance.showMenu(this,event,this.mapTile.idField,this.npcBean.fieldName);
	}
	
	private function onMouseOver(event:MouseEvent):void {
		var isAddWar:Boolean=event.currentTarget==this.addWarBtn?true:false;
		this.trainingRoomWarBtnTip.setInfo(isAddWar,requestItemRule.itemId,this.npcBean.title,requestMaterialBean.count,heroPhysicalRequest);
		this.trainingRoomWarBtnTip.onMouseOver(event);
	}
	
	private function onMouseOut(event:MouseEvent):void {
		this.trainingRoomWarBtnTip.onMouseOut();
	}
	
	private function onMouseMove(event:MouseEvent):void {
		this.trainingRoomWarBtnTip.onMouseMove(event);
	}
	
	private function addTroop(type:int):void {
		var ui:NpcHeroArmyUI = new NpcHeroArmyUI();
		ui.troop = type;
		this.troopInHero.push(ui);
	}
	
	private function refreshTroop():void{
		for(var i:int=0;i<this.troopInHero.length;i++){
			var ui:NpcHeroArmyUI=this.troopInHero[i];
			if(this._hero!=null){
				ui.refresh(this.npcBean.currNpc.heroMansArray);
			}	
		}
	}
			
	private function initTroop():void{
		this.addTroop(TroopForConstants.T_TRIARII);
		this.addTroop(TroopForConstants.T_CAVALRY);
		this.addTroop(TroopForConstants.T_URBAN_COHORT);
		this.addTroop(TroopForConstants.T_ARCHERS);
		this.addTroop(TroopForConstants.T_BALLISTAS);
		this.addTroop(TroopForConstants.T_ONAGERS);
		for(var i:int=0;i<this.troopInHero.length;i++){
			var ui:NpcHeroArmyUI=this.troopInHero[i];
			if(this._hero!=null){
				ui.refresh(this.npcBean.currNpc.heroMansArray);
			}
			this.troop_container.addChild(ui);	
		}
	}
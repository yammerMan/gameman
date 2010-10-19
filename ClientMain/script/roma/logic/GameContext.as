package roma.logic
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.xml.XMLDocument;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.utils.XMLUtil;
	
	import roma.common.ResponseEvtDispatcher;
	import roma.common.constants.FieldConstant;
	import roma.common.constants.GeneralConstants;
	import roma.common.controller.report.MessageResponse;
	import roma.common.events.AllianceRelationEvent;
	import roma.common.events.ApplyBeConquestedCastleUpdate;
	import roma.common.events.BuildingUpdate;
	import roma.common.events.BusinessUpdate;
	import roma.common.events.CastleBuffUpdate;
	import roma.common.events.CastleInfoUpdate;
	import roma.common.events.CastleMilitaryUpdate;
	import roma.common.events.CastlePopulationUpdate;
	import roma.common.events.CityFieldUpdate;
	import roma.common.events.CityUpdate;
	import roma.common.events.ConquestCastleUpdate;
	import roma.common.events.CuredTroopUpdate;
	import roma.common.events.FieldCollectUpdate;
	import roma.common.events.FortiUpdate;
	import roma.common.events.FreeSentenceTimeUpdate;
	import roma.common.events.FriendRelationUpdate;
	import roma.common.events.HeroArmyUpdate;
	import roma.common.events.HeroBuffUpdate;
	import roma.common.events.HeroInfoUpdate;
	import roma.common.events.HeroManUpdate;
	import roma.common.events.HeroTroopUpdate;
	import roma.common.events.HostCastleUdpate;
	import roma.common.events.ManufactureQueueUpdate;
	import roma.common.events.MaterialUpdate;
	import roma.common.events.NewAnnounce;
	import roma.common.events.NewBattleMailUpdate;
	import roma.common.events.NewMailUpdate;
	import roma.common.events.NewQuestFinishedUpdate;
	import roma.common.events.NewRelatedBattleField;
	import roma.common.events.OtherArmyLeave;
	import roma.common.events.OtherArmyStatusUpdate;
	import roma.common.events.OtherArmyUpdate;
	import roma.common.events.PlayerBufferUpdate;
	import roma.common.events.PlayerInfoDataUpdate;
	import roma.common.events.PostTransportUpdate;
	import roma.common.events.ResourceMaterialUpdate;
	import roma.common.events.ScoutPlayerUpdate;
	import roma.common.events.ScoutUpdate;
	import roma.common.events.ServerInfoEvent;
	import roma.common.events.ServerItemEvent;
	import roma.common.events.TechUpdate;
	import roma.common.events.TransingBusinessUpdate;
	import roma.common.events.TransportUpdate;
	import roma.common.events.TroopManUpdate;
	import roma.common.events.WorkerTrainningUpdate;
	import roma.common.valueObject.DeleteItemBean;
	import roma.common.valueObject.ItemRuleBean;
	import roma.common.valueObject.TypeNpcIdsBean;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.object.field.BaseField;
	import roma.logic.object.hero.HeroObj;
	import roma.logic.object.player.ConquestObj;
	import roma.logic.object.player.PlayerObj;
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.ItemRule;
	import roma.message.EvtDispacther;
	import roma.message.events.DakChangeEvent;
	import roma.message.events.NewMailEvent;
	import roma.message.events.PublicEvent;
	import roma.message.events.QuestEvent;
	import roma.util.ConstructionDateFormatter;
	import roma.util.FacilityDateFormatter;
	import roma.util.MultiLang;
	import roma.util.MyDateFormatter;
	
	import views.MainContainer;
	import views.mainFrame.ChatPanel;
	import views.mainModules.map.diamond2.DiamondMapTile2;
	import views.mainModules.map.diamond2.MapDataByteArray;
	import views.windows.functionWins.hero.EquipHelper;
	
	
	public class GameContext
	{
		public static var log:ILogger = Log.getLogger("roma.logic.GameContext");

		public static var instance:GameContext = new GameContext();
		
		public var serverInfo:ServerInfoEvent;
		public var timeDis:Number = 0;
		
		private var playerObj:PlayerObj = new PlayerObj();
		
		private var screenShieldDictionary:Dictionary=new Dictionary();
		
		
		public function getPlayerObj():PlayerObj {
			return this.playerObj;
		}
		
		public function isScreenShield(playerName:String):Boolean{
			return screenShieldDictionary[playerName]==null?false:true;
		}
		
		public function setScreenShield(playerName:String):void{
			screenShieldDictionary[playerName]=playerName;
		}
		
		public function deleteScreenShield(playerName:String):void{
			screenShieldDictionary[playerName]=null;
		}
		
		public function getTimeDis():Number {
			return this.timeDis;
		}
		
		public static function getRemainTimeStr(endTime:Number):String {
			var now:Number = new Date().valueOf();
			var remain:Number = (endTime + instance.timeDis - now)/1000 ;
			if (remain>0) {
				return MultiLang.timeFormatToString(remain);
			} else {
				return "";
			}
		}
		
		private static var dataFormatter:MyDateFormatter ;
		private static var constructionDateFormatter:ConstructionDateFormatter ;
		private static var facilityDateFormatter:FacilityDateFormatter;
		public static function toLocalTimeStr(time:Number):String {
			if (dataFormatter ==null) {
				dataFormatter = new MyDateFormatter();
			}
			var d:Date = new Date(time + instance.getTimeDis());
			return dataFormatter.format(d);
		}
		
		public static function toConstructionLocalTimeStr(time:Number):String {
			if (constructionDateFormatter ==null) {
				constructionDateFormatter = new ConstructionDateFormatter();
			}
			var d:Date = new Date(time + instance.getTimeDis());
			return constructionDateFormatter.format(d);
		}
		
		/**
		 * 通过时间段获得时间
		 */ 
		public static function getTimeStrForSpace(time:Number):String{
			var now:Number = new Date().valueOf();
			var sTime:Number = now+time;
			var d:Date = new Date(sTime);
			if (dataFormatter ==null) {
				dataFormatter = new MyDateFormatter();
			}
				return dataFormatter.format(d);
		}
		//获取时间
		public static function toLocalTimeByValueStr(time:Number):String {
			if (dataFormatter ==null) {
				dataFormatter = new MyDateFormatter();
			}
			var d:Date = new Date(time);
			return dataFormatter.format(d);
		}
		//获得简易显示的时间
		public static function toLocalFacilityTimeStr(time:Number):String {
			if (facilityDateFormatter ==null) {
				facilityDateFormatter = new FacilityDateFormatter();
			}
			var d:Date = new Date(time + instance.getTimeDis());
			return facilityDateFormatter.format(d);
		}
		//获取当前小时数
		public static function getCurHour(time:Number):Number{
			var d:Date = new Date(time + instance.getTimeDis());
			return d.hours;
		}

		public static function getFieldX(x:int):int {
			var x1:int = x  % FieldConstant.MAP_SIZE;
			if (x1<0) {
				x1 += FieldConstant.MAP_SIZE;
			}
			return x1;
		}
		
		public static function getFieldY(y:int):int {
			var y1:int = y  % FieldConstant.MAP_SIZE;
			if (y1<0) {
				y1 += FieldConstant.MAP_SIZE;
			}
			return y1;
		}

		public static function getFieldId(x:int , y:int):int {
			return getFieldX(x) * 10000 + getFieldY(y);
		}
		
		/** 判断是否已在联盟 */
		public static function judgeHaveAlliance():Boolean
		{
			var haveAlliance:Boolean=false;
			if (instance.getPlayerObj().getPlayerInfo().leagueName!=null && instance.getPlayerObj().getPlayerInfo().leagueName!=""){
				haveAlliance=true;
			}
			return haveAlliance;
		}
		
		/** 获取所有附庸城*/
		public static function getAllConquestCity():ArrayCollection{
			var allCity:ArrayCollection=new ArrayCollection();
			for each(var castle:CastleObj in GameContext.instance.getPlayerObj().getAllCastle()){
				if(castle.conquestManager.conquestCastleArray.length>0){
					for each(var c:ConquestObj in castle.conquestManager.conquestCastleArray){
						allCity.addItem(c);
					}
				}
			}
			return allCity;
		}
		
		/** 获取所有我的野地*/
		public static function getAllField():ArrayCollection{
			var allField:ArrayCollection=new ArrayCollection();
			for each(var castle:CastleObj in GameContext.instance.getPlayerObj().getAllCastle()){
				if(castle.fieldManager.fieldObjArray.length>0){
					for each(var baseField:BaseField in castle.fieldManager.fieldObjArray){
						allField.addItem(baseField);
					}
				}
			}
			return allField;
		}
		
		
		/** 获取我的野地所属于的城Id*/
		public static function getFieldBelongCastleId(idField:int):int{
			var cityId:int=0;
			var found:Boolean=false;
			for each(var castle:CastleObj in GameContext.instance.getPlayerObj().getAllCastle()){
				if(found){
					break;
				}
				for each(var baseField:BaseField in castle.fieldManager.fieldObjArray){
					if(idField==baseField.idField){
						cityId=castle.cityId;
						found=true;
						break;
					}
				}
				
			}
			return cityId;
		}

		public static function isCastleByFieldId(idField:int):Boolean{
			var fx:int = getFieldPostionX(idField);
			var fy:int = getFieldPostionY(idField);
			
			var tile:DiamondMapTile2 = MapDataByteArray.instance.getTileObj(fx,fy);
			if(tile == null)return false;
			else{
				return tile.fieldType == FieldConstant.TYPE_CITY;
			}
		}

		/**
		 * 获得两个地方的距离
		 */
		public static function getDistance(x1:int,y1:int , x2:int, y2:int):Number {
			var dx:int = Math.abs(x1 - x2) % (FieldConstant.MAP_SIZE);
			if (dx > FieldConstant.MAP_SIZE/2) {
				dx = FieldConstant.MAP_SIZE - dx;
			}
			var dy:int = Math.abs(y1 - y2) % (FieldConstant.MAP_SIZE);
			if (dy > FieldConstant.MAP_SIZE/2) {
				dy = FieldConstant.MAP_SIZE - dy;
			}
			
			return Math.sqrt(Math.pow(dx,2) + Math.pow(dy,2)) * FieldConstant.DISTANCE_PER_UNIT ;
		}

		public static function getFieldPostionString(idField:int):String {
			var x:int = idField / 10000;
			var y:int = idField % 10000;
			return "[" + x + "," + y + "]";
		}
		
		public static function getFieldPostionX(idField:int):int {
			return idField / 10000;
		}
		
		public static function getFieldPostionY(idField:int):int {
			return idField % 10000;
		}

		public function GameContext(){
			log.debug("instance");
			//建立监听
			var rd:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
			rd.onBuildingUpdate = onBuildingUpdate;
			rd.onCityFieldUpdate = onCastleFieldChange;
			rd.onCastleInfoUpdate = onCastleInfoUpdate;
			rd.onCastlePopulationUpdate = onCastlePopulationUpdate;
			rd.onCityUpdate = onCastleNumUpdate;
			rd.onFortiUpdate = onFortiUpdate;
			rd.onHeroArmyUpdate = onHeroArmyUpdate;
			rd.onHeroTroopUpdate = onHeroTroopUpdate;
			rd.onHeroBuffUpdate = onHeroBuffUpdate;
			rd.onHeroInfoUpdate = onHeroInfoUpdate;
			rd.onHeroManUpdate = onHeroManUpdate;
			rd.onMaterialUpdate = onItemNumUpdate;
			rd.onNewMailUpdate = onNewMailUpdate;
			rd.onNewBattleMailUpdate = onNewBattleMailUpdate;
			rd.onNewMessageEvent = onMessageResponse;
			rd.onOtherArmyUpdate = onOtherArmyUpdate;
			rd.onOtherArmyLeave = onOtherArmyLeave;
			rd.onOtherArmyStatusUpdate = onOtherArmyStatusChange;
			rd.onPlayerBufferUpdate = onPlayerBuffNumUpdate;
			rd.onPlayerInfoDataUpdate = onPlayerDataUpdate;
			rd.onResourceMaterialUpdate = onResourcesUpdate;
			rd.onScoutUpdate = onScoutUpdate;
			rd.onServerInfoEvent = onServerInfoEventHandle;
			rd.onTechUpdate = onTechUpdate;
			rd.onBusinessUpdate = onTradeUpdate;
			rd.onTransingBusinessUpdate = onTranTradeUpdate;
			rd.onTransportUpdate = onTransportUpdate;
			rd.onTroopManUpdate = onTroopManUpdate;
			rd.onManufactureQueueUpdate = onManufactureQueueUpdate;
			rd.onCastleBuffUpdate = onCastleBuffUpdate;
			rd.onNewQuestFinishedUpdate = onNewQuestFinishedUpdate;
			rd.onPostTransportUpdate = onPostTransportUpdate;
			rd.onWorkerTrainningUpdate = onWorkerTrainningUpdate;
			rd.onFriendRelationUpdate= onFriendRelationUpdate;
			rd.onFieldCollectUpdate = onFieldCollectUpdate;
			rd.onFreeSentenceTimeUpdate = onFreeSentenceTimeUpdatep;
			rd.onScoutPlayerUpdate=onScoutPlayerUpdate;
			rd.onCuredTroopUpdate=onCuredTroopUpdate;
			rd.onCastleMilitaryUpdate=onCastleMilitaryUpdate;
			rd.onConquestCastleUpdate = onConquestCastleUpdate;
			rd.onHostCastleUdpate = onHostCastleUdpate;
			rd.onApplyBeConquestedCastleUpdate = onApplyBeConquestedCastleUpdate;
			rd.onNewRelatedBattleField = onNewRelatedBattleField;

			rd.onNewAnnounce = onNewAnnounceUpdate;
			rd.onAllianceRelationEvent=onAllianceRelationUpdate;
			rd.onServerItemEvent=onServerItemEventHandle;
			
		}
		
		private var oldTrainNpcCastleAry:ArrayCollection;
		
		private var oldRatterNpcCastleAry:ArrayCollection;
		
		public var ratterNpcCastleAry:ArrayCollection;
		
		public var  serverTimeDiff:Number = 0;
		/**
		 * 处理服务器信息
		 */
		private function onServerInfoEventHandle(event:ServerInfoEvent):void {
			serverInfo = event;
			
			var now:Number = new Date().valueOf(); 

			//计算服务器和本地的时间差值
			var serverTime:Date = MyDateFormatter.parseDateString1(event.currentTimeStr);
			this.serverTimeDiff =  now - serverTime.valueOf(); 

			timeDis = now - event.currentTime;
			
			updateNpcCastle(event);
			updateHeroEuips(event);
		} 
		
		
		public var trainNpcCastleAry:ArrayCollection;
		/**
		 * 处理物品变动信息
		 */
		private function onServerItemEventHandle(event:ServerItemEvent):void{
			GameRuleHelper.instance.resetItemArray();
			if(event.removeItemsArray.length>0){
				for each(var removeItem:DeleteItemBean in event.removeItemsArray){
					var targetRemoveItemRule:ItemRule=GameRuleHelper.instance.getItemRuleById(removeItem.itemId);
					if(targetRemoveItemRule==null){
						continue;
					}
					
					GameRuleHelper.instance.modifyItemMap(targetRemoveItemRule,true,removeItem.deletePlayerItem);
				}
			}
			if(event.updateItemsArray.length>0){
				for each(var modifyItemRuleBean:ItemRuleBean in event.updateItemsArray){
					var targetItemRule:ItemRule=GameRuleHelper.instance.getItemRuleById(modifyItemRuleBean.id);
					if(targetItemRule==null){
						continue;
					}
					if(modifyItemRuleBean.changeType!=-1){
					
					}
					if(modifyItemRuleBean.funcDesc!=null){
						targetItemRule.funcDesc=modifyItemRuleBean.funcDesc;
					}
					
					if(modifyItemRuleBean.iconUrl!=null){
						targetItemRule.itemIcon=modifyItemRuleBean.iconUrl;
					}
					
					if(modifyItemRuleBean.itemDesc!=null){
						targetItemRule.itemDesc=modifyItemRuleBean.itemDesc;
					}
					
					if(modifyItemRuleBean.price!=-1){
						targetItemRule.price=modifyItemRuleBean.price;
					}
					
					if(modifyItemRuleBean.sort!=-1){
						
					}
					
					if(modifyItemRuleBean.type!=-1){
							targetItemRule.itemType=modifyItemRuleBean.type;
					}
					
					GameRuleHelper.instance.modifyItemRule(targetItemRule);
				}
			}
			EvtDispacther.instance.dispatchEvent(new Event(EvtDispacther.ITEMRULE_CHANGE));
		}
		
		
		/**
		 * 更新英雄装备
		 * 
		 */		
		private function updateHeroEuips(event:ServerInfoEvent):void{
			EquipHelper.instance.setHeroEuips(event.equipsArray);
		}
		
		
		/**
		 * 更新训练场
		 * @param event
		 * 
		 */		
		private function updateNpcCastle(event:ServerInfoEvent):void{
			trainNpcCastleAry=null;
			ratterNpcCastleAry=null;
			var map:Dictionary = new Dictionary();
			var mapR:Dictionary = new Dictionary();
			if(event.typeNpcIdsArray.length>0){
				for(var k:int=0;k<event.typeNpcIdsArray.length;k++){
					var tempTypeNpcIdsBean:TypeNpcIdsBean=event.typeNpcIdsArray[k];
					if(tempTypeNpcIdsBean.type==13){
						var arr:ArrayCollection = tempTypeNpcIdsBean.npcFieldIdsArray;
						trainNpcCastleAry = tempTypeNpcIdsBean.npcFieldIdsArray;
						
						if(this.oldTrainNpcCastleAry !=null){
							for(var n:int=0;n<oldTrainNpcCastleAry.length;n++){
								var oldFid:int = oldTrainNpcCastleAry.getItemAt(n) as int;
								for(var f:int=0;f<arr.length;f++){
									var newFid:int =arr.getItemAt(f) as int;
									if(oldFid != newFid && f>=arr.length-1){
										MapDataByteArray.instance.cleanNpcCastle(oldFid);
									}else{
										continue;
									}
								}
							}
						}
						
						
						for(var i:int=0;i<arr.length;i++){
							var key:int = arr.getItemAt(i) as int;
							map[key] = key;
						}
						
						MapDataByteArray.instance.trainNpcMap = map;
						
						oldTrainNpcCastleAry = tempTypeNpcIdsBean.npcFieldIdsArray;
						
						map =null;
						if(tempTypeNpcIdsBean.npcFieldIdsArray.length>0){
							EvtDispacther.sendEvent(EvtDispacther.NPC_ADD_CHANGE,tempTypeNpcIdsBean);
						}
					}
					
					if(tempTypeNpcIdsBean.type==14){
						var arrR:ArrayCollection = tempTypeNpcIdsBean.npcFieldIdsArray;
						ratterNpcCastleAry = tempTypeNpcIdsBean.npcFieldIdsArray;
						
						if(this.oldRatterNpcCastleAry !=null){
							for(var nr:int=0;nr<oldRatterNpcCastleAry.length;nr++){
								var oldFidr:int = oldRatterNpcCastleAry.getItemAt(nr) as int;
								for(var fr:int=0;fr<arrR.length;fr++){
									var newFidr:int =arrR.getItemAt(fr) as int;
									if(oldFidr != newFidr && fr>=arrR.length-1){
										MapDataByteArray.instance.cleanNpcCastle(oldFidr);
									}else{
										continue;
									}
								}
							}
						}
						
						
						for(var ir:int=0;ir<arrR.length;ir++){
							var keyR:int = arrR.getItemAt(ir) as int;
							mapR[keyR] = keyR;
						}
						
						MapDataByteArray.instance.ratterNpcMap = mapR;
						
						oldRatterNpcCastleAry = tempTypeNpcIdsBean.npcFieldIdsArray;
						
						mapR =null;
						if(tempTypeNpcIdsBean.npcFieldIdsArray.length>0){
							EvtDispacther.sendEvent(EvtDispacther.NPC_ADD_CHANGE,tempTypeNpcIdsBean);
						}						
					}
					
				}
			}
			 if(trainNpcCastleAry==null){
				if(this.oldTrainNpcCastleAry !=null){
					for(var nt:int=0;nt<oldTrainNpcCastleAry.length;nt++){
							MapDataByteArray.instance.cleanNpcCastle(int(oldTrainNpcCastleAry.getItemAt(nt)));
					}
					MapDataByteArray.instance.trainNpcMap = map;
				}
			}
			if(ratterNpcCastleAry==null){
				if(this.oldRatterNpcCastleAry !=null){
					for(var nra:int=0;nra<oldRatterNpcCastleAry.length;nra++){
							MapDataByteArray.instance.cleanNpcCastle(int(oldRatterNpcCastleAry.getItemAt(nra)));
					}
					MapDataByteArray.instance.ratterNpcMap = mapR;
				}
			} 
		}
		
		/**
		 * 处理建筑状态更新
		 */
		private function onBuildingUpdate(event:BuildingUpdate):void {
			//找到对应的城堡
			var castleObj:CastleObj = this.playerObj.getCastleObjById(event.cityId); 
			if (castleObj!=null) {
				//将建筑的内容更新到城堡
				castleObj.buildingManager.updateBuilding(event);
			}
		}
		
		/**
		 * 资源更新 ResourceMaterialUpdate
		 */
		private function onResourcesUpdate(event:ResourceMaterialUpdate):void {
			var castleObj:CastleObj = this.playerObj.getCastleObjById(event.cityId);
			if (castleObj!=null) {
				castleObj.resourceManager.setCityResourceBean(event.castleResource);
			}
			
			updateTimeDiff(event);
		}
		
		private function updateTimeDiff(event:ResourceMaterialUpdate):void{
			var now:Number = new Date().valueOf(); 
			timeDis = now - event.serverTime;
		}
		
		/**
		 * 人口更新 CastlePopulationUpdate
		 */
		private function onCastlePopulationUpdate(event:CastlePopulationUpdate):void {
			var castleObj:CastleObj = this.playerObj.getCastleObjById(event.cityId);
			if (castleObj!=null) {
				castleObj.resourceManager.setCastlePopulation(event.cityPopu);
			}
		}
		
		/** 城堡信息更新 */
		private function onCastleInfoUpdate(event:CastleInfoUpdate):void {
			var castle:CastleObj = this.playerObj.getCastleObjById(event.castleInfo.id);
			castle.setCastleInfoBean(event.castleInfo);
			this.playerObj.updateSelfCastleMap();
		}
		
		/** 城堡野地更新 */
		private function onCastleFieldChange(event:CityFieldUpdate):void{
			var castle:CastleObj = this.playerObj.getCastleObjById(event.cityId);
			if (castle!=null) {
				castle.fieldManager.updateField(event);
				EvtDispacther.sendEvent(EvtDispacther.FIELD_NUM_CHANGE);
			}
			this.playerObj.updateSelfCastleMap();
		}
		
		/** 城堡增加或者修改 */
		private function onCastleNumUpdate(event:CityUpdate):void {
			this.playerObj.updateCastle(event);
			EvtDispacther.instance.dispatchEvent(new Event(EvtDispacther.CASTLE_ADD_OR_REMOVE));
		}
		
		/** 城堡的驿站更新 */
		private function onPostTransportUpdate(event:PostTransportUpdate):void{
			this.playerObj.dakManager.refreshDak(event);
			EvtDispacther.instance.dispatchEvent(new DakChangeEvent(DakChangeEvent.EVENT_NAME));				
		}
		
		
		/** 好友列表更新 */
		private function onFriendRelationUpdate(event:FriendRelationUpdate):void{	
			GameContext.instance.playerObj.playerRelationManager.updatePlayerRelation(event);
		}
		
		/** 间谍列表更新 */
		private function onScoutPlayerUpdate(event:ScoutPlayerUpdate):void{	
			GameContext.instance.playerObj.scoutPlayerManager.updateScoutPlayer(event);
		}
		
		/** 城堡 城防更新*/
		private function onFortiUpdate(event:FortiUpdate):void {
			var castle:CastleObj = this.playerObj.getCastleObjById(event.cityId);
			if (castle!=null) {
				castle.troopManager.updateFortification(event);
			}
		}
		
		
		/** 英雄的整只部队更新 */
		private function onHeroArmyUpdate(event:HeroArmyUpdate):void {
			var castle:CastleObj = this.playerObj.getCastleObjById(event.cityId);
			if (castle!=null) {
				var hero:HeroObj = castle.heroManager.getBeanById(event.heroManId);
				if (hero!=null) {
					hero.armyManager.updateArmy(event.troopsArray, event.retreatCondition);
					hero.reCalcTroopStrength();
				}
			}			
			EvtDispacther.sendEvent(EvtDispacther.HERO_ARMY_CHANGE, event.heroManId);
		}
		
		private function onHeroTroopUpdate(event:HeroTroopUpdate):void {
			var castle:CastleObj = this.playerObj.getCastleObjById(event.cityId);
			if (castle!=null) {
				var hero:HeroObj = castle.heroManager.getBeanById(event.heroManId);
				if (hero!=null) {
					hero.armyManager.updateTroop(event.troop);
					hero.reCalcTroopStrength();
				}
			}			
						
			EvtDispacther.sendEvent(EvtDispacther.HERO_ARMY_CHANGE, event.heroManId);
		}
		
		/** 英雄buff更新 */
		private function onHeroBuffUpdate(event:HeroBuffUpdate):void {
			var castle:CastleObj = this.playerObj.getCastleObjById(event.cityId);
			if (castle!=null) {
				var hero:HeroObj = castle.heroManager.getBeanById(event.heroManId);
				if (hero!=null) {
					hero.buffManager.updateBuff(event.updateType , event.buff);
					hero.afterBuffUpdate();
					EvtDispacther.sendEvent(EvtDispacther.HERO_BUFF_CHANGE,hero);
				}
			}
		}
		 
		/** 英雄信息更新 */
		private function onHeroInfoUpdate(event:HeroInfoUpdate):void {
			var castle:CastleObj = this.playerObj.getCastleObjById(event.cityId);
			if (castle!=null) {
				var hero:HeroObj = castle.heroManager.getBeanById(event.heroInfo.id);
				if (hero!=null) {
					hero.updateHeroInfo(event.heroInfo);
					EvtDispacther.sendEvent(EvtDispacther.HERO_STATUS_CHANGE,hero);
				}
			}
		}
		
		/**
		 * 英雄更新，增减英雄
		 */  
		private function onHeroManUpdate(event:HeroManUpdate):void{
			var castle:CastleObj = this.playerObj.getCastleObjById(event.cityId);
			if (castle!=null) {
				castle.heroManager.heroUpdate(event);
				if (event.cityId == this.playerObj.getCurCastleObj().cityId) {
					EvtDispacther.sendEvent(EvtDispacther.HERO_NUM_CHUANGE);
				}
			}
		}
		
		/** 物品更新 */
		private function onItemNumUpdate(event:MaterialUpdate):void {
			this.playerObj.itemManager.updateItem(event.item);
		}
		
		/** 有新邮件 */
		private function onNewMailUpdate(event:NewMailUpdate):void {
			this.playerObj.counter.newMailCounter=event.newMailCount;
			EvtDispacther.instance.dispatchEvent(new NewMailEvent(NewMailEvent.NEW_MAIL));
		}
		
		/** 有新战报 */
		private function onNewBattleMailUpdate(event:NewBattleMailUpdate):void{
			this.playerObj.counter.newBattleMailCounter=event.newBattleReportCount;
			EvtDispacther.instance.dispatchEvent(new NewMailEvent(NewMailEvent.NEW_MAIL));
		}
		
		/** 有新情报 */
		private function onMessageResponse(event:MessageResponse):void {
			//TODO			
		}
		
		/**
		 * 其他城的军队更新
		 */
		private function onOtherArmyUpdate(event:OtherArmyUpdate):void {
			playerObj.otherArmyManager.onOtherArmyUpdate(event);
		}

		/**
		 * 其他城的军队离开更新
		 */
		private function onOtherArmyLeave(event:OtherArmyLeave):void {
			playerObj.otherArmyManager.onOtherArmyLeave(event);
		}
		
		/**
		 * 其他城的军队状态更新
		 */
		private function onOtherArmyStatusChange(event:OtherArmyStatusUpdate):void {
			playerObj.otherArmyManager.onOtherArmyStatusUpdate(event);
		}

		
		/** 玩家buff */
		private function onPlayerBuffNumUpdate(event:PlayerBufferUpdate):void {
			this.playerObj.buffManager.updateBuff(event.updateType , event.buffBean);
			EvtDispacther.instance.dispatchEvent(new Event(EvtDispacther.PLAYER_BUFF_CHANGE));
		}

		/**
		 * 更新城池buff 
		 * @param event
		 */
		private function onCastleBuffUpdate(event:CastleBuffUpdate):void{
			var castle:CastleObj = this.playerObj.getCastleObjById(event.castleId);
			if (castle!=null){
				trace("GameContext:onCastleBuffUpdate castle=" + castle + " buffType=" + event.buff.typeId);
				castle.buffManager.updateBuff(event.updateType,event.buff);
				EvtDispacther.instance.dispatchEvent(new Event(EvtDispacther.CASTLE_BUFF_UPDATE));
			}
		}
		/**
		 * 有任务完成的更新
		 */ 
		private function onNewQuestFinishedUpdate(event:NewQuestFinishedUpdate):void{
			EvtDispacther.instance.dispatchEvent(new QuestEvent(QuestEvent.HAS_EVENT_FINISHED,true));
		}
		
		/**
		 * 处理玩家信息更新
		 */
		private function onPlayerDataUpdate(event:PlayerInfoDataUpdate):void {
			this.playerObj.updatePlayerInfo(event.playerInfo);
		}
		
		/**
		 * 处理侦察行动更新
		 */
		private function onScoutUpdate(event:ScoutUpdate):void {
			this.playerObj.armyManager.updateScoutTeam(event);
			EvtDispacther.sendEvent(EvtDispacther.SCOUTS_CHANGE);
		}
		
		/** 科技更新 */
		private function onTechUpdate(event:TechUpdate):void {
			this.playerObj.techManager.updateTech(event);
		}
		
		/** 交易更新 */
		private function onTradeUpdate(event:BusinessUpdate):void {
			var castle:CastleObj = this.playerObj.getCastleObjById(event.cityId);
			if (castle!=null) {
				castle.tradeManager.updateTrade(event);
			}
		}
		
		/** 交易运输 */
		private function onTranTradeUpdate(event:TransingBusinessUpdate):void {
			var castle:CastleObj = this.playerObj.getCastleObjById(event.cityId);
			if (castle!=null) {
				castle.tradeManager.updateTransingTrade(event);
			}
		}
		
		/**
		 * 市场运输
		 */ 
		private function onTransportUpdate(event:TransportUpdate):void{
			log.debug("onTransportUpdate == "+event);
			var castle:CastleObj = this.playerObj.getCastleObjById(event.cityId);
			if(castle != null){
				castle.tradeManager.updateTransport(event);
			}
		}
		
		/** 城堡军队 */
		private function onTroopManUpdate(event:TroopManUpdate):void {
			var castle:CastleObj = this.playerObj.getCastleObjById(event.castleId);
			if (castle!=null) {
				castle.troopManager.updateTroop(event);
			}
			
		}

		/**更新生产队列*/
		private function onManufactureQueueUpdate(event:ManufactureQueueUpdate):void{
			var castle:CastleObj = this.playerObj.getCastleObjById(event.cityId);
			if (castle!=null) {
				castle.produceQueueManager.updateProduceQueue(event);
			}
		}
		
		/**工人生产更新*/
		private function onWorkerTrainningUpdate(event:WorkerTrainningUpdate):void{
			var castle:CastleObj = this.playerObj.getCastleObjById(event.cityId);
			if(castle !=null){
				castle.workerTrainningManager.workerTrainningUpdate(event);
			}
		}
		
		/**野地收藏夹更新*/
		private function onFieldCollectUpdate(event:FieldCollectUpdate):void{
			this.playerObj.favoriteManager.updateFieldFavorite(event);
			EvtDispacther.instance.dispatchEvent(new Event(EvtDispacther.FIELD_FAVOTITE_UPDATE));			
		}
		
		/** 聊天允许免费的时间更新  */
		private function onFreeSentenceTimeUpdatep(event:FreeSentenceTimeUpdate):void{
			EvtDispacther.instance.dispatchEvent(new PublicEvent(EvtDispacther.FREE_CENTENCE_TIME,event));
		}
		
		/**
		 * 处理伤兵更新事件
		 */
		private function onCuredTroopUpdate(event:CuredTroopUpdate):void {	
			this.getPlayerObj().getCastleObjById(event.cityId).injuredTroopManager.updateInjuredTroop(event);
		} 
		
		/**
		 * 处理是否允许盟友驻扎、出城迎战的更新事件
		 */
		private function onCastleMilitaryUpdate(event:CastleMilitaryUpdate):void {	
			this.getPlayerObj().getCastleObjById(event.cityId).castleMilitaryManager.updateCastleMilitary(event);
		} 
		
		/**
		 * 所有的公告通知
		 */		
		private function onNewAnnounceUpdate(event:NewAnnounce):void{
			//RaffleUtil.analyzeRaffleXml(event.announceStr);
			if (event.msgType == GeneralConstants.SYSTEM_MESSAGE_TYPE_CHAT) {
				EvtDispacther.sendEvent(EvtDispacther.NEW_SYSTEM_MSG , event.announceStr);
			} else {
				var targetXml:XMLDocument = XMLUtil.createXMLDocument(event.announceStr);
				if(targetXml.firstChild.nodeName=="gag"){
					EvtDispacther.sendEvent(EvtDispacther.GM_FORBID_TALK,event.announceStr);
				}else if(targetXml.firstChild.nodeName=="roletteResult" && targetXml.firstChild.attributes.level == 1){
					EvtDispacther.sendEvent(EvtDispacther.TURNTABLE_RAFFLE_NOTICE,event.announceStr);
				}else if(targetXml.firstChild.nodeName=="allianceEvent"){
					MainContainer.instance.risePlay(targetXml.firstChild.attributes.xmlStr); 
				}else if(targetXml.firstChild.nodeName == "hostBeAttack"){
					// 宗主国被打的公告
					EvtDispacther.sendEvent(EvtDispacther.SYS_HOST_BEATTACK,event.announceStr);
				}else if(targetXml.firstChild.nodeName == "AnnounceData"){
					if(targetXml.firstChild.firstChild.nodeName == "winNpc"){
						EvtDispacther.sendEvent(EvtDispacther.TRAINROOM_REPORT,event.announceStr);
					}
					if(targetXml.firstChild.firstChild.nodeName == "reportTitle"){
						EvtDispacther.sendEvent(EvtDispacther.SYS_ANNOUNCE_REPORT,event.announceStr);
					}
				}
				else{
//					MsgDispacther.sendEvent()
				}
			}
		}
		
		//更改联盟关系
		private function onAllianceRelationUpdate(event:AllianceRelationEvent):void{
			ChatPanel.instance.showNoitceToWorldAndAlliance(event);
//			MsgDispacther.instance.dispatchEvent(new ChatCallEvent(ChatCallEvent.TYPE_WORLD,str));
//			MsgDispacther.instance.dispatchEvent(new ChatCallEvent(ChatCallEvent.TYPE_ALLIANCE,str));
		}

		/**
		 * 申请附属列表更新，更新到指定城池
		 */ 
		private function onApplyBeConquestedCastleUpdate(event:ApplyBeConquestedCastleUpdate):void{
			var castle:CastleObj = this.playerObj.getCastleObjById(event.cityId);
			if(castle != null){
				castle.conquestManager.updateApplyBeConquested(castle,event);
			}
		}
		
		/**
		 * 征服列表更新
		 */
		private function onConquestCastleUpdate(event:ConquestCastleUpdate):void{
			var castle:CastleObj = this.playerObj.getCastleObjById(event.cityId);
			if(castle != null){
				castle.conquestManager.updateConqust(castle,event);
			}
		}
		
		/**
		 * 宗主国的更新
		 */
		 private function onHostCastleUdpate(event:HostCastleUdpate):void{
		 	var castle:CastleObj = this.playerObj.getCastleObjById(event.cityId);
			if(castle != null){
				castle.conquestManager.conquestHostUpdate(event.hostCastle);
			}
		 }
		 
		 /**
		 * 战局有变化更新
		 */ 
		 private function onNewRelatedBattleField(event:NewRelatedBattleField):void{
		 	this.playerObj.battleFieldManager.hasModify(true);
		 }
		 
	}
}
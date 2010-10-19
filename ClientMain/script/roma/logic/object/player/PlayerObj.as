package roma.logic.object.player
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.net.SharedObject;
	import flash.utils.Dictionary;
	
	import roma.common.constants.BuffConstants;
	import roma.common.constants.BuildingConstant;
	import roma.common.constants.GeneralConstants;
	import roma.common.events.CityUpdate;
	import roma.common.valueObject.CityBean;
	import roma.common.valueObject.CounterBean;
	import roma.common.valueObject.PlayerDataBean;
	import roma.common.valueObject.PlayerInfoDataBean;
	import roma.logic.GameContext;
	import roma.logic.object.buff.BaseBuffObj;
	import roma.logic.object.buff.BuffResManager;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.object.castle.DakManager;
	import roma.logic.object.field.BaseField;
	import roma.logic.object.hero.HeroObj;
	import roma.message.EvtDispacther;
	import roma.util.MultiLang;
	
	import views.PopupWindows;
	import views.mainModules.map.FlagPlayer;
	import views.mainModules.map.diamond2.MapDataByteArray;
	import views.spreadUI.favorite.FieldSkip;
	
	public class PlayerObj
	{
		private var playerInfo:PlayerInfoDataBean;
		
		private var actCastle:CastleObj;
		
		public var castelArray:Array = new Array();
		
		public var buffManager:BuffResManager;
		
		public var itemManager:ItemResManager;
		
		public var techManager:TechManager;
		
		public var dakManager:DakManager;
		
		public var counter:CounterBean;
		
		public var otherArmyManager:OtherArmyManager;
		
		public var armyManager:ArmyManager;
		
		public var playerRelationManager:PlayerRelationManager;
		
		public var scoutPlayerManager:ScoutPlayerManager;
		
		public var favoriteManager:FavoriteManager;

		public var myFlagPlayerBitmapData:BitmapData;

		private static var COOKIE_CASTLEID:String = "cookie_castleid";
		
		/** 战局变化 */
		public var battleFieldManager:BattleFieldManager;
		
		public function PlayerObj()	{
		}
		
		/**
		 * 初始化
		 */
		public function init(bean:PlayerDataBean):void {
			MapDataByteArray.instance.setCastleByteArray(bean.castleMapByteArray);
			this.playerInfo = bean.playerInfo;
			this.buffManager = new BuffResManager(bean.buffersArray);
			this.itemManager = new ItemResManager(bean.itemsArray);
			this.techManager = new TechManager(bean.techsArray);
			this.castelArray = new Array();
			this.dakManager = new DakManager(bean.postTransportsArray);
			this.otherArmyManager = new OtherArmyManager(bean.otherArmysArray); 
			this.playerRelationManager=new PlayerRelationManager(bean.blocksArray,bean.friendsArray);
			this.favoriteManager = new FavoriteManager(bean.fieldCollectBeansArray);	
			this.scoutPlayerManager=new ScoutPlayerManager(bean.scoutPlayersArray);
			this.battleFieldManager = new BattleFieldManager();
			this.counter=bean.counter;	
			this.actCastle = null;

			//生成城堡对象，并找到id最小的城堡
			for each (var castleBean:CityBean in  bean.citysArray) {
				this.addCastle(castleBean);
			}

			var sortOnCastleId:Function = function(c1:CastleObj, c2:CastleObj):Number {
				return c2.cityId - c1.cityId;
			}
			this.castelArray.sort(sortOnCastleId);
			
			this.findCurCastle();
			
			this.updateSelfCastleMap();
			
			this.setMyFlagPlayer();
			
			this.armyManager = new ArmyManager();
		}
		
		private function findCurCastle():void{
			//当前城堡为id最小的城堡
			var minId:int = -1;
			var castle:CastleObj;
			for each (var obj:CastleObj in  this.castelArray) {
				
				if (minId<0 || minId > obj.cityId) {
					minId = obj.cityId;
					castle = obj;
				}
			}
			
			var sharedObject:SharedObject = SharedObject.getLocal(COOKIE_CASTLEID);
			if(sharedObject.data.cityId !=null && this.getCastleObjById(sharedObject.data.cityId) !=null){
				this.actCastle = this.getCastleObjById(sharedObject.data.cityId);
			}else{
				this.actCastle = castle;
			}		
		}
		
		private function addCastle(castleBean:CityBean):void {
			var castleObj:CastleObj = new CastleObj(castleBean);
			this.castelArray.unshift(castleObj);
		}
		
		public function getCityCount():int {
			return this.castelArray.length;
		}
		
		public function getAllCastle():Array {
			return this.castelArray;
		}
				
		public function changeCurCastle(cityId:int):void {
			var castleObj:CastleObj = this.getCastleObjById(cityId);
			if (castleObj!=null) {
				this.actCastle = castleObj;
				
				PopupWindows.closeAll();
				EvtDispacther.sendEvent(EvtDispacther.CUR_CASTLE_CHANGE_EVENT);
				//显示当前城野地坐标
				FieldSkip.instance.setCoordinate(castleObj.idField/10000,castleObj.idField%10000);

				//把当前城id存入cookie,玩家下次进入游戏首先进入的是该城
				var sharedObject:SharedObject = SharedObject.getLocal(COOKIE_CASTLEID);
				sharedObject.data.cityId = castleObj.cityId;
				sharedObject.flush();
			}
		}
		
		/**
		 *判断当前城的建筑进程是否满了 
		 * @return 
		 * 
		 */
		public function isConstructingFull():Boolean{
			var buffObj:BaseBuffObj = this.buffManager.getBuffById(BuffConstants.PLAYER_INCREASE_CONSTRUCT_LIMIT);
			if(buffObj !=null){
				if(this.actCastle.buildingManager.getUnNormalBuilidngArr().length>=BuildingConstant.AFTER_INCREASE_CONSTRUCT_LIMIT){
					return true;
				}else{
					return false;
				}
			}else{
				if(this.actCastle.buildingManager.getUnNormalBuilidngArr().length>=BuildingConstant.NORMAL_CONSTRUCT_LIMIT){
					return true;
				}else{
					return false;
				}
			}
		}
		
		/**
		 * 更新城堡，如果是增加，就 有castleBean，如果是删除，就只有cityId
		 */
		public function updateCastle(event:CityUpdate):void {
			if (event.updateType == GeneralConstants.UPDATE_ADD_TYPE ) {
				//增加
				this.addCastle(event.castle)
			} else {
				for (var i:int=0; i<this.castelArray.length; i++ ) {
					if (CastleObj(this.castelArray[i]).cityId == event.cityId ) {
						this.castelArray.splice(i,1);
						break;
					}
				}
			}
			
			if (event.cityId == actCastle.cityId){
				findCurCastle();

				PopupWindows.closeAll();
				EvtDispacther.sendEvent(EvtDispacther.CUR_CASTLE_CHANGE_EVENT);
			}
			
			this.updateSelfCastleMap();
		}
		
		/**
		 * 当前界面显示的城堡
		 */
		public function getCurCastleObj():CastleObj {
			return this.actCastle;
		}

		public function getCastleObjById(id:int):CastleObj {
			for each(var c:CastleObj in this.castelArray) {
				if (c.cityId == id) {
					return c;
				}
			}
			return null;
		}
		
		public function getPlayerInfo():PlayerInfoDataBean {
			return this.playerInfo;
		}

		public function getTitleName():String {
			return MultiLang.getPlayerTitle(this.playerInfo.title);
		}
		
		public function getCanOwnCastle():int{
			if(this.playerInfo.title<=9){
				return this.playerInfo.title+1;
			}
			return this.playerInfo.title;
		}
		
		public function hasAlliance():Boolean {
			return (this.playerInfo.leagueName!=null);
		}
		
		/**
		 * 更新playerInfo
		 */
		public function updatePlayerInfo(bean:PlayerInfoDataBean):void {
			bean.copyToBe(this.playerInfo);
			EvtDispacther.instance.dispatchEvent(new Event(EvtDispacther.PLAYER_INFO_UPDATE_EVENT));
			this.setMyFlagPlayer();
		}
		
		private function setMyFlagPlayer():void {
			this.myFlagPlayerBitmapData = FlagPlayer.getFlagTextBitmapData(this.playerInfo.flag);
		}
		
		private var selfCastleMap:Dictionary = new Dictionary();
		private var selfResourceFieldMap:Dictionary = new Dictionary();
		public function getCastleByFieldId(idField:int):CastleObj {
			var res:CastleObj = CastleObj(this.selfCastleMap[idField]);
			return res;
		}
		
		public function isSelfResourceField(idField:int):Boolean {
			if (this.selfResourceFieldMap[idField]) {
				return true;
			} else {
				return false;
			}
		}
		
		public function updateSelfCastleMap():void {
			this.selfCastleMap = new Dictionary();
			this.selfResourceFieldMap = new Dictionary();
			
			for each (var castle:CastleObj in this.castelArray) {
				this.selfCastleMap[castle.idField] = castle;
				
				for each (var fieldObj:BaseField in castle.fieldManager.fieldObjArray) {
					this.selfResourceFieldMap[fieldObj.idField] = fieldObj;
				}
			}
		}
		
		/**
		 * 通过id是否为自己的城市
		 */
		public function isMyCity(fId:int):Boolean{
			var isTrue:Boolean = false;
			var allCastle:Array = GameContext.instance.getPlayerObj().getAllCastle();
			for each(var a:CastleObj in allCastle){
				isTrue = a.idField == fId;
				if(isTrue)break;
			}
			return isTrue;
		}
		
		/**
		 * 野地是否为你自己的野地或是城池
		 */ 
		public function isYourField(id:int):Boolean{
			var isTrue:Boolean = false;
			for each(var c:CastleObj in this.castelArray){
				if(c.idField == id){
					isTrue = true;
					break;
				}else{
					for each(var f:BaseField in c.fieldManager.fieldObjArray){
						if(f.idField == id){
							isTrue = true;
							break;
						}
					}
				}
			}
			return isTrue;
		}
	}
}
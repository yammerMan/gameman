package roma.logic.object.castle
{
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.constants.BuffConstants;
	import roma.common.constants.BuildingConstant;
	import roma.common.constants.HeroManConstants;
	import roma.common.constants.TempleConstant;
	import roma.common.valueObject.CityBean;
	import roma.common.valueObject.CastleInfoBean;
	import roma.logic.GameContext;
	import roma.logic.object.buff.BuffResManager;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.object.building.impl.Academy;
	import roma.logic.object.building.impl.Barrack;
	import roma.logic.object.building.impl.MilitaryInstitute;
	import roma.logic.object.building.impl.Stable;
	import roma.logic.object.building.impl.Temple;
	import roma.logic.object.building.impl.Workshop;
	import roma.logic.object.hero.HeroObj;
	import roma.logic.object.player.CastleMilitaryManager;
	import roma.logic.object.player.InjuredTroopManager;
	import roma.logic.object.tech.BaseTechObj;
	import roma.logic.rule.TechRule;
	import roma.logic.rule.ruleCheck.RuleCheckResult;
	import roma.resource.ImgManager;
	
	
	[Bindable]
	public class CastleObj
	{
		private static var log:ILogger = Log.getLogger("roma.logic.object.CastleObj");
		
		/** 野地的id */
		public var idField:int;

		/** 野地的坐标 */
		public var fieldPositionStr:String;

		/** 城堡id */
		public var cityId:int;

		/** 名字 */
		public var name:String;

		/** 状态 */
		public var status:int;
		
		public var logoUrl:String;

		/** 当前城的神 */
		public var godType:int;

		/** 城池等级*/
		public var level:int;
		
		/** 图标 */
		public var logoClass:String;
		
		/** 资源管理模块 */
		public var resourceManager:CastleResourceManager;

		/** BUFF管理模块 */
		public var buffManager:BuffResManager;
		
		/** 建筑管理模块 */
		public var buildingManager:CastleBuildingManager;
		
		/** 野地管理 */
		public var fieldManager:FieldManager;
		
		/** 英雄管理 */
		public var heroManager:HeroManager;
		
		/** 市场交易管理 */
		public var tradeManager:TradeManager;
		
		/** 部队管理 */
		public var troopManager:TroopManager;
		
		/** 是否允许出城，盟军驻扎管理 */
		public var castleMilitaryManager:CastleMilitaryManager;
		
		/** 伤兵管理 */
		public var injuredTroopManager:InjuredTroopManager;
		
		public var produceQueueManager:ProduceQueueManager;
		
		public var workerTrainningManager:WorkerTrainningManager;
		
		/** 侦察部队 */
		public var scoutsBeanArray:ArrayCollection;
		
		/** 提出申请的时间  */
		public var applyBeConquestTime:Number;

		public var conquestManager:ConquestManager;
		
		public function CastleObj(bean:CityBean){
			log.debug("CastleObj.newInstance. id=" + bean.castleInfo.id);
			this.setCastleInfoBean( bean.castleInfo);
			this.buildingManager = new CastleBuildingManager(this, bean.architecturesArray);
			this.buffManager = new BuffResManager(bean.buffersArray);
			this.fieldManager = new FieldManager(this , bean.fieldsArray);
			this.heroManager = new HeroManager(this , bean.heroMansArray);
			this.tradeManager = new TradeManager(this, bean.businessesArray , bean.transingTradesArray,bean.transportsArray);
			this.troopManager = new TroopManager(this , bean.troopsArray , bean.fortificationsArray);
			this.produceQueueManager = new ProduceQueueManager(this,bean.produceQueuesArray);
			this.resourceManager = new CastleResourceManager(this, bean.castleResource , bean.castlePopulation);
			this.injuredTroopManager=new InjuredTroopManager(bean.castleInfo.id,bean.goldForCureInjuredTroopArray,bean.injuredTroopsArray);
			this.castleMilitaryManager=new CastleMilitaryManager(bean.castleInfo.id,bean.militaryBean);
			this.workerTrainningManager = new WorkerTrainningManager(bean.workerTrainningBean);
			this.scoutsBeanArray = bean.scoutsArray;
			
			if(bean.hostCastle !=null)
				applyBeConquestTime = bean.hostCastle.time;
				
			this.conquestManager = new ConquestManager(bean.castleInfo.id,bean.hostCastle,bean.conquestCastlesArray,bean.applyBeConquestCastlesArray);
			
		}
		
		public function setCastleInfoBean(bean:CastleInfoBean):void {
			this.idField = bean.fieldId;
			this.cityId = bean.id;
			this.name = bean.name;
			this.status = bean.status;
			this.logoUrl = bean.logoUrl;
			this.godType = bean.godType;
			this.level = bean.level;
			this.logoClass = ImgManager.clazz("logo.city.a1");

			var cx:int = this.idField / 10000;
			var cy:int = this.idField % 10000;
			this.fieldPositionStr = "["+cx + "," + cy+"]";
		}
		
		public function getCityId():int {
			return this.cityId;
		}
		
		public function isConstructing():Boolean {
			return this.buffManager.getBuffById(BuffConstants.CASTLE_CONSTRUCTING) !=null;
		}
		
		/**
		 * 根据科技加成、各类状态、城市的对建筑时间进行加成
		 */
		public function effectBuildingTime(result:RuleCheckResult):void {
			var accPre:Number = this.buildingManager.getTownHall().getTownnHallBuildingAccPer();
			var temple:Temple =Temple(this.buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_TEMPLE));
			if(temple !=null && this.godType == TempleConstant.JUPITER_GOD){
				//受官府与朱庇特神影响
				result.needTime = result.needTime *(1- accPre)*(1-temple.getTempleGodaccPer());
			}else{
				//只受官府影响
				result.needTime = result.needTime *(1- accPre);
			}
		}
		
		/**
		 * 学院或者大学影响科技研究时间
		 */ 
		 public function effectTechTime(result:RuleCheckResult):void{
			var accPer:Number;
		 	var rule:TechRule =TechRule(result.getRule());
 			var i:int = rule.techKey.indexOf(".");
			var typeId:String = rule.techKey.substring(0,i);
		 	var techObj:BaseTechObj = GameContext.instance.getPlayerObj().techManager.getTechObjById(int(typeId));
		 	
		 	//判断科技类型
		 	if(techObj.techKind == BuildingConstant.TYPE_ACADEMY_BUILDING ){
		 		var academy:Academy = Academy(this.buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_ACADEMY_BUILDING));
		 		if(academy !=null){
			 		accPer =academy.getAcademyAccPer();
		 		}
		 	}else if(techObj.techKind == BuildingConstant.TYPE_MILITARY_INSTITUTE){
		 		var militaryInstitute:MilitaryInstitute =MilitaryInstitute(this.buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_MILITARY_INSTITUTE));
		 		if(militaryInstitute !=null){
			 		accPer =militaryInstitute.getMilitaryAccPer();
		 		}
		 	}

		 	result.needTime = result.needTime*(1-accPer);
		 }
		
		/**
		 * 影响兵种或者武器生产时间
		 */ 
		public function effectTroopProduceTime(result:RuleCheckResult,buildingObj:BaseBuilding):void{
			var accPer:Number;
			var temple:Temple =Temple(this.buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_TEMPLE));
			if(buildingObj !=null){
				if(this.buildingManager.getBuildingObjAtPosition(buildingObj.position) !=null){
					if(buildingObj.typeId == BuildingConstant.TYPE_BARRACKS){
						accPer = Barrack(this.buildingManager.getBuildingObjAtPosition(buildingObj.position)).getbarrackAccPer();	
					}else if(buildingObj.typeId == BuildingConstant.TYPE_STABLES){
						accPer = Stable(this.buildingManager.getBuildingObjAtPosition(buildingObj.position)).getStableAccPer();	
					}else if(buildingObj.typeId == BuildingConstant.TYPE_WORKSHOPS){
						accPer = Workshop(this.buildingManager.getBuildingObjAtPosition(buildingObj.position)).getWorkShopAccPer();	
					}
				}
			}
			
			//判断是否有神的加成
			if(temple !=null && this.godType == TempleConstant.MARS_GOD){
			 	result.needTime = result.needTime*(1-accPer)*(1-temple.getTempleGodaccPer());
			}else{
			 	result.needTime = result.needTime*(1-accPer);
			}
		}

		/**
		 * 影响工人训练时间
		 */ 
		public function effectWorkerTrainningTime(result:RuleCheckResult,buildingObj:BaseBuilding):void{
			if(buildingObj !=null && result !=null){
				result.needTime = result.needTime -(buildingObj.level-1)*1;
			}
		}
		
		/**
		 * 获得学院的级别，用于计算生效的科技级别
		 */
		public function getAcademyLevel():int {
			var building:BaseBuilding = this.buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_ACADEMY_BUILDING);
			if (building ==null) {
				return 0;
			} else {
				return building.level;
			}
		}
		
		/**
		 * 获得军事学院的级别，用于计算生效的科技级别
		 */
		public function getMilitaryInstituteLevel():int {
			var building:BaseBuilding = this.buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_MILITARY_INSTITUTE);
			if (building ==null) {
				return 0;
			} else {
				return building.level;
			}
		}
		
		public function isCurCastle():Boolean {
			return this.cityId == GameContext.instance.getPlayerObj().getCurCastleObj().cityId;
		}
		
		public function setAsCurCastle():void {
			GameContext.instance.getPlayerObj().changeCurCastle(this.cityId);
		}
		
		/**
		 * 获得野地到当前城堡的距离
		 */
		public function getDistanceToField(fx:int, fy:int):Number {
			var cx:int = this.idField /10000;
			var cy:int = this.idField % 10000;
			
			return GameContext.getDistance(fx,fy,cx,cy);
		}
		
		public function hasTroopOccur():Boolean{
			var cObj:CastleObj = GameContext.instance.getPlayerObj().getCurCastleObj();
			var isInMission:Boolean = false;
			for each(var hObj:HeroObj in cObj.heroManager.heroArray){
				if (hObj.heroInfo.status == HeroManConstants.STATUS_BACKWARD || hObj.heroInfo.status == HeroManConstants.STATUS_FORWARD || hObj.heroInfo.status == HeroManConstants.STATUS_GUARD){
					isInMission = true;
				}
			}
			return isInMission;
		}
		
	}
}
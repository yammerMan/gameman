package roma.logic.object.building
{
	import flash.utils.Dictionary;
	
	import roma.common.constants.BuildingConstant;
	import roma.common.constants.TempleConstant;
	import roma.logic.GameContext;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.rule.BuildingRule;
	import roma.logic.rule.GameRuleHelper;
	import roma.resource.ImgManager;
	import roma.util.MultiLang;
	
	public class BuildingHelper
	{
		public static var instance:BuildingHelper = new BuildingHelper();
		
		private var nameMap:Dictionary = new Dictionary();
		
		/** 城堡可以建筑的建筑 **/
		public var castleBuildingTypeArray:Array = new Array();
		
		/** 营寨可以建造的建筑 */
		public var campBuildingTypeArray:Array = new Array();
		
		public static var protectLimitArray:Array =new Array(20000,50000,100000,300000,700000,1500000,3500000,8000000,18000000,37000000);
		public static var protectPercentArray:Array =new Array(14,18,22,26,30,34,38,42,46,50);
		
		public function BuildingHelper() {
			this.initNameMap();
			this.initCastleBuildingTypeArray();
		}
		
		private function initNameMap():void {
			nameMap[BuildingConstant.TYPE_HOUSE_BUILDING] =      "house";
			nameMap[BuildingConstant.TYPE_WAREHOUSES] =           "warehouse";
			nameMap[BuildingConstant.TYPE_BARRACKS] =             "barrack";
			nameMap[BuildingConstant.TYPE_STABLES] =              "stable";
			nameMap[BuildingConstant.TYPE_WORKSHOPS] =            "workshop";
			nameMap[BuildingConstant.TYPE_AMPHITHEATRE] =        "amphitheatre";
			nameMap[BuildingConstant.TYPE_MARKET_BUILDING] =              "market";
			nameMap[BuildingConstant.TYPE_DAK] =                 "dak";
			nameMap[BuildingConstant.TYPE_ACADEMY_BUILDING] =             "academy";
			nameMap[BuildingConstant.TYPE_MILITARY_INSTITUTE] =  "militaryInstitute";
			nameMap[BuildingConstant.TYPE_TEMPLE] =              "temple";
			nameMap[BuildingConstant.TYPE_TRAINNINGS] =     "trainningFeild";
			nameMap[BuildingConstant.TYPE_TOWN_HALLS] =           "townHall";
			nameMap[BuildingConstant.TYPE_WALL_BUILDING] =                "wall";

			nameMap[BuildingConstant.TYPE_FARM] =                "farm";
			nameMap[BuildingConstant.TYPE_MINE_IRON] =           "ironMine";
			nameMap[BuildingConstant.TYPE_SAWMILL] =             "sawmill";
			nameMap[BuildingConstant.TYPE_QUARRY] =              "quarry";
		}
		
		private function initCastleBuildingTypeArray():void {
			this.castleBuildingTypeArray.push(BuildingConstant.TYPE_HOUSE_BUILDING);         
			this.castleBuildingTypeArray.push(BuildingConstant.TYPE_WAREHOUSES);     
			this.castleBuildingTypeArray.push(BuildingConstant.TYPE_BARRACKS);       
			this.castleBuildingTypeArray.push(BuildingConstant.TYPE_STABLES);        
			this.castleBuildingTypeArray.push(BuildingConstant.TYPE_WORKSHOPS);      
			this.castleBuildingTypeArray.push(BuildingConstant.TYPE_AMPHITHEATRE);        
			this.castleBuildingTypeArray.push(BuildingConstant.TYPE_MARKET_BUILDING);        
			this.castleBuildingTypeArray.push(BuildingConstant.TYPE_DAK);           
			this.castleBuildingTypeArray.push(BuildingConstant.TYPE_ACADEMY_BUILDING);       
			this.castleBuildingTypeArray.push(BuildingConstant.TYPE_MILITARY_INSTITUTE);
			this.castleBuildingTypeArray.push(BuildingConstant.TYPE_TEMPLE);        
			this.castleBuildingTypeArray.push(BuildingConstant.TYPE_TRAINNINGS);

			this.castleBuildingTypeArray.push(BuildingConstant.TYPE_FARM);
			this.castleBuildingTypeArray.push(BuildingConstant.TYPE_MINE_IRON);
			this.castleBuildingTypeArray.push(BuildingConstant.TYPE_SAWMILL);
			this.castleBuildingTypeArray.push(BuildingConstant.TYPE_QUARRY);
		}
		
		public function getName(type:int):String {
			var key:String = nameMap[type];
			return MultiLang.msg("building." + key + ".name");
		}
		
		public function getDesc(type:int):String {
			var src:String="";
			if(type!=BuildingConstant.TYPE_TEMPLE){
				var key:String = nameMap[type];
				src=MultiLang.msg("building." + key + ".desc");
			}else{
				var castle:CastleObj=GameContext.instance.getPlayerObj().getCurCastleObj();
				switch(castle.godType){
					case TempleConstant.JUNEAU_GOD:
						src=MultiLang.msg("building.temple.desc.juneauGod");
					break;
					
					case TempleConstant.JUPITER_GOD:
						src=MultiLang.msg("building.temple.desc.jupiterGod");
					break;
					
					case TempleConstant.MARS_GOD:
						src=MultiLang.msg("building.temple.desc.marsGod");
					break;
					
					default:
						src=MultiLang.msg("building.temple.desc");
				}
			}
			
			return src;
		}
		
		public function getFunctionDesc(type:int):String {
			var key:String = nameMap[type];
			return MultiLang.msg("building." + key + ".functionDesc");
		}
		
		public function getFuncDesc(type:int,level:int=0, ... paramArray):String{
			var key:String = nameMap[type];
			var buildingName:String=BuildingHelper.instance.getName(type);
			if(paramArray.length==1){
				return MultiLang.msg("building." + key + ".func",level,buildingName, paramArray[0]);
			}
			if(paramArray.length==2){
				return MultiLang.msg("building." + key + ".func",level,buildingName, paramArray[0],paramArray[1]);
			}
			if(paramArray.length==3){
				return MultiLang.msg("building." + key + ".func",level,buildingName, paramArray[0],paramArray[1],paramArray[2]);
			}
			if(paramArray.length==4){
				return MultiLang.msg("building." + key + ".func",level,buildingName, paramArray[0],paramArray[1],paramArray[2],paramArray[3]);
			}
			return MultiLang.msg('building.' + key + '.func');
		}
		
		public function getLogoClass(type:int,level:int =0):String{
			var key:String = nameMap[type];

			if(type == BuildingConstant.TYPE_WALL_BUILDING){
				if(level<=3){
					key = nameMap[type]+"1";
				}else if(level>=4 && level<8){
					key = nameMap[type]+"2";
				}else if(level>=8 && level<10){
					key = nameMap[type]+"3";
				}else if(level>=10){
					key = nameMap[type]+"4";
				}
			}
			
			return ImgManager.clazz("building." + key + ".icon");
		}
		
		public function getBuildingStatus(status:int,level:int=1):String{
			switch(status){
				case BuildingConstant.STATUS_ORDINARY:
					return MultiLang.msg("building.common.normal");
				break;
				
				case BuildingConstant.STATUS_UPGRAD_ING:
					if(level==0){
						return MultiLang.msg("building.common.builting");
					}else{
						return MultiLang.msg("building.common.upgrating");
					}
				break;
				
				case BuildingConstant.STATUS_DESTRUCT_ING:
					return MultiLang.msg("building.common.destructing");
				break;
				default:
				
			}
			return MultiLang.msg("upgradingWin.errorBuildingType");
		}
		
		/**
		 *获取不同级别的建筑图标 
		 * @param level
		 * @return 
		 * 
		 */
		public function getDiffLevelIcon(level:int):Class{
			return ImgManager.clazz("level.background");
		}
		
		/*
		 *根据建筑typeId和级别，获取建筑升级信息 
		 */
		public function getBuildingFuncDesc(type:int,level:int):String{
			var str:String="";
			switch(type){
				case BuildingConstant.TYPE_TOWN_HALLS:
					str=this.getSpecialFuncDesc(type,level);
				break;
				
				case BuildingConstant.TYPE_WALL_BUILDING:
					str=this.getCommonFuncDesc(type,level);
				break;
				
				case BuildingConstant.TYPE_HOUSE_BUILDING:
					str=this.getCommonFuncDesc(type,level);
				break;
				
				case BuildingConstant.TYPE_WAREHOUSES:
					str=this.getCommonFuncDesc(type,level);
				break;
				
				case BuildingConstant.TYPE_AMPHITHEATRE:
//					str=this.getCommonFuncDesc(type,level);
					str=this.getTavernFuncDesc(type,level);
				break;
				
				case BuildingConstant.TYPE_MARKET_BUILDING:
					str=this.getCommonFuncDesc(type,level);
				break;
				
				case BuildingConstant.TYPE_DAK:
					str=this.getDakFuncDesc(type,level);
				break;
				
				case BuildingConstant.TYPE_TRAINNINGS:
					str=this.getCommonFuncDesc(type,level);
				break;
				
				case BuildingConstant.TYPE_ACADEMY_BUILDING:
					str=this.getCommonFuncDesc(type,level);
				break;
				
				case BuildingConstant.TYPE_MILITARY_INSTITUTE:
					str=this.getCommonFuncDesc(type,level);
				break;
				
				case BuildingConstant.TYPE_BARRACKS:
					str=this.getSpecialFuncDesc(type,level);
				break;
				
				case BuildingConstant.TYPE_STABLES:
					str=this.getSpecialFuncDesc(type,level);
				break;
				
				case BuildingConstant.TYPE_WORKSHOPS:
					str=this.getSpecialFuncDesc(type,level);
				break;
				
				case BuildingConstant.TYPE_TEMPLE:
					str=this.getTempleFuncDesc(type,level);
				break;
				
				case BuildingConstant.TYPE_FARM:
					str=this.getSpecialFuncDesc(type,level);
				break;
				
				case BuildingConstant.TYPE_MINE_IRON:
					str=this.getSpecialFuncDesc(type,level);
				break;
				
				case BuildingConstant.TYPE_SAWMILL:
					str=this.getSpecialFuncDesc(type,level);
				break;
				
				case BuildingConstant.TYPE_QUARRY:
					str=this.getSpecialFuncDesc(type,level);
				break;
				
				default:
					str=MultiLang.msg("upgradingWin.errorBuildingType");
			}
			return str;
		}
		
		/** 获得通用建筑的功能说明 */
		private function getCommonFuncDesc(type:int,level:int):String {
			if (level>0 && level < BuildingConstant.HIGHEST_LEVEL+1) {
				var rule:BuildingRule = GameRuleHelper.instance.getBuildingRule(type , level);
				if(rule.buff3!=0){
					return this.getFuncDesc(type,rule.buildingLevel, rule.buff1 , rule.buff2, rule.buff3);
				}else if(rule.buff2!=0){
					return this.getFuncDesc(type,rule.buildingLevel, rule.buff1 , rule.buff2);
				}else{
					return this.getFuncDesc(type,rule.buildingLevel, rule.buff1);
				}
				
			} else {
				return "";
			}
		}
		
		/** 获得特别建筑的功能说明 */
		private function getSpecialFuncDesc(type:int,level:int):String {
			if(type==BuildingConstant.TYPE_TOWN_HALLS){
				return getTownHallFunDesc(type,level);
			}
			if(type==BuildingConstant.TYPE_BARRACKS||type==BuildingConstant.TYPE_STABLES||type==BuildingConstant.TYPE_WORKSHOPS){
				if(level==1){
					return MultiLang.msg("building.barrack.funcForLevelOne",this.getName(type));
				}	
			}
			if (level>0 && level < BuildingConstant.HIGHEST_LEVEL+1) {
				var rule:BuildingRule = GameRuleHelper.instance.getBuildingRule(type , level);
				if(rule.buff3!=0){
					return  this.getFuncDesc(type,rule.buildingLevel, rule.buff1 , rule.buff2, rule.buff3);
				}
				if(rule.buff2!=0){
					return  this.getFuncDesc(type,rule.buildingLevel, rule.buff1 , rule.buff2);
				}
				if(rule.buff1!=0){
					return MultiLang.msg("building."+nameMap[type]+".funcSpecial",rule.buildingLevel,this.getName(type), rule.buff1);
				}
			} 
			return "";
		}
		
		/** 获得驿站的功能说明 */
		private function getDakFuncDesc(type:int,level:int):String {
			if (level>0 && level < BuildingConstant.HIGHEST_LEVEL+1) {
				var rule:BuildingRule = GameRuleHelper.instance.getBuildingRule(type , level);
				if(rule.buff2!=0){
					return  this.getFuncDesc(type,rule.buildingLevel , rule.buff2);
				}
			} 
			return "";
		}
		
		
		/** 获得酒馆的功能说明 */
		private function getTavernFuncDesc(type:int,level:int):String {
			if (level>0 && level < BuildingConstant.HIGHEST_LEVEL+1) {
				var rule:BuildingRule = GameRuleHelper.instance.getBuildingRule(type , level);
				if(rule.buff3!=0){
					return this.getFuncDesc(type,rule.buildingLevel, rule.buff2 , rule.buff3,rule.buildingLevel*5);
				}else if(rule.buff2!=0){
					return this.getFuncDesc(type,rule.buildingLevel, rule.buff2 , rule.buff3);
				}else{
					return this.getFuncDesc(type,rule.buildingLevel, rule.buff2);
				}
				
			} else {
				return "";
			}
		}
		
		/** 获得官府的功能说明 */
		private function getTownHallFunDesc(type:int,level:int):String{
			var protectLimit:int;
			var protectPercent:int;
			protectLimit=BuildingHelper.protectLimitArray[level-1];
			protectPercent=BuildingHelper.protectPercentArray[level-1];
			if(level==1){
				return MultiLang.msg("townHall.funDescForLevelOne",this.getName(type),protectLimit,protectPercent);
			}
			
			if (level>0 && level < BuildingConstant.HIGHEST_LEVEL+1) {
				var rule:BuildingRule = GameRuleHelper.instance.getBuildingRule(type , level);

				return  this.getFuncDesc(type,rule.buildingLevel, rule.buff1 ,protectLimit,protectPercent);
				
			} 
			return "";
		}
		/** 获得神庙的功能说明 */
		private function getTempleFuncDesc(type:int,level:int):String {
			if (level>0 && level < BuildingConstant.HIGHEST_LEVEL+1) {
				var src:String="";
				var castle:CastleObj=GameContext.instance.getPlayerObj().getCurCastleObj();
				switch(castle.godType){
					case TempleConstant.JUNEAU_GOD:
						src=MultiLang.msg("building.temple.func.juneauGod",level,level);
					break;
					
					case TempleConstant.JUPITER_GOD:
						src=MultiLang.msg("building.temple.func.jupiterGod",level,level*5+100);
					break;
					
					case TempleConstant.MARS_GOD:
						src=MultiLang.msg("building.temple.func.marsGod",level,level*5+100);
					break;
					
					default:
						src=MultiLang.msg("building.temple.func.noGod");
				}
				return src;
				
			} else {
				return "";
			}
		}
	}
}
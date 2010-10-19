package roma.logic.object.castle
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	import roma.common.constants.BuildingConstant;
	import roma.common.constants.GeneralConstants;
	import roma.common.events.BuildingUpdate;
	import roma.common.valueObject.ArchitectureBean;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.object.building.impl.Academy;
	import roma.logic.object.building.impl.Amphitheater;
	import roma.logic.object.building.impl.Barrack;
	import roma.logic.object.building.impl.Dak;
	import roma.logic.object.building.impl.Farm;
	import roma.logic.object.building.impl.House;
	import roma.logic.object.building.impl.IronMine;
	import roma.logic.object.building.impl.Market;
	import roma.logic.object.building.impl.MilitaryInstitute;
	import roma.logic.object.building.impl.Quarry;
	import roma.logic.object.building.impl.Sawmill;
	import roma.logic.object.building.impl.Stable;
	import roma.logic.object.building.impl.Temple;
	import roma.logic.object.building.impl.TownHall;
	import roma.logic.object.building.impl.TrainningField;
	import roma.logic.object.building.impl.Wall;
	import roma.logic.object.building.impl.WareHouse;
	import roma.logic.object.building.impl.Workshop;
	import roma.message.EvtDispacther;
	import roma.message.events.BuildingStatusChangeEvent;
	import roma.message.events.WindowSwitchEvent;
	
	public class CastleBuildingManager
	{
		private var _castle:CastleObj;


		private var allBuilding:Array = new Array(BuildingConstant.BUILDING_LIMIT);//按位置索引，内容是BaseBuildingObj
		private var uniqueBuildingMap:Dictionary = new Dictionary();//唯一性的建筑，按类型索引，内容是BaseBuildingObj
		private var multipleBuildingMap:Dictionary = new Dictionary();//非唯一性建筑，按类型索引，内容是数组，数组的内容是BaseBuildingObj
		
		private var townHall:TownHall;
		private var wall:Wall;
		
		public function CastleBuildingManager(castle:CastleObj , buildingArray:ArrayCollection)
		{
			_castle = castle;

			for each(var buildingBean:ArchitectureBean in buildingArray) {
				this.addBuilding(buildingBean);
			}
		}
		
		/*获取建筑列表*/
		public function getAllBuildingArray():Array{
			return this.allBuilding;
		}
		
		
		/**
		 * 按类型寻找可重复的建筑
		 */
		public function getMultipleBuildingArrayByType(typeId:int):Array{
			return this.multipleBuildingMap[typeId];
		}

		/**
		 * 按类型寻找唯一性建筑
		 */
		public function getUniqueBuildingByType(typeId:int):BaseBuilding {
			return this.uniqueBuildingMap[typeId];
		}

		/**
		 * 按位置寻找建筑
		 */
		public function getBuildingObjAtPosition(position:int):BaseBuilding {
			return this.allBuilding[position] as BaseBuilding
		}
		
		/**
		 * 获取在建状态的建筑列表
		 */
		 public function getUnNormalBuilidngArr():Array{
		 	var allUnNormalBuilidng:Array=new Array();						
				if(this.allBuilding.length>0){
					for each(var obj:BaseBuilding in this.allBuilding){
						if(obj !=null){
							if (obj.isConstructing()) {
								allUnNormalBuilidng.push(obj);		
							}
						}
					}	
				} 
				if(this.townHall.isConstructing()){
					allUnNormalBuilidng.push(this.townHall);
				}
				if(this.wall!=null){
					if(this.wall.isConstructing()){
						allUnNormalBuilidng.push(this.wall);
					}
				}
				return allUnNormalBuilidng;
		 }
		
		/**
		 * 建筑发生更新
		 */
		public function updateBuilding(event:BuildingUpdate):void {
			var buildingObj:BaseBuilding;
			if (event.updateType == GeneralConstants.UPDATE_ADD_TYPE) {
				//增加建筑
				buildingObj = this.addBuilding(event.bean);
			} else {
				if (event.bean.typeId == BuildingConstant.TYPE_TOWN_HALLS) {
					buildingObj = this.townHall;
				} else if (event.bean.positionId == BuildingConstant.WALL_POSITION) {
					buildingObj = this.wall;
				} else {
					buildingObj = this.getBuildingObjAtPosition(event.bean.positionId);
				}
				
				if (event.updateType == GeneralConstants.UPDATE_DELETE_TYPE) {
					//删除建筑
					if (buildingObj is Wall) {
						this.wall = null;
					} else {
						this.removeBuilding(buildingObj);
						//这个时候的建筑不存在了，等级应该为0 fdc改  
						buildingObj.level = 0;
						EvtDispacther.instance.eventDispatch(WindowSwitchEvent.WINDOW_CLOSE_ID);
					}
				} else {
					//默认是更新
					buildingObj.updateArchitectureBean(event.bean);
				}
			}
			
			EvtDispacther.instance.dispatchEvent(new BuildingStatusChangeEvent(buildingObj));
			//建筑可能会影响资源
		}

		public function getTownHall():TownHall {
			return this.townHall;
		}
		
		public function getWall():Wall {
			return this.wall;
		}

		private function removeBuilding(buildingObj:BaseBuilding):void {
			this.allBuilding[buildingObj.position] = null;
			if (buildingObj.isUniqueType()) {
				this.uniqueBuildingMap[buildingObj.typeId] = null;
			} else {
				var array:Array = this.multipleBuildingMap[buildingObj.typeId] as Array;
				var index:int = array.indexOf(buildingObj);
				array = array.splice(index,1);
			}
		}

		private function addBuilding(buildingBean:ArchitectureBean):BaseBuilding {
			var buildingObj:BaseBuilding = this.consNewBuildingObjInstance(buildingBean);
			if (buildingObj is TownHall) {
				this.townHall = buildingObj as TownHall;
			} else if (buildingObj is Wall) {
				this.wall = buildingObj as Wall;
			} else {
				this.allBuilding[buildingObj.position] = buildingObj;
				if (buildingObj.isUniqueType()) {
					this.uniqueBuildingMap[buildingObj.typeId] = buildingObj;
				} else {
					var array:Array = this.multipleBuildingMap[buildingObj.typeId] as Array;
					if (array == null) {
						array = new Array();
						this.multipleBuildingMap[buildingObj.typeId] = array;
					}
					array.push(buildingObj);
				}
			}
			return buildingObj;
		}

		private function consNewBuildingObjInstance(buildingBean:ArchitectureBean):BaseBuilding {
			var res:BaseBuilding;
			switch(buildingBean.typeId) {
				case BuildingConstant.TYPE_TOWN_HALLS:
					res = new TownHall(buildingBean);
					break;
				case BuildingConstant.TYPE_WALL_BUILDING:
					res = new Wall(buildingBean);
					break;
				case BuildingConstant.TYPE_HOUSE_BUILDING:
					res = new House(buildingBean);
					break;
				case BuildingConstant.TYPE_AMPHITHEATRE:
					res = new Amphitheater(buildingBean);
					break;
				case BuildingConstant.TYPE_WAREHOUSES:
					res = new WareHouse(buildingBean);
					break;
				case BuildingConstant.TYPE_BARRACKS:
					res = new Barrack(buildingBean);
					break;
				case BuildingConstant.TYPE_STABLES:
					res = new Stable(buildingBean);
					break;
				case BuildingConstant.TYPE_WORKSHOPS:
					res = new Workshop(buildingBean);
					break;
				case BuildingConstant.TYPE_MARKET_BUILDING:
					res = new Market(buildingBean);
					break;
				case BuildingConstant.TYPE_DAK:
					res = new Dak(buildingBean);
					break;
				case BuildingConstant.TYPE_ACADEMY_BUILDING:
					res = new Academy(buildingBean);
					break;
				case BuildingConstant.TYPE_MILITARY_INSTITUTE:
					res = new MilitaryInstitute(buildingBean);
					break;
				case BuildingConstant.TYPE_TEMPLE:
					res = new Temple(buildingBean);
					break;
				case BuildingConstant.TYPE_TRAINNINGS:
					res = new TrainningField(buildingBean);
					break;
				case BuildingConstant.TYPE_FARM:
					res = new Farm(buildingBean);
					break;
				case BuildingConstant.TYPE_QUARRY:
					res = new Quarry(buildingBean);
					break;
				case BuildingConstant.TYPE_MINE_IRON:
					res = new IronMine(buildingBean);
					break;
				case BuildingConstant.TYPE_SAWMILL:
					res = new Sawmill(buildingBean);
					break;
				default :
					throw new Error("CastleObj.consNewBuildingObjInstance(). invalid building type type=" + buildingBean.typeId);
			}
			res.castle = _castle;
			return res;
		}
		

	}
}
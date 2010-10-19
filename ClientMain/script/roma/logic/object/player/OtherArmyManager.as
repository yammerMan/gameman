package roma.logic.object.player
{
	import mx.collections.ArrayCollection;
	
	import roma.common.constants.BuildingConstant;
	import roma.common.constants.GeneralConstants;
	import roma.common.constants.HeroManConstants;
	import roma.common.events.OtherArmyLeave;
	import roma.common.events.OtherArmyStatusUpdate;
	import roma.common.events.OtherArmyUpdate;
	import roma.common.valueObject.OtherArmyBean;
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	import roma.message.EvtDispacther;
	
	/**
	 * 其他玩家所有军队信息
	 */ 
	public class OtherArmyManager
	{
		public var otherArmyList:Array;
		public var allianceArmyList:ArrayCollection = new ArrayCollection();
		public var enemyArmyList:ArrayCollection = new ArrayCollection();
		
		public var allianceArmyCount:int = 0;
		public var enemyArmyCount:int = 0;
		
		public function OtherArmyManager(otherArmyArray:ArrayCollection){
			this.otherArmyList = new Array();
			for each (var bean:OtherArmyBean in otherArmyArray) {
				var obj:OtherArmyObj = new OtherArmyObj(bean);
				this.otherArmyList.push(obj);
			}
			this.refreshCount();
			allianceArmyList = getLeagueArmyArray();
		}
		
		/**
		 * 获得所有敌军
		 */
		public function getEnemyArmyArray():ArrayCollection {
			var level:int =0;
			var building:BaseBuilding = GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_TRAINNINGS);
			if (building!=null) {
				level = building.level;
			}
			
			var res:ArrayCollection = new ArrayCollection();
			for each (var obj:OtherArmyObj in this.otherArmyList) {
				if (obj.bean.attacker) {
					obj.resetForEnemy(level);
					res.addItem(obj);
				}
			}
			return res;
		}
		
		/**
		 * 获得所有盟军、友好军队（协防军队）的信息
		 */
		public function getLeagueArmyArray():ArrayCollection {
			var res:ArrayCollection = new ArrayCollection();
			for each (var obj:OtherArmyObj in this.otherArmyList) {
				if (!obj.bean.attacker) {
					res.addItem(obj);
					obj.resetForAlliance();
				}
			}
			return res;
		}
		
		/**
		 * 获得指定野地的盟军的信息
		 */
		public function getLeagueArmyArrayInField(idField:int):ArrayCollection {
			var res:ArrayCollection = new ArrayCollection();
			for each (var obj:OtherArmyObj in this.otherArmyList) {
				if (!obj.bean.attacker&&obj.bean.targetFieldId==idField) {
					res.addItem(obj);
					obj.resetForAlliance();
				}
			}
			return res;
		}
		
		/**
		 * 刷新敌军和盟军的数量
		 */
 		private function refreshCount():void {
			var enemy:int = 0;
			var alliance:int = 0;
			for each (var obj:OtherArmyObj in this.otherArmyList) {
				if (obj.bean.attacker) {
					enemy ++;;
				} else {
					if (obj.bean.status == HeroManConstants.STATUS_FORWARD) {
						alliance++;
					}
				}
			}			
			allianceArmyCount = alliance;
			enemyArmyCount = enemy;
			allianceArmyList = getLeagueArmyArray();
		} 
		
		public function onOtherArmyLeave(event:OtherArmyLeave):void {
			for (var i:int = 0 ; i<this.otherArmyList.length; i++) {
				var obj:OtherArmyObj = OtherArmyObj(this.otherArmyList[i]);
				if (obj.heroManId == event.heroManId) {
					this.otherArmyList.splice(i,1);
					this.sendOtherArmyChangeEvent(obj);
					break;
				}	
			}
			this.refreshCount();
		}
		
		public function onOtherArmyStatusUpdate(event:OtherArmyStatusUpdate):void {
			for each (var obj:OtherArmyObj in this.otherArmyList) {
				if (obj.heroManId == event.heroManId) {
					obj.bean.status = event.status;
					obj.refresh();
					break;
				}
			}			
			this.refreshCount();
		}
		
		private function sendOtherArmyChangeEvent(obj:OtherArmyObj):void {
			if (obj.bean.attacker) {
				EvtDispacther.sendEvent(EvtDispacther.ENEMY_ARMY_CHANGE);
			} else {
				EvtDispacther.sendEvent(EvtDispacther.ALLIANCE_ARMY_CHANGE);
			}
		}
		
		public function onOtherArmyUpdate(event:OtherArmyUpdate):void {
			if (event.updateType == GeneralConstants.UPDATE_ADD_TYPE) {
				//增加
				var obj1:OtherArmyObj = new OtherArmyObj(event.otherArmy);
				this.otherArmyList.push(obj1);
				this.sendOtherArmyChangeEvent(obj1);
			}else{
				for(var i:int=0;i<otherArmyList.length;i++){
					var o:OtherArmyObj = otherArmyList[i];
					if(o.heroManId == event.otherArmy.heroInfo.id){
						if(event.updateType == GeneralConstants.UPDATE_DELETE_TYPE){
							otherArmyList.splice(i,1);
							this.sendOtherArmyChangeEvent(o);
						}
						else if(event.updateType == GeneralConstants.UPDATE_UPDATE_TYPE){
							o.update(event.otherArmy);
							this.sendOtherArmyChangeEvent(o);
						}
						break;
					}
				}
			}
			this.refreshCount();
		}
		
	}
}
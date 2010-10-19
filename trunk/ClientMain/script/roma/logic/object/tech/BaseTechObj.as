package roma.logic.object.tech
{
	import roma.common.constants.BuildingConstant;
	import roma.common.constants.TechConstant;
	import roma.common.valueObject.TechBean;
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.TechRule;
	
	import sound.MsgSound;
	
	[Bindable]
	public class BaseTechObj
	{
		public var techName:String;
		public var techType:int;
		public var techIcon:String;
		public var techFuncdesc:String;
		public var level:int;

		public var finishTime:Number;
		public var timeNeed:int;
		public var startResearching:Boolean;
		public var startResearchingCastleId:int;
		public var cityId:int;
		
		public var techKind:int;
		
		public function BaseTechObj()
		{
		}

		public function setBean(bean:TechBean):void {
			if (this.startResearching && !bean.researching) {
				MsgSound.instance.playMsgSound();			
			}
			
			this.level = bean.level;
			this.techType = bean.typeId;
			this.cityId = bean.cityId;
			
			this.startResearching = bean.researching;
			
			if (this.startResearching) {
				this.startResearchingCastleId = bean.cityId;
				this.finishTime = bean.finishTime;
				this.timeNeed = bean.timeNeed;
			} else {
				this.startResearchingCastleId = 0;
				this.finishTime = 0;
				this.timeNeed = 0;
			}
			
			this.techName = this.getName(bean.typeId);
			this.techIcon = this.getIcon(bean.typeId);
			this.techFuncdesc = this.getFuncDesc(bean.typeId);
			this.techKind = this.getDependBuildingType();			
		}

		/**
		 * 返回科技名称
		 * @param typeId
		 * @return 
		 */		
		private function getName(typeId:int):String{
			return TechHelper.instance.getTechName(typeId);
		}
		
		/**
		 * 返回科技图标
		 * @param typeId
		 * @return 
		 */
		private function getIcon(typeId:int):String{
			return TechHelper.instance.getTechIcon(typeId);
		}		

		/**
		 * 返回科技类别
		 * @return 
		 */
		protected function getDependBuildingType():int {
			return BuildingConstant.TYPE_ACADEMY_BUILDING;
		}
		
		/**
		 * 返回科技功能说明
		 * @param typeId
		 * @return 
		 */
		public function getFuncDesc(typeId:int):String {
			return TechHelper.instance.getFuncDesc(typeId);
		}

		/**
		 * 返回当前可用科技级别
		 * @param castle
		 * @return 
		 */		
		public function getCurCastleTechLevel(castle:CastleObj):int {
			var buildingLevel:int = 0;
			var building:BaseBuilding = castle.buildingManager.getUniqueBuildingByType(this.getDependBuildingType());
			if (building !=null) {
				buildingLevel = building.level;
			}
			
			if (this.level > buildingLevel) {
				return buildingLevel; 
			} else {
				return this.level;
			}
		}
		
		public function getCurCastleTechRule(castle:CastleObj):TechRule {
			var techLevel:int = this.getCurCastleTechLevel(castle);
			if (techLevel>0) {
				return GameRuleHelper.instance.getTechRule(this.techType , techLevel);
			} else {
				return null;
			}
		}
		
		public function getNextTechRule():TechRule{
			if(this.level<TechConstant.HIGHEST_LEVEL){
				return GameRuleHelper.instance.getTechRule(this.techType , level+1);
			}
			return null;
		}
	
		/**
		 * 获得以秒为单位的剩余时间
		 */
		public function getRemainTimeSec():Number {
			var rt:Number = (this.finishTime - new Date().valueOf() + GameContext.instance.timeDis)/1000;
			if (rt<0) {
				rt = 0;
			}
			return rt;
		}
		
		/**
		 * 加速
		 */
		public function speedUp():void{
			//TODO
		}
	}
}
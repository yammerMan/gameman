package roma.logic.object.hero
{
	import mx.collections.ArrayCollection;
	
	import roma.common.constants.HeroManConstants;
	import roma.common.constants.TechConstant;
	import roma.common.valueObject.HeroRetreatConditionBean;
	import roma.common.valueObject.HeroTroopBean;
	import roma.logic.GameContext;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.TechRule;
	import roma.logic.rule.TroopRule;
	
	[Bindable]
	public class HeroArmyManager
	{
		public var troopsArray:ArrayCollection;
		
		public var retreatCondition:HeroRetreatConditionBean;
		
		public function HeroArmyManager(troopsArray:ArrayCollection , retreatCondition:HeroRetreatConditionBean) {
			this.troopsArray = troopsArray;
			this.retreatCondition = retreatCondition;
		}
		
		public function updateTroop(bean:HeroTroopBean):void {
			bean.copyToBe(this.troopsArray[bean.position]);
		}

		public function updateArmy(tArray:ArrayCollection , rCondition:HeroRetreatConditionBean):void {
			for (var i:int=0; i<tArray.length; i++) {
				HeroTroopBean(tArray[i]).copyToBe(this.troopsArray[i]);
			}
			
			rCondition.copyToBe(this.retreatCondition);
		}
		
		//获取相应部队
		public function getTroopNumById(type:int):int{
			var troopNumber:int=0;
			if(troopsArray.length>0){
				for(var i:int;i<troopsArray.length;i++){
					if(HeroTroopBean(this.troopsArray[i]).troopType==type){
						troopNumber+=HeroTroopBean(this.troopsArray[i]).count;
					}
				}
			}
			return troopNumber;
		}
		
		/**
		 * 计算军队的军力（消耗的统帅力）
		 */
		public function calcTroopStrength():int {
			var total:int = 0;
			for (var i:int=0; i<troopsArray.length; i++) {
				var bean:HeroTroopBean = HeroTroopBean(troopsArray[i]);
				if (bean!=null && bean.count>0) {
					var rule:TroopRule = GameRuleHelper.instance.getTroopRule(bean.troopType);
					total += rule.population * bean.count;
				}
			}
			return total;
		} 
		
		/**
		 * 军队速度
		 * @return 
		 */		
		public function getArmyMinSpeed():int {
			var minSpeed:int = 100000;
			for (var i:int=0; i<troopsArray.length; i++) {
				var bean:HeroTroopBean = HeroTroopBean(troopsArray[i]);
				if (bean!=null && bean.count>0) {
					var rule:TroopRule = GameRuleHelper.instance.getTroopRule(bean.troopType);
					if (minSpeed > rule.speed) {
						minSpeed = rule.speed;
					}
				}
			}

			var castle:CastleObj = GameContext.instance.getPlayerObj().getCurCastleObj();
			var rule1:TechRule= GameContext.instance.getPlayerObj().techManager.getTechObjById(TechConstant.MARCH_ABILITY).getCurCastleTechRule(castle);

			if (rule1!=null && minSpeed !=100000)
				minSpeed = minSpeed * (100 + rule1.techEffect) / 100; 
			
			if (minSpeed == 100000) 
				minSpeed = HeroManConstants.HERO_SPEED;

			return minSpeed;
		}
		
		/**
		 * 军队负重 
		 * @return 
		 */		
		public function getArmyLoad():int{
			var load:int;
			for(var l:int=0;l<troopsArray.length;l++){
				var bean:HeroTroopBean = troopsArray.getItemAt(l) as HeroTroopBean; 
				if(bean !=null && bean.count>0){
					var rule:TroopRule = GameRuleHelper.instance.getTroopRule(bean.troopType);
					load += (bean.count*rule.load);
				}
			}
			
			var castle:CastleObj = GameContext.instance.getPlayerObj().getCurCastleObj();
			var rule1:TechRule  = GameContext.instance.getPlayerObj().techManager.getTechObjById(TechConstant.LOGISTICS).getCurCastleTechRule(castle);

			if (rule1!=null) 
				load = load * (100 + rule1.techEffect) / 100; 
			
			return load;
		}
		
		/**
		 *军队耗粮 
		 * @return 
		 */		
		public function getArmyFoodRequest():int{
			var request:int;
			for(var r:int=0;r<troopsArray.length;r++){
				var bean:HeroTroopBean = troopsArray.getItemAt(r) as HeroTroopBean; 
				if(bean !=null && bean.count>0){
					var rule:TroopRule = GameRuleHelper.instance.getTroopRule(bean.troopType);
					request += (bean.count*rule.foodRequest);
				}
			}
			
			var castle:CastleObj = GameContext.instance.getPlayerObj().getCurCastleObj();
			var rule1:TechRule = GameContext.instance.getPlayerObj().techManager.getTechObjById(TechConstant.SUPPLY_SKILL_TYPE).getCurCastleTechRule(castle);
			
			if (rule1!=null)
				request = request * (100-rule1.techEffect) / 100; 

			return request;
		}
	}
}
package roma.logic.object.castle
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	import roma.common.constants.TroopForConstants;
	import roma.common.events.FortiUpdate;
	import roma.common.events.TroopManUpdate;
	import roma.common.valueObject.PairValueBean;
	import roma.logic.GameContext;
	import roma.logic.object.hero.HeroObj;
	
	public class TroopManager
	{
		private var _castle:CastleObj;
		
		private var troopMap:Dictionary = new Dictionary();
		private var fortMap:Dictionary = new Dictionary();
		private var troopAry:Array =[TroopForConstants.T_ARCHERS,TroopForConstants.T_BALLISTAS,TroopForConstants.T_CAVALRY,TroopForConstants.T_ONAGERS,TroopForConstants.T_TRIARII,TroopForConstants.T_URBAN_COHORT];
		
		public function TroopManager(castle:CastleObj , troops:ArrayCollection , forts:ArrayCollection)
		{
			_castle = castle;
			
			for each (var bean:PairValueBean in troops) {
				this.troopMap[bean.typeId] = bean;
			}
			
			for each (var bean1:PairValueBean in forts) {
				this.fortMap[bean1.typeId] = bean1;
			}
		}
		
		public function getTroopByTypeId(typeId:int):PairValueBean {
			var bean:PairValueBean = this.troopMap[typeId];
			if (bean == null) {
				bean = new PairValueBean();
				bean.typeId = typeId;
				bean.value = 0;
				
				this.troopMap[typeId] = bean;
			}
			return bean;
		}

		public function getFortificationByTypeId(typeId:int):PairValueBean {
			var bean:PairValueBean = this.fortMap[typeId];
			if (bean == null) {
				bean = new PairValueBean();
				bean.typeId = typeId;
				bean.value = 0;
				
				this.fortMap[typeId] = bean;
			}
			return bean;
		}

		/**
		 * 部队更新
		 */
		public function updateTroop(event:TroopManUpdate):void {
			var bean:PairValueBean = this.getTroopByTypeId(event.troop.typeId);
			bean.value = event.troop.value;
		}
		
		/**
		 * 城防更新
		 */
		public function updateFortification(event:FortiUpdate):void {
			var bean:PairValueBean = this.getFortificationByTypeId(event.fortifi.typeId);
			bean.value = event.fortifi.value;
		}
		
		/**
		 * 获取城池空闲部队 
		 * @return 
		 * 
		 */		
		public function getVacantTroop():int{
			var c:int;
			for(var i:int=0;i<this.troopAry.length;i++){
				c += this.getTroopByTypeId(int(troopAry[i])).value;	
			}

			var ary:ArrayCollection = GameContext.instance.getPlayerObj().getCurCastleObj().heroManager.getFreeChiefHeroAry();
			for each(var hero:HeroObj in ary){
				for(var t:int =0;t<this.troopAry.length;t++){
					c+= hero.armyManager.getTroopNumById(int(troopAry[t]));
				}
			}
			return c;
		}
	}
}
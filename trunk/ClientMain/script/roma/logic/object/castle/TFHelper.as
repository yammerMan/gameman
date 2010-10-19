package roma.logic.object.castle
{
	import flash.utils.Dictionary;
	
	import roma.common.constants.TroopForConstants;
	import roma.resource.ImgManager;
	import roma.util.MultiLang;
	
	import views.spreadUI.troop.TFPropConstant;
	
	public class TFHelper
	{
		public static var instance:TFHelper = new TFHelper();
		
		private var TFMap:Dictionary = new Dictionary();
		private var troopIDMap:Dictionary = new Dictionary();
		private var propMap:Dictionary = new Dictionary();
		
		/**
		 * 是否近战兵种
		 */
		public static function isMeleeTroop(troop:int):Boolean {
			return troop == TroopForConstants.T_URBAN_COHORT || troop == TroopForConstants.T_TRIARII || troop == TroopForConstants.T_CAVALRY;
		}

		/**
		 * 是否近战部队的位置
		 */
		public static function isMeleeTroopPostion(position:int):Boolean {
			return position>=0 && position<=2;
		}

		public function TFHelper()
		{
			initTFMap();
			initTropTypeIdMap();
			initTfPropMap();
		}
		
		private function initTFMap():void{
			TFMap[TroopForConstants.T_ARCHERS] 	     = "archers";
			TFMap[TroopForConstants.T_BALLISTAS]   	 = "ballistas";
			TFMap[TroopForConstants.T_CAVALRY]         = "cavalry";
			TFMap[TroopForConstants.T_ONAGERS]         = "onagers";
			TFMap[TroopForConstants.T_SCOUT]           = "scout";
			TFMap[TroopForConstants.T_TRIARII]         = "triarii";
			TFMap[TroopForConstants.T_URBAN_COHORT]    = "urban_cohort";
			
			TFMap[TroopForConstants.F_TRAPS]            = "trap";
			TFMap[TroopForConstants.F_TOWER]      = "arrowtower";
			TFMap[TroopForConstants.F_FALLROCK]        = "rockfall";
		}
		
		private function initTropTypeIdMap():void{
			troopIDMap["archers"] 			     = TroopForConstants.T_ARCHERS;
			troopIDMap["ballistas"]   			 = TroopForConstants.T_BALLISTAS;
			troopIDMap["cavalry"]        	     = TroopForConstants.T_CAVALRY;
			troopIDMap["onagers"]        		 = TroopForConstants.T_ONAGERS;
			troopIDMap["scout"]         		 = TroopForConstants.T_SCOUT;
			troopIDMap["triarii"]         		 = TroopForConstants.T_TRIARII;
			troopIDMap["urbanCohort"]    	     = TroopForConstants.T_URBAN_COHORT;
		}
		
		private function initTfPropMap():void{
			propMap[TFPropConstant.LIFE]          = "life";
			propMap[TFPropConstant.ATTACK]        = "attack";
			propMap[TFPropConstant.DEFENCE]       = "defence";
			propMap[TFPropConstant.DAMAGE]        = "damage";
			propMap[TFPropConstant.FOODREQUEST]   = "foodRequest";
			propMap[TFPropConstant.SPEED]         = "speed";
			propMap[TFPropConstant.LOAD]          = "load";
			propMap[TFPropConstant.POPULATION]    = "population";
		}
		
		public function getTfName(type:int):String{
			var key:String = TFMap[type];
			return MultiLang.msg('tf.'+key+'.name');
		}

		public static function getTroopIconClass(type:int):String {
			if (type) {
				return instance.getTfIcon(type);
			} else {
				return null;
			}
		}

		public function getTroopSmallIconClass(type:int):String {
			if (type) {
				var key:String = TFMap[type];
				return ImgManager.clazz('tf.'+key+'.small');
			} else {
				return null;
			}
		}

		public function getTfIcon(type:int):String{
			if (type) {
				var key:String = TFMap[type];
				return ImgManager.dynamicClazz('tf.'+key+'.icon');
			} else {
				return null;
			}
		}

		public function getTfSkillDesc(type:int):String{
			var key:String = TFMap[type];
			return MultiLang.msg('tf.'+key+'.skill.desc');
		}
		
		public function getTfHistoryDsc(type:int):String{
			var key:String = TFMap[type];
			return MultiLang.msg('tf.'+key+'.history.desc');			
		}
		
		public function getPropName(type:int):String{
			var key:String = propMap[type];
			return MultiLang.msg('tf.'+key+'.name');
		}

		public function getPropDesc(type:int):String{
			var key:String = propMap[type];
			return MultiLang.msg('tf.'+key+'.desc');
		}
		
	}
}
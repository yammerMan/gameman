package roma.logic.rule.questPopRule{
	import roma.logic.object.castle.TFHelper;
	import roma.util.MultiLang;
	
	/**
	 * 城防任务目标
	 */
	//public class FortificationQuestRule extends NumberQuestRule implements
	//		TroopForConstants {
	public class FortificationQuestRule extends BaseRuleProp{
	
		public function FortificationQuestRule(){
		}
	
		private static var T:String  = "quest.fortificationCount{0}{1}";
		
		override public function getName():String {
			var n:String = TFHelper.instance.getTfName(ruleData.type);
			return MultiLang.msg(T,n,ruleData.count);
		}
	
	}
}
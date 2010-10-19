package roma.logic.rule.questPopRule{
	import roma.logic.object.castle.TFHelper;
	import roma.util.MultiLang;
	

/**
 * 军队任务目标
 */
//public class ArmyQuestRule extends NumberQuestRule implements TroopForConstants {
	public class ArmyQuestRule extends BaseRuleProp{
	
		private static var A:String = "quest.armyCount{0}{1}";
	
		public function ArmyQuestRule() {
		}
	
		override public function getName():String {
			var n:String = TFHelper.instance.getTfName(ruleData.type)
			return MultiLang.msg(A,n,ruleData.count);
		}

	}
}

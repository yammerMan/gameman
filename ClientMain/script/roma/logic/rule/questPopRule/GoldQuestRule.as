package roma.logic.rule.questPopRule{
	import roma.util.MultiLang;
	/**
	 * 铜币产量达到的，任务目标逻辑
	 */
	//public class GoldQuestRule extends NumberQuestRule {
	public class GoldQuestRule extends BaseRuleProp{
	
		public function GoldQuestRule() {
		}
	
		private static var F:String  = "quest.goldTotal{0}";
		override public function getName():String {
			return MultiLang.msg(F,ruleData.count);
		}
	}
}
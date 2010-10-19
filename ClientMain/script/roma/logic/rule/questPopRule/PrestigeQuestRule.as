package roma.logic.rule.questPopRule{
	import roma.util.MultiLang;
	/**
	 * 声望任务目标逻辑
	 */
	//public class PrestigeQuestRule extends NumberQuestRule {
	public class PrestigeQuestRule extends BaseRuleProp{
	
		public function PrestigeQuestRule() {
		}
	
		private static var F:String = "quest.prestige{0}";
	
		override public function getName():String {
			return MultiLang.msg(F,ruleData.num);
		}
	
	}
}
package roma.logic.rule.questPopRule{
	import roma.util.MultiLang;
	/**
	 * 木材任务目标逻辑
	 */
	//public class WoodQuestRule extends NumberQuestRule {
	public class LumberQuestRule extends BaseRuleProp{
	
		public function LumberQuestRule() {
		}
	
		private static var F:String = "quest.wood{0}";
	
		override public function getName():String {
			return MultiLang.msg(F,ruleData.count);
		}
	}
}
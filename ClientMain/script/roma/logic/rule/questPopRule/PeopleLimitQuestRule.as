package roma.logic.rule.questPopRule{
	import roma.util.MultiLang;
	
	/**
	 * 人口上限目标
	 */
	//public class PeopleLimitQuestRule extends NumberQuestRule implements
	//		IQuestTargetRule {
	public class PeopleLimitQuestRule extends BaseRuleProp{
		
		public function PeopleLimitQuestRule() {
		}
		
		private static var F:String = "quest.peopleLimit{0}";
		override public function getName():String {
			return MultiLang.msg(F,ruleData.count);
		}
	
	}
}
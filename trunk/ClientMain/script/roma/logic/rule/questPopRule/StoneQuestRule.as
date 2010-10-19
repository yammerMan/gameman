package roma.logic.rule.questPopRule{
	import roma.util.MultiLang;
	
	/**
	 * 石头任务目标逻辑
	 * 
	 */
	//public class StoneQuestRule extends NumberQuestRule {
	public class StoneQuestRule extends BaseRuleProp{
	
		public function StoneQuestRule() {
		}
	
		private static var F:String = "quest.stone{0}";
	
		override public function getName():String {
			return MultiLang.msg(F,ruleData.count);
		}
	}
}
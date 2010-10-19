package roma.logic.rule.questPopRule{
	import roma.util.MultiLang;
	
	/**
	 * 粮食任务目标逻辑
	 */
	//public class FoodQuestRule extends NumberQuestRule {
	public class CropsQuestRule extends BaseRuleProp{
		
		public function CropsQuestRule() {
		}
		
		private static var F:String = "quest.food{0}";
		
		override public function getName():String {
			return MultiLang.msg(F,ruleData.count);
		}
		
	}
}
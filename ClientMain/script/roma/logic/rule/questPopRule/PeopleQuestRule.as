package roma.logic.rule.questPopRule{
	import mx.logging.Log;
	
	import roma.util.MultiLang;
	/**
	 * 人口任务目标逻辑
	 *
	 */
	//public class PopulationQuestRule extends NumberQuestRule {
	public class PeopleQuestRule extends BaseRuleProp{
	
		public function PeopleQuestRule() {
		}
	
		private static var P:String = "quest.population{0}";
		
		override public function getName():String {
//			Log.getLogger("roma.logic.rule.QuestRule").debug(P);
			return MultiLang.msg(P,ruleData.count);
		}
	
	}
}
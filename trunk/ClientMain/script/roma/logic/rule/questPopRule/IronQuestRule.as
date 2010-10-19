package roma.logic.rule.questPopRule{
	import mx.logging.Log;
	
	import roma.util.MultiLang;
	/**
	 * 铁锭任务目标逻辑
	 * 
	 */
	//public class IronQuestRule extends NumberQuestRule {
	public class IronQuestRule extends BaseRuleProp{
	
		public function IronQuestRule() {
		}
	
		private static var F:String = "quest.iron{0}";
	
		override public function getName():String {
//			Log.getLogger("roma.logic.rule.QuestRule").debug(Lang.msg(F,ruleData.count));
			return MultiLang.msg(F,ruleData.count);
		}
	
	}
}
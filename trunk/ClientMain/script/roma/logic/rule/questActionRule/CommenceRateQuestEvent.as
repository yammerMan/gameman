package roma.logic.rule.questActionRule{	import roma.util.MultiLang;
	/**
	 * 修改开工率事件
	 * 
	 */
	public class CommenceRateQuestEvent extends BaseRuleEvent{
		private static var D:String = "quest.texRateAction{0}{1}{2}{3}";
			public function CommenceRateQuestEvent() {
		}
	
		public function getName():String{			return MultiLang.msg(D, ruleData.rate, ruleData.rate, ruleData.rate, ruleData.rate);		}
	}
}
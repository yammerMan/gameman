package roma.logic.rule.questActionRule{
	import roma.util.MultiLang;
	/**
	 * 修改税率事件
	 */
	public class TexRateQuestEvent extends BaseRuleEvent{
		private var tax:int;
		public function TexRateQuestEvent() {
		}
	
		private static var D:String  = "quest.texRateAction{0}";
		override public function getName():String {
			return MultiLang.msg(D,ruleData.rate+"%");	
		}
		
	}
}
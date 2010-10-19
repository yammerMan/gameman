package roma.logic.rule.questActionRule{
	import roma.util.MultiLang;

	/**
	 * 更改旗号任务事件
	 */
	public class RenameFlagQuestEvent extends BaseRuleEvent{
		public function RenameFlagQuestEvent() {
		}
	
		private static var D:String = MultiLang.msg("quest.renameFlagAction");
		override public function getName():String {
			return D;
		}
	
	}
}
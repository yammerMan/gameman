package roma.logic.rule.questActionRule{
	import roma.util.MultiLang;
	
	/**
	 * 城池改名
	 */
	public class RenameCastleQuestEvent extends BaseRuleEvent{
		public function RenameCastleQuestEvent() {
		}
	
		private static var M:String = MultiLang.msg("townHall.label.changCityName");
		override public function getName():String {
			return M;
		}
	
	}
}
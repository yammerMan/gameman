package roma.logic.rule.questActionRule{
	import roma.util.MultiLang;
	/**
	 * 征收物质
	 */
	public class TaxationQuestEvent extends BaseRuleEvent{
		private var name:String ;
		private static var B:String = MultiLang.msg("quest.taxtion.gold");
		private static var C:String = MultiLang.msg("quest.taxtion.wood");
		private static var D:String = MultiLang.msg("quest.taxtion.stone");
		private static var E:String = MultiLang.msg("quest.taxtion.iron");
		public function TaxationQuestEvent() {

		}
		override public function getName():String {
			return name;
		}
	}
}
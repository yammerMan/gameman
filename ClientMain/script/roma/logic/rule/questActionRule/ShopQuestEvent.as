package roma.logic.rule.questActionRule{
	import roma.util.MultiLang;
	
	/**
	 * 在商城购物
	 */
	public class ShopQuestEvent extends BaseRuleEvent{
		public function ShopQuestEvent() {
		}
	
		private static var D:String  = MultiLang.msg("quest.shopAction");
		override public function getName():String {
			return D;	
		}
	}
}
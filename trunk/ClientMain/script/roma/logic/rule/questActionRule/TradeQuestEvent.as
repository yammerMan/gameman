package roma.logic.rule.questActionRule{
	import roma.util.MultiLang;
	

	/**
	 * 向玩家购买,出售资源
	 */
	public class TradeQuestEvent extends BaseRuleEvent{
		private var name:String ; 
		public function TradeQuestEvent() {
		}
	
		private static var D:String = MultiLang.msg("quest.tradeAction.sale");
		private static var E:String  = MultiLang.msg("quest.tradeAction.buy");
	
		override public function getName():String {
			for(var s:String in ruleData){
				if (s == "sale") {
					this.name = D;
				} else if(s == "buyItem"){
					this.name  = E ;
				} 
			}
			return name;
		}
	
	}
}
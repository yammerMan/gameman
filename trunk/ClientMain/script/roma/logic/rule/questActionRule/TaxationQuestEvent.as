package roma.logic.rule.questActionRule{
	import roma.util.MultiLang;
	/**
	 * 征收物质
	 */
	public class TaxationQuestEvent extends BaseRuleEvent{		
		private var name:String ;				private static var A:String = MultiLang.msg("quest.taxtion.food");
		private static var B:String = MultiLang.msg("quest.taxtion.gold");
		private static var C:String = MultiLang.msg("quest.taxtion.wood");
		private static var D:String = MultiLang.msg("quest.taxtion.stone");
		private static var E:String = MultiLang.msg("quest.taxtion.iron");		
		public function TaxationQuestEvent() {

		}
		override public function getName():String {			for(var s:String in ruleData){				 switch(s){					case "food":					this.name = A;					break;					case "gold":					this.name = B;					break;					case "wood":					this.name = C;					break;					case "stone":					this.name = D;					break;					case "iron":					this.name = E;					break;				} 			}
			return name;
		}
	}
}
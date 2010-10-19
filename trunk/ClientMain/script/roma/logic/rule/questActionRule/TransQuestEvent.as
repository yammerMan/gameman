package roma.logic.rule.questActionRule{
	
	/**
	 * 运输
	 */
	public class TransQuestEvent extends BaseRuleEvent{
	
		public TransQuestEvent() {
		}
		private static var D:String  = Lang.msg("quest.运输");
		override public function getName():String  {
			return D;
		}
	
	}
}
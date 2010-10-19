package roma.logic.rule.questActionRule{
	import roma.util.MultiLang;

	/**
	 * 给玩家写信任务事件
	 */
	public class MailQuestEvent extends BaseRuleEvent{
		public function MailQuestEvent(){
		}
	
		private static var G:String = MultiLang.msg("quest.mailAction");
		
		override public function getName():String{
			return G;
		}
	
	}
}

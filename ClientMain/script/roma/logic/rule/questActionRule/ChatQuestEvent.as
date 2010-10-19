package roma.logic.rule.questActionRule{

	import roma.util.MultiLang;

	/**
	 * 聊天任务时间:世界频道聊天,联盟频道聊天
	 */
	public class ChatQuestEvent extends BaseRuleEvent{
		private var name:String="";
		private static var A:String = MultiLang.msg("quest.chatAction.alliance");
		private static var B:String = MultiLang.msg("quest.chatAction.world");
	
		public function ChatQuestEvent() {
		}
		
		override public function getName():String{
			for(var s:String in ruleData){
				if(s == "word"){
					this.name = B;
				}
				else if(s == "alliance"){
					this.name = A;
				}
			}
			return this.name;
		}
	}
}

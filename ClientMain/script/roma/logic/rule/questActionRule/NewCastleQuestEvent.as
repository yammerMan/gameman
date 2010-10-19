package roma.logic.rule.questActionRule{
	import roma.util.MultiLang;
	
	/**
	 * 新建城池任务目标
	 */
	public class NewCastleQuestEvent extends BaseRuleEvent{
		private var name:String;
		public function NewCastleQuestEvent():void {
			this.name = H;
		}
	
		private static var H:String = MultiLang.msg("quest.newCastleAction");
		override public function getName():String  {
			return name;
		}
	
	}
}
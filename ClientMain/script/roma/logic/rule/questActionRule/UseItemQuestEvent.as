package roma.logic.rule.questActionRule{
	import mx.resources.ResourceManager;
	
	import roma.util.MultiLang;
	
	/**
	 * 使用物品任务事件
	 */
	public class UseItemQuestEvent extends BaseRuleEvent{
		private var name:String ;
		public function UseItemQuestEvent(){
		/* 		this.itemId = itemId;
			this.name = ItemHelper.getInstance().getItemRuleById(itemId).getName(); */
		}
	
		private static var D:String = "quest.useItemAction{0}";
		override public function getName():String {
			var itemN:String = ResourceManager.getInstance().getString("item",ruleData.itemId+".name");
			return MultiLang.msg(D,itemN);
		}
	}
}
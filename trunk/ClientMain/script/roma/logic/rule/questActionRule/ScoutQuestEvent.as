package roma.logic.rule.questActionRule{
	import roma.util.MultiLang;
	
	/**
	 * 出征任务事件
	 * 出征类型:侦查,运输,派遣,攻击(占领)
	 * 事件触发条件为动作执行,不管动作执行是否成功,比如:侦查动作可能有侦查失败,但也属于已经出发了侦查事件,在此情况下就认为任务完成
	 */
	public class ScoutQuestEvent extends BaseRuleEvent{
		private var name:String;
		private static var D:String = MultiLang.msg("quest.scoutField");
		private static var E:String  = MultiLang.msg("quest.scoutCastle");
		
		public function ScoutQuestEvent() {
		}
	
		override public function getName():String {
			if(ruleData.scout.targetType == "field"){
				name = D;
			}
			else if(ruleData.scout.targetType == "castle"){
				name = E;
			}
			return name;
		}
	}
}
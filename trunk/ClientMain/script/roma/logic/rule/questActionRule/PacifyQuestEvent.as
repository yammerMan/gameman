package roma.logic.rule.questActionRule{
	import roma.util.MultiLang;
	
	/**
	 * 赈灾,祈福,祭天,添丁任务事件
	 */
	public class PacifyQuestEvent extends BaseRuleEvent{
		private var name:String;
	
		private static var I:String = MultiLang.msg("townHall.pacify_type_relief");
		private static var J:String = MultiLang.msg("townHall.pacify_type_pray");
		private static var K:String = MultiLang.msg("quest.pacify.jitian");
		private static var L:String = MultiLang.msg("townHall.pacify_type_raise_popu");		
		public function PacifyQuestEvent() {
		}
	
		override public function getName():String {			for(var s:String in ruleData){				switch(s){					case "zhenzai":					this.name = I;					break;					case "qifu":					this.name = J;					break;					case "jitian":					this.name = K;					break;					case "tianding":					this.name = L;					break;				}			}
			return name;
		}
	
	}
}
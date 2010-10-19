package roma.logic.rule.questActionRule
{
	import roma.util.MultiLang;
	
	public class PlunderFieldQuestRule extends BaseRuleEvent
	{
		public function PlunderFieldQuestRule()
		{
			super();
		}
		
		private static var PF:String = MultiLang.msg("quest.plunderField");
		
		override public function getName():String{
			return PF;
		}
	}
}
package roma.logic.rule.questActionRule
{
	import roma.util.MultiLang;
	
	public class WinInNpcFieldQuestEvent extends BaseRuleEvent
	{
		public function WinInNpcFieldQuestEvent()
		{
		}
		
		override public function getName():String{
			return MultiLang.msg("quest.winInNpcField{0}",ruleData.index);
		}
		
	}
}
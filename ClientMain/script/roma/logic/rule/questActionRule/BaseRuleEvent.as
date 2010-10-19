package roma.logic.rule.questActionRule
{
	import roma.logic.rule.questPopRule.IQuestTargetRule;
	
	
	public  class BaseRuleEvent implements IQuestTargetRule
	{
		public var ruleData:Object = {};
		public function BaseRuleEvent()
		{
		}

		public function getName():String
		{
			return null;
		}
		
	}
}
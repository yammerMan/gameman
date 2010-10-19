package roma.logic.rule.questPopRule
{
	import roma.util.MultiLang;
	
	/**
	 * 铜币总量达到，任务目标逻辑
	 *
	 */
	public class GoldTotalQuestRule extends BaseRuleProp
	{
		public function GoldTotalQuestRule()
		{
		}
		
		override public function getName():String {
			return MultiLang.msg("quest.goldYield{0}", ruleData.count);
		}
	}
}
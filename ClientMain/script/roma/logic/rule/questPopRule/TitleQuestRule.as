package roma.logic.rule.questPopRule
{
	import roma.util.MultiLang;
	
	public class TitleQuestRule extends BaseRuleProp
	{
		public function TitleQuestRule()
		{
			super();
		}
		
		override public function getName():String{
			var str:String = MultiLang.getPlayerTitle(ruleData.level);
			return MultiLang.msg('quest.title.require',str);
		}
		
	}
}
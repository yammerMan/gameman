package roma.logic.rule.questPopRule
{
	import roma.util.MultiLang;
	
	public class CollectGameSiteRule extends BaseRuleProp
	{
		public function CollectGameSiteRule()
		{
			super();
		}
		
		override public function getName():String {
			return MultiLang.msg('quest.favorite');
		}
		
	}
}
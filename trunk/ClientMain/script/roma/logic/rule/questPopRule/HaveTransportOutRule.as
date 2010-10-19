package roma.logic.rule.questPopRule
{
	import roma.util.MultiLang;
	
	public class HaveTransportOutRule extends BaseRuleProp
	{
		public function HaveTransportOutRule()
		{
			super();
		}
		
		override public function getName():String{
			return MultiLang.msg("quest.create.supplyLine");
		}
	}
}
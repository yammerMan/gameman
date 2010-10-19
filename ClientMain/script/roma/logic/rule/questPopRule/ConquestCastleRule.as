package roma.logic.rule.questPopRule
{
	import roma.util.MultiLang;
	
	public class ConquestCastleRule extends BaseRuleProp
	{
		public function ConquestCastleRule()
		{
			super();
		}
		
		override public function getName():String{
			return MultiLang.msg("quest.conquestCastle",ruleData.value);
		}
	}
}
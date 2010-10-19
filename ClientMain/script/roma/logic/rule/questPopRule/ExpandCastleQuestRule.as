package roma.logic.rule.questPopRule
{
	import roma.util.MultiLang;
	
	public class ExpandCastleQuestRule extends BaseRuleProp
	{
		public function ExpandCastleQuestRule()
		{
			super();
		}
		
		private static var E:String = MultiLang.msg('quest.expandCastle');
		
		override public function getName():String{
			return E;
		}
	}
}
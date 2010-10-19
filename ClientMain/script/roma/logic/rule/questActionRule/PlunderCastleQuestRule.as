package roma.logic.rule.questActionRule
{
	import roma.util.MultiLang;
	
	public class PlunderCastleQuestRule extends BaseRuleEvent
	{
		public function PlunderCastleQuestRule()
		{
			super();
		}
		
		private static var PC:String = MultiLang.msg("quest.plunderCastle");
		override public function getName():String{
			return PC;
		}
	}
}
package roma.logic.rule.questPopRule
{
	import roma.util.MultiLang;
	
	public class GodQuestRule extends BaseRuleProp
	{
		public function GodQuestRule()
		{
			super();
		}
		
		private static var G:String = MultiLang.msg("quest.havaGod");
		
		override public function getName():String{
			return G;
		}
	}
}
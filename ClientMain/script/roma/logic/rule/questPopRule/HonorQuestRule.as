package roma.logic.rule.questPopRule
{
	import roma.util.MultiLang;
	
	public class HonorQuestRule extends BaseRuleProp
	{
		public function HonorQuestRule()
		{
			super();
		}
		
		private static var H:String = "quest.honor{0}"
		
		override public function getName():String{
			return MultiLang.msg(H,ruleData.value);
		}
	}
}
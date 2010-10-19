package roma.logic.rule.questPopRule
{
	import roma.util.MultiLang;
	
	public class InIncreaseBuildingLimit extends BaseRuleProp
	{
		public function InIncreaseBuildingLimit()
		{
			super();
		}
		private static var W:String = "quest.inIncreaseBuildingLimit"
		override public function getName():String{
			return MultiLang.msg(W);
		}
	}
}
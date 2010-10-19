package roma.logic.rule.questPopRule
{
	import roma.util.MultiLang;
	
	import views.spreadUI.tech.WorkerHelper;
	
	public class WorkerQuestRule extends BaseRuleProp
	{
		public function WorkerQuestRule()
		{
			super();
		}
		private static var W:String = "quest.workerCount{0}{1}"
		override public function getName():String{
			var wn:String = WorkerHelper.instance.getWorkerUnitName(ruleData.type);
			return MultiLang.msg(W,wn,ruleData.count);
		}
	}
}
package roma.logic.rule.questPopRule{
	import roma.util.MultiLang;
	

	/**
	 * 攻击:野地,城池
	 * 
	 */
	public class AttackFieldQuestRule extends BaseRuleProp{

		private static var G:String  = MultiLang.msg("quest.seizefield");
		override public function getName():String {
			return MultiLang.msg("quest.seizefield",this.ruleData.level);
		}

	}
}
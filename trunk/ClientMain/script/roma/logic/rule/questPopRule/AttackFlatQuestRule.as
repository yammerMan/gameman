package roma.logic.rule.questPopRule{

	/**
	 * 攻击:占领平地
	 *
	 */
	public class AttackFlatQuestRule extends BaseRuleProp{
		private var level:int;
		public AttackFlatQuestRule() {
		}
	
		private static var String G = Lang.msg("quest.占领平地");
		override public function getName():String {
			return G;
		}
	
	}
}
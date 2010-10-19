package roma.logic.rule.questActionRule{	import roma.logic.rule.questPopRule.BaseRuleProp;
	import roma.util.MultiLang;
	
	/**
	 * 招募将领
	 */
	public class HireHeroQuestEvent extends BaseRuleProp{
	
		public function HireHeroQuestEvent() {
		}
	
		private static var F:String = MultiLang.msg("quest.hireHeroAction");
		
		override public function getName():String {
			return F;
		}
	}
}
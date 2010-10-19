package roma.logic.rule.questActionRule{
	import roma.util.MultiLang;
	/**
	 * 升级将领，给将领分配属性
	 */
	public class UpgradeHeroQuestEvent extends BaseRuleEvent{
		public function UpgradeHeroQuestEvent() {
		}
		private static var D:String = MultiLang.msg("quest.upgradeChiefAction");
		override public function getName():String {
			return D;
		}
	}
}
package roma.logic.rule.questActionRule{
import roma.util.MultiLang;

/**
 * 伤兵治疗任务事件
 *
 */
public class CureInjuredQuestEvent extends BaseRuleEvent{
	public function CureInjuredQuestEvent() {
	}

	private static var E:String = MultiLang.msg("quest.cureInjuredAction");

	override public function getName():String {
		return E;
	}

}
}
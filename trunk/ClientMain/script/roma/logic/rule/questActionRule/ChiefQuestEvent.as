package roma.logic.rule.questActionRule{
import roma.logic.rule.questPopRule.BaseRuleProp;
import roma.util.MultiLang;
/**
 * 任命城守任务事件
 */
public class ChiefQuestEvent extends BaseRuleProp{

	public function ChiefQuestEvent() {
	}

	private static var C:String =MultiLang.msg("hero.promoteChief");
	
	override public function getName():String {		return C;
	}

}}

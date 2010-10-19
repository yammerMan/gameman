package roma.logic.rule.questActionRule
/**
 * 行为型任务事件
 */
public class ActionQuestEvent extends BaseRuleEvent{
	
	public ActionQuestEvent(qId:int){
		this.taskId = qId;
	}

	public int getTaskId() {
		return this.taskId;
	}

}

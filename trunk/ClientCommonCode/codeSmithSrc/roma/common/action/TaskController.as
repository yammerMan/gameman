/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.quest.QuestCategoryResponse
	import roma.common.controller.quest.FinishedQuestCountResponse
	import roma.common.controller.quest.TaskListResponse
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class TaskController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function finishedQuestCount(cityId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.quest.FinishedQuestCountResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送finishedQuestCount时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTaskControllerFinishedQuestCountCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				ControllerFactory.getInstance().client.sendMessage(149 , params);
			}
			return null;
		}

		public function getAward(cityId:int,taskId:int,answers:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getAward时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTaskControllerGetAwardCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.taskId = taskId;
				params.answers = answers;
				ControllerFactory.getInstance().client.sendMessage(150 , params);
			}
			return null;
		}

		public function getQuestTypeList(cityId:int,typeId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.quest.QuestCategoryResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getQuestTypeList时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTaskControllerGetQuestTypeListCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.typeId = typeId;
				ControllerFactory.getInstance().client.sendMessage(151 , params);
			}
			return null;
		}

		public function getTaskList(cityId:int,categoryId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.quest.TaskListResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getTaskList时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTaskControllerGetTaskListCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.categoryId = categoryId;
				ControllerFactory.getInstance().client.sendMessage(152 , params);
			}
			return null;
		}

	 }
}
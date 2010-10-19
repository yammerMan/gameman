/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class TechController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function cancelTechResearch(cityId:int,position:int,id:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送cancelTechResearch时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTechControllerCancelTechResearchCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.position = position;
				params.id = id;
				ControllerFactory.getInstance().client.sendMessage(169 , params);
			}
			return null;
		}

		public function speedUpResearch(cityId:int,position:int,id:int,itemId:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送speedUpResearch时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTechControllerSpeedUpResearchCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.position = position;
				params.id = id;
				params.itemId = itemId;
				ControllerFactory.getInstance().client.sendMessage(170 , params);
			}
			return null;
		}

		public function startResearch(cityId:int,position:int,id:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送startResearch时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTechControllerStartResearchCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.position = position;
				params.id = id;
				ControllerFactory.getInstance().client.sendMessage(171 , params);
			}
			return null;
		}

	 }
}
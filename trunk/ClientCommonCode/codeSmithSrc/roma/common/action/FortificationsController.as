/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.troop.MayFinishAllResponse
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class FortificationsController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function cancelProduce(cityId:int,queue:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送cancelProduce时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onFortificationsControllerCancelProduceCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.queue = queue;
				ControllerFactory.getInstance().client.sendMessage(107 , params);
			}
			return null;
		}

		public function destructFortification(cityId:int,fortificationType:int,num:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送destructFortification时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onFortificationsControllerDestructFortificationCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.fortificationType = fortificationType;
				params.num = num;
				ControllerFactory.getInstance().client.sendMessage(108 , params);
			}
			return null;
		}

		public function produceFortification(cityId:int,fortificationType:int,num:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送produceFortification时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onFortificationsControllerProduceFortificationCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.fortificationType = fortificationType;
				params.num = num;
				ControllerFactory.getInstance().client.sendMessage(109 , params);
			}
			return null;
		}

		public function speedFortificationProduce(cityId:int,queue:int,itemId:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.troop.MayFinishAllResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送speedFortificationProduce时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onFortificationsControllerSpeedFortificationProduceCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.queue = queue;
				params.itemId = itemId;
				ControllerFactory.getInstance().client.sendMessage(110 , params);
			}
			return null;
		}

	 }
}
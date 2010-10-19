/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.debug.EchoResponse
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class DebugController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function echo(seconds:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.debug.EchoResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送echo时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onDebugControllerEchoCallback = callback;
				var params:Object=new Object();
				params.seconds = seconds;
				ControllerFactory.getInstance().client.sendMessage(98 , params);
			}
			return null;
		}

		public function goToFuture(seconds:Number,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送goToFuture时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onDebugControllerGoToFutureCallback = callback;
				var params:Object=new Object();
				params.seconds = seconds;
				ControllerFactory.getInstance().client.sendMessage(99 , params);
			}
			return null;
		}

		public function refreshResource(cityId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送refreshResource时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onDebugControllerRefreshResourceCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				ControllerFactory.getInstance().client.sendMessage(100 , params);
			}
			return null;
		}

	 }
}
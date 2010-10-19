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
	public class ChatController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function chat(channel:int,content:String,target:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送chat时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onChatControllerChatCallback = callback;
				var params:Object=new Object();
				params.channel = channel;
				params.content = content;
				params.target = target;
				ControllerFactory.getInstance().client.sendMessage(89 , params);
			}
			return null;
		}

		public function enterChannel(channel:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送enterChannel时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onChatControllerEnterChannelCallback = callback;
				var params:Object=new Object();
				params.channel = channel;
				ControllerFactory.getInstance().client.sendMessage(90 , params);
			}
			return null;
		}

		public function quitChannel(channel:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送quitChannel时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onChatControllerQuitChannelCallback = callback;
				var params:Object=new Object();
				params.channel = channel;
				ControllerFactory.getInstance().client.sendMessage(91 , params);
			}
			return null;
		}

	 }
}
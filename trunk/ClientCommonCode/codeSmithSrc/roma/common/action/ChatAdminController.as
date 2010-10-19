/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.chat.PlayerResponse
	import roma.common.controller.user.GmLoginResponse
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class ChatAdminController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function cancelNoChatBuff(playerName:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送cancelNoChatBuff时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onChatAdminControllerCancelNoChatBuffCallback = callback;
				var params:Object=new Object();
				params.playerName = playerName;
				ControllerFactory.getInstance().client.sendMessage(84 , params);
			}
			return null;
		}

		public function gmLogin(accoutname:String,password:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.user.GmLoginResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送gmLogin时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onChatAdminControllerGmLoginCallback = callback;
				var params:Object=new Object();
				params.accoutname = accoutname;
				params.password = password;
				ControllerFactory.getInstance().client.sendMessage(85 , params);
			}
			return null;
		}

		public function screenChat(name:String,mins:int,knowByUser:Boolean,makeAnnounce:Boolean,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送screenChat时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onChatAdminControllerScreenChatCallback = callback;
				var params:Object=new Object();
				params.name = name;
				params.mins = mins;
				params.knowByUser = knowByUser;
				params.makeAnnounce = makeAnnounce;
				ControllerFactory.getInstance().client.sendMessage(86 , params);
			}
			return null;
		}

		public function searchPlayerByName(name:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.chat.PlayerResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送searchPlayerByName时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onChatAdminControllerSearchPlayerByNameCallback = callback;
				var params:Object=new Object();
				params.name = name;
				ControllerFactory.getInstance().client.sendMessage(87 , params);
			}
			return null;
		}

		public function sendAdminMessage(channel:int,content:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送sendAdminMessage时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onChatAdminControllerSendAdminMessageCallback = callback;
				var params:Object=new Object();
				params.channel = channel;
				params.content = content;
				ControllerFactory.getInstance().client.sendMessage(88 , params);
			}
			return null;
		}

	 }
}
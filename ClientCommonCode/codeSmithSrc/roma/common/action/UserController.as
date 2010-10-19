/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.user.EnterResponse
	import roma.common.valueObject.*
	
	//command
	public class UserController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function autoLogin(accountName:String,playerName:String,authToken:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.user.EnterResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送autoLogin时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onUserControllerAutoLoginCallback = callback;
				var params:Object=new Object();
				params.accountName = accountName;
				params.playerName = playerName;
				params.authToken = authToken;
				ControllerFactory.getInstance().client.sendMessage(187 , params);
			}
			return null;
		}

		public function createPlayer(playerName:String,cityName:String,logoUrl:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.user.EnterResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送createPlayer时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onUserControllerCreatePlayerCallback = callback;
				var params:Object=new Object();
				params.playerName = playerName;
				params.cityName = cityName;
				params.logoUrl = logoUrl;
				ControllerFactory.getInstance().client.sendMessage(188 , params);
			}
			return null;
		}

		public function login(accoutname:String,playerName:String,password:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.user.EnterResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送login时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onUserControllerLoginCallback = callback;
				var params:Object=new Object();
				params.accoutname = accoutname;
				params.playerName = playerName;
				params.password = password;
				ControllerFactory.getInstance().client.sendMessage(189 , params);
			}
			return null;
		}

	 }
}
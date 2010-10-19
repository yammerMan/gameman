/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.alliance.SelfAllianceInfoResponse
	import roma.common.controller.alliance.AllianceInfoOfOutResponse
	import roma.common.controller.alliance.AllianceInfoDataResponse
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class OutOfAllianceController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function acceptInvite(allianceId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送acceptInvite时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onOutOfAllianceControllerAcceptInviteCallback = callback;
				var params:Object=new Object();
				params.allianceId = allianceId;
				ControllerFactory.getInstance().client.sendMessage(25 , params);
			}
			return null;
		}

		public function allianceInfoOfOut(callback:Function=null,checkSending:Boolean=true):roma.common.controller.alliance.AllianceInfoOfOutResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送allianceInfoOfOut时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onOutOfAllianceControllerAllianceInfoOfOutCallback = callback;
				var params:Object=new Object();
				ControllerFactory.getInstance().client.sendMessage(26 , params);
			}
			return null;
		}

		public function apply(allianceId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送apply时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onOutOfAllianceControllerApplyCallback = callback;
				var params:Object=new Object();
				params.allianceId = allianceId;
				ControllerFactory.getInstance().client.sendMessage(27 , params);
			}
			return null;
		}

		public function cacelApply(allianceId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送cacelApply时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onOutOfAllianceControllerCacelApplyCallback = callback;
				var params:Object=new Object();
				params.allianceId = allianceId;
				ControllerFactory.getInstance().client.sendMessage(28 , params);
			}
			return null;
		}

		public function createLeague(cityId:int,leagueName:String,logoCode:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.alliance.SelfAllianceInfoResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送createLeague时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onOutOfAllianceControllerCreateLeagueCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.leagueName = leagueName;
				params.logoCode = logoCode;
				ControllerFactory.getInstance().client.sendMessage(29 , params);
			}
			return null;
		}

		public function getLeagueInfo(allianceId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.alliance.AllianceInfoDataResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getLeagueInfo时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onOutOfAllianceControllerGetLeagueInfoCallback = callback;
				var params:Object=new Object();
				params.allianceId = allianceId;
				ControllerFactory.getInstance().client.sendMessage(30 , params);
			}
			return null;
		}

		public function refuseInvite(allianceId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送refuseInvite时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onOutOfAllianceControllerRefuseInviteCallback = callback;
				var params:Object=new Object();
				params.allianceId = allianceId;
				ControllerFactory.getInstance().client.sendMessage(31 , params);
			}
			return null;
		}

	 }
}
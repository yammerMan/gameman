/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.alliance.AllianceInviteListResponse
	import roma.common.controller.alliance.AllianceApplyListResponse
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class AllianceManagementController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function agreeApply(playerId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送agreeApply时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceManagementControllerAgreeApplyCallback = callback;
				var params:Object=new Object();
				params.playerId = playerId;
				ControllerFactory.getInstance().client.sendMessage(11 , params);
			}
			return null;
		}

		public function cancelInvite(name:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送cancelInvite时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceManagementControllerCancelInviteCallback = callback;
				var params:Object=new Object();
				params.name = name;
				ControllerFactory.getInstance().client.sendMessage(12 , params);
			}
			return null;
		}

		public function deleteAllianceRelation(targetAllianceName:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送deleteAllianceRelation时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceManagementControllerDeleteAllianceRelationCallback = callback;
				var params:Object=new Object();
				params.targetAllianceName = targetAllianceName;
				ControllerFactory.getInstance().client.sendMessage(13 , params);
			}
			return null;
		}

		public function getAppliedPlayerList(callback:Function=null,checkSending:Boolean=true):roma.common.controller.alliance.AllianceApplyListResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getAppliedPlayerList时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceManagementControllerGetAppliedPlayerListCallback = callback;
				var params:Object=new Object();
				ControllerFactory.getInstance().client.sendMessage(14 , params);
			}
			return null;
		}

		public function getInvitedPlayerList(callback:Function=null,checkSending:Boolean=true):roma.common.controller.alliance.AllianceInviteListResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getInvitedPlayerList时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceManagementControllerGetInvitedPlayerListCallback = callback;
				var params:Object=new Object();
				ControllerFactory.getInstance().client.sendMessage(15 , params);
			}
			return null;
		}

		public function inviteToAlliance(name:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送inviteToAlliance时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceManagementControllerInviteToAllianceCallback = callback;
				var params:Object=new Object();
				params.name = name;
				ControllerFactory.getInstance().client.sendMessage(16 , params);
			}
			return null;
		}

		public function kickOut(playerId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送kickOut时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceManagementControllerKickOutCallback = callback;
				var params:Object=new Object();
				params.playerId = playerId;
				ControllerFactory.getInstance().client.sendMessage(17 , params);
			}
			return null;
		}

		public function messagesForAll(title:String,content:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送messagesForAll时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceManagementControllerMessagesForAllCallback = callback;
				var params:Object=new Object();
				params.title = title;
				params.content = content;
				ControllerFactory.getInstance().client.sendMessage(18 , params);
			}
			return null;
		}

		public function quit(callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送quit时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceManagementControllerQuitCallback = callback;
				var params:Object=new Object();
				ControllerFactory.getInstance().client.sendMessage(19 , params);
			}
			return null;
		}

		public function refuseApply(playerId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送refuseApply时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceManagementControllerRefuseApplyCallback = callback;
				var params:Object=new Object();
				params.playerId = playerId;
				ControllerFactory.getInstance().client.sendMessage(20 , params);
			}
			return null;
		}

		public function resign(callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送resign时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceManagementControllerResignCallback = callback;
				var params:Object=new Object();
				ControllerFactory.getInstance().client.sendMessage(21 , params);
			}
			return null;
		}

		public function setAllianceRelation(allianceName:String,type:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送setAllianceRelation时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceManagementControllerSetAllianceRelationCallback = callback;
				var params:Object=new Object();
				params.allianceName = allianceName;
				params.type = type;
				ControllerFactory.getInstance().client.sendMessage(22 , params);
			}
			return null;
		}

		public function setLeagueInfo(info:String,note:String,allianceUrl:String,allianceLimit:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送setLeagueInfo时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceManagementControllerSetLeagueInfoCallback = callback;
				var params:Object=new Object();
				params.info = info;
				params.note = note;
				params.allianceUrl = allianceUrl;
				params.allianceLimit = allianceLimit;
				ControllerFactory.getInstance().client.sendMessage(23 , params);
			}
			return null;
		}

		public function setPowerAlliance(playerId:int,typeId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送setPowerAlliance时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceManagementControllerSetPowerAllianceCallback = callback;
				var params:Object=new Object();
				params.playerId = playerId;
				params.typeId = typeId;
				ControllerFactory.getInstance().client.sendMessage(24 , params);
			}
			return null;
		}

	 }
}
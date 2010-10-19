/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.player.PlayerCastleResponse
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class PlayerController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function addOrUpdateFieldCollect(fieldId:int,remark:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送addOrUpdateFieldCollect时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onPlayerControllerAddOrUpdateFieldCollectCallback = callback;
				var params:Object=new Object();
				params.fieldId = fieldId;
				params.remark = remark;
				ControllerFactory.getInstance().client.sendMessage(137 , params);
			}
			return null;
		}

		public function cancelTruce(yes:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送cancelTruce时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onPlayerControllerCancelTruceCallback = callback;
				var params:Object=new Object();
				params.yes = yes;
				ControllerFactory.getInstance().client.sendMessage(138 , params);
			}
			return null;
		}

		public function changeFlag(aNewFlag:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送changeFlag时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onPlayerControllerChangeFlagCallback = callback;
				var params:Object=new Object();
				params.aNewFlag = aNewFlag;
				ControllerFactory.getInstance().client.sendMessage(139 , params);
			}
			return null;
		}

		public function changeLogo(logoCode:String,sex:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送changeLogo时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onPlayerControllerChangeLogoCallback = callback;
				var params:Object=new Object();
				params.logoCode = logoCode;
				params.sex = sex;
				ControllerFactory.getInstance().client.sendMessage(140 , params);
			}
			return null;
		}

		public function deleteFieldCollect(idField:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送deleteFieldCollect时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onPlayerControllerDeleteFieldCollectCallback = callback;
				var params:Object=new Object();
				params.idField = idField;
				ControllerFactory.getInstance().client.sendMessage(141 , params);
			}
			return null;
		}

		public function getPlayerCastles(playerId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.player.PlayerCastleResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getPlayerCastles时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onPlayerControllerGetPlayerCastlesCallback = callback;
				var params:Object=new Object();
				params.playerId = playerId;
				ControllerFactory.getInstance().client.sendMessage(142 , params);
			}
			return null;
		}

		public function modifyPlayerName(newName:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送modifyPlayerName时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onPlayerControllerModifyPlayerNameCallback = callback;
				var params:Object=new Object();
				params.newName = newName;
				ControllerFactory.getInstance().client.sendMessage(143 , params);
			}
			return null;
		}

		public function modifyPlayerSignature(newSignature:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送modifyPlayerSignature时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onPlayerControllerModifyPlayerSignatureCallback = callback;
				var params:Object=new Object();
				params.newSignature = newSignature;
				ControllerFactory.getInstance().client.sendMessage(144 , params);
			}
			return null;
		}

		public function removeUiBuff(cityId:int,buffType:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送removeUiBuff时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onPlayerControllerRemoveUiBuffCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.buffType = buffType;
				ControllerFactory.getInstance().client.sendMessage(145 , params);
			}
			return null;
		}

		public function restart(callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送restart时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onPlayerControllerRestartCallback = callback;
				var params:Object=new Object();
				ControllerFactory.getInstance().client.sendMessage(146 , params);
			}
			return null;
		}

		public function sendSpy(playerId:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送sendSpy时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onPlayerControllerSendSpyCallback = callback;
				var params:Object=new Object();
				params.playerId = playerId;
				ControllerFactory.getInstance().client.sendMessage(147 , params);
			}
			return null;
		}

		public function truce(yes:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送truce时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onPlayerControllerTruceCallback = callback;
				var params:Object=new Object();
				params.yes = yes;
				ControllerFactory.getInstance().client.sendMessage(148 , params);
			}
			return null;
		}

	 }
}
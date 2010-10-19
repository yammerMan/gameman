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
	import roma.common.controller.alliance.AllianceMessageListResponse
	import roma.common.controller.alliance.AllianceRelactionResponse
	import roma.common.controller.alliance.AllianceMemberListResponse
	import roma.common.controller.alliance.MilitaryListResponse
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class AllianceController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function allianceUseItem(itemId:String,num:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送allianceUseItem时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceControllerAllianceUseItemCallback = callback;
				var params:Object=new Object();
				params.itemId = itemId;
				params.num = num;
				ControllerFactory.getInstance().client.sendMessage(0 , params);
			}
			return null;
		}

		public function changeAllianceLogoAndName(newLogo:int,newName:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送changeAllianceLogoAndName时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceControllerChangeAllianceLogoAndNameCallback = callback;
				var params:Object=new Object();
				params.newLogo = newLogo;
				params.newName = newName;
				ControllerFactory.getInstance().client.sendMessage(1 , params);
			}
			return null;
		}

		public function contributeItem(itemId:String,num:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送contributeItem时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceControllerContributeItemCallback = callback;
				var params:Object=new Object();
				params.itemId = itemId;
				params.num = num;
				ControllerFactory.getInstance().client.sendMessage(2 , params);
			}
			return null;
		}

		public function contributeResource(cityId:int,foods:int,woods:int,stones:int,irons:int,golds:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送contributeResource时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceControllerContributeResourceCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.foods = foods;
				params.woods = woods;
				params.stones = stones;
				params.irons = irons;
				params.golds = golds;
				ControllerFactory.getInstance().client.sendMessage(3 , params);
			}
			return null;
		}

		public function getAllianceMemberList(callback:Function=null,checkSending:Boolean=true):roma.common.controller.alliance.AllianceMemberListResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getAllianceMemberList时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceControllerGetAllianceMemberListCallback = callback;
				var params:Object=new Object();
				ControllerFactory.getInstance().client.sendMessage(4 , params);
			}
			return null;
		}

		public function getAllianceRalation(callback:Function=null,checkSending:Boolean=true):roma.common.controller.alliance.AllianceRelactionResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getAllianceRalation时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceControllerGetAllianceRalationCallback = callback;
				var params:Object=new Object();
				ControllerFactory.getInstance().client.sendMessage(5 , params);
			}
			return null;
		}

		public function getLeagueEventList(page:int,size:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.alliance.AllianceMessageListResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getLeagueEventList时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceControllerGetLeagueEventListCallback = callback;
				var params:Object=new Object();
				params.page = page;
				params.size = size;
				ControllerFactory.getInstance().client.sendMessage(6 , params);
			}
			return null;
		}

		public function getMilitarys(page:int,size:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.alliance.MilitaryListResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getMilitarys时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceControllerGetMilitarysCallback = callback;
				var params:Object=new Object();
				params.page = page;
				params.size = size;
				ControllerFactory.getInstance().client.sendMessage(7 , params);
			}
			return null;
		}

		public function getSelfAllianceInfo(callback:Function=null,checkSending:Boolean=true):roma.common.controller.alliance.SelfAllianceInfoResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getSelfAllianceInfo时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceControllerGetSelfAllianceInfoCallback = callback;
				var params:Object=new Object();
				ControllerFactory.getInstance().client.sendMessage(8 , params);
			}
			return null;
		}

		public function levelUp10ByItem(callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送levelUp10ByItem时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceControllerLevelUp10ByItemCallback = callback;
				var params:Object=new Object();
				ControllerFactory.getInstance().client.sendMessage(9 , params);
			}
			return null;
		}

		public function reachLevel(callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送reachLevel时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onAllianceControllerReachLevelCallback = callback;
				var params:Object=new Object();
				ControllerFactory.getInstance().client.sendMessage(10 , params);
			}
			return null;
		}

	 }
}
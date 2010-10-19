/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.common.RollTextResponse
	import roma.common.controller.common.MapInfo2Response
	import roma.common.controller.common.AllianceInfoResponse
	import roma.common.controller.common.ZoneInfoDataResponse
	import roma.common.controller.common.MapFieldInfoResponse
	import roma.common.controller.common.MapDataResponse
	import roma.common.valueObject.*
	
	//command
	public class CommonController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function getLeagueInfo(leagueName:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.common.AllianceInfoResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getLeagueInfo时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCommonControllerGetLeagueInfoCallback = callback;
				var params:Object=new Object();
				params.leagueName = leagueName;
				ControllerFactory.getInstance().client.sendMessage(92 , params);
			}
			return null;
		}

		public function mapDesc(x:int,y:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.common.MapDataResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送mapDesc时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCommonControllerMapDescCallback = callback;
				var params:Object=new Object();
				params.x = x;
				params.y = y;
				ControllerFactory.getInstance().client.sendMessage(93 , params);
			}
			return null;
		}

		public function mapFieldInfo(cityId:int,x:int,y:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.common.MapFieldInfoResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送mapFieldInfo时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCommonControllerMapFieldInfoCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.x = x;
				params.y = y;
				ControllerFactory.getInstance().client.sendMessage(94 , params);
			}
			return null;
		}

		public function mapInfo2(x:int,y:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.common.MapInfo2Response {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送mapInfo2时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCommonControllerMapInfo2Callback = callback;
				var params:Object=new Object();
				params.x = x;
				params.y = y;
				ControllerFactory.getInstance().client.sendMessage(95 , params);
			}
			return null;
		}

		public function rollText(callback:Function=null,checkSending:Boolean=true):roma.common.controller.common.RollTextResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送rollText时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCommonControllerRollTextCallback = callback;
				var params:Object=new Object();
				ControllerFactory.getInstance().client.sendMessage(96 , params);
			}
			return null;
		}

		public function zoneInfomation(callback:Function=null,checkSending:Boolean=true):roma.common.controller.common.ZoneInfoDataResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送zoneInfomation时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCommonControllerZoneInfomationCallback = callback;
				var params:Object=new Object();
				ControllerFactory.getInstance().client.sendMessage(97 , params);
			}
			return null;
		}

	 }
}
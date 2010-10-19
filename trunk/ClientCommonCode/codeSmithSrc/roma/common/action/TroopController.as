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
	public class TroopController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function cancelProduce(cityId:int,position:int,queue:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送cancelProduce时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTroopControllerCancelProduceCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.position = position;
				params.queue = queue;
				ControllerFactory.getInstance().client.sendMessage(183 , params);
			}
			return null;
		}

		public function disbandTroops(cityId:int,position:int,troopType:int,num:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送disbandTroops时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTroopControllerDisbandTroopsCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.position = position;
				params.troopType = troopType;
				params.num = num;
				ControllerFactory.getInstance().client.sendMessage(184 , params);
			}
			return null;
		}

		public function produceMoreTroop(cityId:int,position:int,troopType:int,num:int,method:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送produceMoreTroop时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTroopControllerProduceMoreTroopCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.position = position;
				params.troopType = troopType;
				params.num = num;
				params.method = method;
				ControllerFactory.getInstance().client.sendMessage(185 , params);
			}
			return null;
		}

		public function speedTroopProduce(cityId:int,position:int,queue:int,itemId:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.troop.MayFinishAllResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送speedTroopProduce时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTroopControllerSpeedTroopProduceCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.position = position;
				params.queue = queue;
				params.itemId = itemId;
				ControllerFactory.getInstance().client.sendMessage(186 , params);
			}
			return null;
		}

	 }
}
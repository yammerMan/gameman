/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.trade.TransingMaterialListResponse
	import roma.common.controller.trade.BusenissListResponse
	import roma.common.controller.trade.SearchTradeResponse
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class TradeController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function cancelCityTrade(cityId:int,businessId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送cancelCityTrade时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTradeControllerCancelCityTradeCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.businessId = businessId;
				ControllerFactory.getInstance().client.sendMessage(175 , params);
			}
			return null;
		}

		public function createNewTrade(cityId:int,resType:int,type:int,amounts:int,price:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送createNewTrade时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTradeControllerCreateNewTradeCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.resType = resType;
				params.type = type;
				params.amounts = amounts;
				params.price = price;
				ControllerFactory.getInstance().client.sendMessage(176 , params);
			}
			return null;
		}

		public function findTrades(type:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.trade.SearchTradeResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送findTrades时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTradeControllerFindTradesCallback = callback;
				var params:Object=new Object();
				params.type = type;
				ControllerFactory.getInstance().client.sendMessage(177 , params);
			}
			return null;
		}

		public function getSelfTrades(cityId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.trade.BusenissListResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getSelfTrades时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTradeControllerGetSelfTradesCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				ControllerFactory.getInstance().client.sendMessage(178 , params);
			}
			return null;
		}

		public function getTransingTrades(cityId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.trade.TransingMaterialListResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getTransingTrades时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTradeControllerGetTransingTradesCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				ControllerFactory.getInstance().client.sendMessage(179 , params);
			}
			return null;
		}

		public function speedUpTransit(cityId:int,transitTradeId:int,itemId:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送speedUpTransit时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTradeControllerSpeedUpTransitCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.transitTradeId = transitTradeId;
				params.itemId = itemId;
				ControllerFactory.getInstance().client.sendMessage(180 , params);
			}
			return null;
		}

		public function speedupTransport(cityId:int,transportId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送speedupTransport时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTradeControllerSpeedupTransportCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.transportId = transportId;
				ControllerFactory.getInstance().client.sendMessage(181 , params);
			}
			return null;
		}

		public function transport(cityId:int,idField:int,foods:int,woods:int,stones:int,irons:int,golds:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送transport时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onTradeControllerTransportCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.idField = idField;
				params.foods = foods;
				params.woods = woods;
				params.stones = stones;
				params.irons = irons;
				params.golds = golds;
				ControllerFactory.getInstance().client.sendMessage(182 , params);
			}
			return null;
		}

	 }
}
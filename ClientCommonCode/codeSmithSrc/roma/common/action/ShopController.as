/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.shop.UseMaterialResultResponse
	import roma.common.controller.shop.UseRoletteResponse
	import roma.common.controller.shop.PurchaseResourceInfoResponse
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class ShopController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function buyItem(itemId:String,amounts:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送buyItem时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onShopControllerBuyItemCallback = callback;
				var params:Object=new Object();
				params.itemId = itemId;
				params.amounts = amounts;
				ControllerFactory.getInstance().client.sendMessage(164 , params);
			}
			return null;
		}

		public function buyResources(cityId:int,foodCoin:int,woodCoin:int,ironCoin:int,stoneCoin:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送buyResources时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onShopControllerBuyResourcesCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.foodCoin = foodCoin;
				params.woodCoin = woodCoin;
				params.ironCoin = ironCoin;
				params.stoneCoin = stoneCoin;
				ControllerFactory.getInstance().client.sendMessage(165 , params);
			}
			return null;
		}

		public function getBuyResourceDetail(cityId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.shop.PurchaseResourceInfoResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getBuyResourceDetail时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onShopControllerGetBuyResourceDetailCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				ControllerFactory.getInstance().client.sendMessage(166 , params);
			}
			return null;
		}

		public function usePlayerItem(cityId:int,itemId:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.shop.UseMaterialResultResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送usePlayerItem时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onShopControllerUsePlayerItemCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.itemId = itemId;
				ControllerFactory.getInstance().client.sendMessage(167 , params);
			}
			return null;
		}

		public function useRolette(callback:Function=null,checkSending:Boolean=true):roma.common.controller.shop.UseRoletteResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送useRolette时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onShopControllerUseRoletteCallback = callback;
				var params:Object=new Object();
				ControllerFactory.getInstance().client.sendMessage(168 , params);
			}
			return null;
		}

	 }
}
/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.equip.HeroEquipsResponse
	import roma.common.controller.equip.PlayerEquipResponse
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class EquipController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function buyEquip(typeId:String,count:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送buyEquip时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onEquipControllerBuyEquipCallback = callback;
				var params:Object=new Object();
				params.typeId = typeId;
				params.count = count;
				ControllerFactory.getInstance().client.sendMessage(101 , params);
			}
			return null;
		}

		public function destroyEquip(typeId:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送destroyEquip时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onEquipControllerDestroyEquipCallback = callback;
				var params:Object=new Object();
				params.typeId = typeId;
				ControllerFactory.getInstance().client.sendMessage(102 , params);
			}
			return null;
		}

		public function equipForHero(cityId:int,heroId:int,typeId:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送equipForHero时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onEquipControllerEquipForHeroCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				params.typeId = typeId;
				ControllerFactory.getInstance().client.sendMessage(103 , params);
			}
			return null;
		}

		public function getHeroEquips(cityId:int,heroId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.equip.HeroEquipsResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getHeroEquips时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onEquipControllerGetHeroEquipsCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				ControllerFactory.getInstance().client.sendMessage(104 , params);
			}
			return null;
		}

		public function getPlayerEquips(callback:Function=null,checkSending:Boolean=true):roma.common.controller.equip.PlayerEquipResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getPlayerEquips时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onEquipControllerGetPlayerEquipsCallback = callback;
				var params:Object=new Object();
				ControllerFactory.getInstance().client.sendMessage(105 , params);
			}
			return null;
		}

		public function removeHeroEquip(cityId:int,heroId:int,typeId:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送removeHeroEquip时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onEquipControllerRemoveHeroEquipCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				params.typeId = typeId;
				ControllerFactory.getInstance().client.sendMessage(106 , params);
			}
			return null;
		}

	 }
}
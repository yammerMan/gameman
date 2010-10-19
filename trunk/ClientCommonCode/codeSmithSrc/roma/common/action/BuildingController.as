/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class BuildingController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function cancleBuilding(cityId:int,position:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送cancleBuilding时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onBuildingControllerCancleBuildingCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.position = position;
				ControllerFactory.getInstance().client.sendMessage(55 , params);
			}
			return null;
		}

		public function consNewBuilding(cityId:int,position:int,buildingType:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送consNewBuilding时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onBuildingControllerConsNewBuildingCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.position = position;
				params.buildingType = buildingType;
				ControllerFactory.getInstance().client.sendMessage(56 , params);
			}
			return null;
		}

		public function destructDownBuilding(cityId:int,position:int,isComplete:Boolean,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送destructDownBuilding时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onBuildingControllerDestructDownBuildingCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.position = position;
				params.isComplete = isComplete;
				ControllerFactory.getInstance().client.sendMessage(57 , params);
			}
			return null;
		}

		public function increaseConstructLimit(callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送increaseConstructLimit时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onBuildingControllerIncreaseConstructLimitCallback = callback;
				var params:Object=new Object();
				ControllerFactory.getInstance().client.sendMessage(58 , params);
			}
			return null;
		}

		public function speedUpBuilding(cityId:int,position:int,itemId:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送speedUpBuilding时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onBuildingControllerSpeedUpBuildingCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.position = position;
				params.itemId = itemId;
				ControllerFactory.getInstance().client.sendMessage(59 , params);
			}
			return null;
		}

		public function upgradeArchitecture(cityId:int,position:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送upgradeArchitecture时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onBuildingControllerUpgradeArchitectureCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.position = position;
				ControllerFactory.getInstance().client.sendMessage(60 , params);
			}
			return null;
		}

	 }
}
/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.castle.ConquestResourceResponse
	import roma.common.controller.castle.ResourceStaticResponse
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class CityController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function acceptBeConquestedApply(cityId:int,targetCastleId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送acceptBeConquestedApply时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerAcceptBeConquestedApplyCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.targetCastleId = targetCastleId;
				ControllerFactory.getInstance().client.sendMessage(61 , params);
			}
			return null;
		}

		public function advTransCastle(cityId:int,idField:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送advTransCastle时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerAdvTransCastleCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.idField = idField;
				ControllerFactory.getInstance().client.sendMessage(62 , params);
			}
			return null;
		}

		public function applyBeConquested(cityId:int,targetFieldId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送applyBeConquested时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerApplyBeConquestedCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.targetFieldId = targetFieldId;
				ControllerFactory.getInstance().client.sendMessage(63 , params);
			}
			return null;
		}

		public function confortPeople(cityId:int,typeId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送confortPeople时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerConfortPeopleCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.typeId = typeId;
				ControllerFactory.getInstance().client.sendMessage(64 , params);
			}
			return null;
		}

		public function conquestResource(cityId:int,targetCastleId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.castle.ConquestResourceResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送conquestResource时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerConquestResourceCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.targetCastleId = targetCastleId;
				ControllerFactory.getInstance().client.sendMessage(65 , params);
			}
			return null;
		}

		public function constructCity(cityId:int,idField:int,castelName:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送constructCity时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerConstructCityCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.idField = idField;
				params.castelName = castelName;
				ControllerFactory.getInstance().client.sendMessage(66 , params);
			}
			return null;
		}

		public function expandCastle(cityId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送expandCastle时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerExpandCastleCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				ControllerFactory.getInstance().client.sendMessage(67 , params);
			}
			return null;
		}

		public function giveUpSelfField(cityId:int,idField:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送giveUpSelfField时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerGiveUpSelfFieldCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.idField = idField;
				ControllerFactory.getInstance().client.sendMessage(68 , params);
			}
			return null;
		}

		public function giveupCity(cityId:int,password:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送giveupCity时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerGiveupCityCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.password = password;
				ControllerFactory.getInstance().client.sendMessage(69 , params);
			}
			return null;
		}

		public function giveupConquestedCastle(cityId:int,targetCastleId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送giveupConquestedCastle时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerGiveupConquestedCastleCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.targetCastleId = targetCastleId;
				ControllerFactory.getInstance().client.sendMessage(70 , params);
			}
			return null;
		}

		public function independentByItem(cityId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送independentByItem时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerIndependentByItemCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				ControllerFactory.getInstance().client.sendMessage(71 , params);
			}
			return null;
		}

		public function independentWar(cityId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送independentWar时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerIndependentWarCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				ControllerFactory.getInstance().client.sendMessage(72 , params);
			}
			return null;
		}

		public function levyResource(cityId:int,resourceType:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送levyResource时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerLevyResourceCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.resourceType = resourceType;
				ControllerFactory.getInstance().client.sendMessage(73 , params);
			}
			return null;
		}

		public function liberateSelfCastle(cityId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送liberateSelfCastle时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerLiberateSelfCastleCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				ControllerFactory.getInstance().client.sendMessage(74 , params);
			}
			return null;
		}

		public function modifyCityName(cityId:int,name:String,logoUrl:String,colorType:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送modifyCityName时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerModifyCityNameCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.name = name;
				params.logoUrl = logoUrl;
				params.colorType = colorType;
				ControllerFactory.getInstance().client.sendMessage(75 , params);
			}
			return null;
		}

		public function modifyOperRate(cityId:int,foodRate:int,woodRate:int,stoneRate:int,ironRate:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送modifyOperRate时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerModifyOperRateCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.foodRate = foodRate;
				params.woodRate = woodRate;
				params.stoneRate = stoneRate;
				params.ironRate = ironRate;
				ControllerFactory.getInstance().client.sendMessage(76 , params);
			}
			return null;
		}

		public function modifyStoreRate(cityId:int,foodRate:int,woodRate:int,stoneRate:int,ironRate:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送modifyStoreRate时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerModifyStoreRateCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.foodRate = foodRate;
				params.woodRate = woodRate;
				params.stoneRate = stoneRate;
				params.ironRate = ironRate;
				ControllerFactory.getInstance().client.sendMessage(77 , params);
			}
			return null;
		}

		public function modifyTaxRate(cityId:int,taxRate:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送modifyTaxRate时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerModifyTaxRateCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.taxRate = taxRate;
				ControllerFactory.getInstance().client.sendMessage(78 , params);
			}
			return null;
		}

		public function moveCity(cityId:int,zone:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送moveCity时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerMoveCityCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.zone = zone;
				ControllerFactory.getInstance().client.sendMessage(79 , params);
			}
			return null;
		}

		public function postTransport(cityId:int,targetId:int,foods:int,woods:int,stones:int,irons:int,golds:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送postTransport时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerPostTransportCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.targetId = targetId;
				params.foods = foods;
				params.woods = woods;
				params.stones = stones;
				params.irons = irons;
				params.golds = golds;
				ControllerFactory.getInstance().client.sendMessage(80 , params);
			}
			return null;
		}

		public function refuseBeConquestedApply(cityId:int,targetCastleId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送refuseBeConquestedApply时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerRefuseBeConquestedApplyCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.targetCastleId = targetCastleId;
				ControllerFactory.getInstance().client.sendMessage(81 , params);
			}
			return null;
		}

		public function resourceStatics(cityId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.castle.ResourceStaticResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送resourceStatics时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerResourceStaticsCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				ControllerFactory.getInstance().client.sendMessage(82 , params);
			}
			return null;
		}

		public function serverGod(cityId:int,godType:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送serverGod时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCityControllerServerGodCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.godType = godType;
				ControllerFactory.getInstance().client.sendMessage(83 , params);
			}
			return null;
		}

	 }
}
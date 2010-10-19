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
	public class CampController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function createCamp(cityId:int,idField:int,name:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送createCamp时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCampControllerCreateCampCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.idField = idField;
				params.name = name;
				ControllerFactory.getInstance().client.sendMessage(172 , params);
			}
			return null;
		}

		public function modifyCampName(cityId:int,tentId:int,newName:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送modifyCampName时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCampControllerModifyCampNameCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.tentId = tentId;
				params.newName = newName;
				ControllerFactory.getInstance().client.sendMessage(173 , params);
			}
			return null;
		}

		public function moveCamp(tentId:int,idField:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送moveCamp时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onCampControllerMoveCampCallback = callback;
				var params:Object=new Object();
				params.tentId = tentId;
				params.idField = idField;
				ControllerFactory.getInstance().client.sendMessage(174 , params);
			}
			return null;
		}

	 }
}
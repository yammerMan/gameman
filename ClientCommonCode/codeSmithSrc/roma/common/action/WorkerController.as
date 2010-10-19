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
	public class WorkerController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function cancelWorkerTrainning(cityId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送cancelWorkerTrainning时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onWorkerControllerCancelWorkerTrainningCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				ControllerFactory.getInstance().client.sendMessage(190 , params);
			}
			return null;
		}

		public function severanceWorker(cityId:int,workerType:int,num:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送severanceWorker时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onWorkerControllerSeveranceWorkerCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.workerType = workerType;
				params.num = num;
				ControllerFactory.getInstance().client.sendMessage(191 , params);
			}
			return null;
		}

		public function speedUpTrainning(cityId:int,itemId:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送speedUpTrainning时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onWorkerControllerSpeedUpTrainningCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.itemId = itemId;
				ControllerFactory.getInstance().client.sendMessage(192 , params);
			}
			return null;
		}

		public function trainningWorker(cityId:int,workerType:int,count:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送trainningWorker时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onWorkerControllerTrainningWorkerCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.workerType = workerType;
				params.count = count;
				ControllerFactory.getInstance().client.sendMessage(193 , params);
			}
			return null;
		}

	 }
}
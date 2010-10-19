/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.report.MessageListResponse
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class ReportController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function deleteReports(ids:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送deleteReports时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onReportControllerDeleteReportsCallback = callback;
				var params:Object=new Object();
				params.ids = ids;
				ControllerFactory.getInstance().client.sendMessage(160 , params);
			}
			return null;
		}

		public function markReaded(ids:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送markReaded时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onReportControllerMarkReadedCallback = callback;
				var params:Object=new Object();
				params.ids = ids;
				ControllerFactory.getInstance().client.sendMessage(161 , params);
			}
			return null;
		}

		public function markStore(ids:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送markStore时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onReportControllerMarkStoreCallback = callback;
				var params:Object=new Object();
				params.ids = ids;
				ControllerFactory.getInstance().client.sendMessage(162 , params);
			}
			return null;
		}

		public function receiveReports(type:int,page:int,size:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.report.MessageListResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送receiveReports时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onReportControllerReceiveReportsCallback = callback;
				var params:Object=new Object();
				params.type = type;
				params.page = page;
				params.size = size;
				ControllerFactory.getInstance().client.sendMessage(163 , params);
			}
			return null;
		}

	 }
}
/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.mail.LetterListResponse
	import roma.common.controller.mail.LetterResponse
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class LetterController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function deleteMails(type:int,mailIds:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送deleteMails时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onLetterControllerDeleteMailsCallback = callback;
				var params:Object=new Object();
				params.type = type;
				params.mailIds = mailIds;
				ControllerFactory.getInstance().client.sendMessage(132 , params);
			}
			return null;
		}

		public function markAsReaded(type:int,mailIds:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送markAsReaded时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onLetterControllerMarkAsReadedCallback = callback;
				var params:Object=new Object();
				params.type = type;
				params.mailIds = mailIds;
				ControllerFactory.getInstance().client.sendMessage(133 , params);
			}
			return null;
		}

		public function readLetter(id:String,isAllianceBattleReport:Boolean,callback:Function=null,checkSending:Boolean=true):roma.common.controller.mail.LetterResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送readLetter时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onLetterControllerReadLetterCallback = callback;
				var params:Object=new Object();
				params.id = id;
				params.isAllianceBattleReport = isAllianceBattleReport;
				ControllerFactory.getInstance().client.sendMessage(134 , params);
			}
			return null;
		}

		public function receiveLetterList(page:int,type:int,size:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.mail.LetterListResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送receiveLetterList时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onLetterControllerReceiveLetterListCallback = callback;
				var params:Object=new Object();
				params.page = page;
				params.type = type;
				params.size = size;
				ControllerFactory.getInstance().client.sendMessage(135 , params);
			}
			return null;
		}

		public function sendLetter(name:String,title:String,contents:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送sendLetter时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onLetterControllerSendLetterCallback = callback;
				var params:Object=new Object();
				params.name = name;
				params.title = title;
				params.contents = contents;
				ControllerFactory.getInstance().client.sendMessage(136 , params);
			}
			return null;
		}

	 }
}
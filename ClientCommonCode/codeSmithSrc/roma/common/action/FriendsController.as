/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.friends.RelationPlayerInfoResponse
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class FriendsController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function addOrUpdatePlayerRelation(playerName:String,relationType:int,remark:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送addOrUpdatePlayerRelation时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onFriendsControllerAddOrUpdatePlayerRelationCallback = callback;
				var params:Object=new Object();
				params.playerName = playerName;
				params.relationType = relationType;
				params.remark = remark;
				ControllerFactory.getInstance().client.sendMessage(111 , params);
			}
			return null;
		}

		public function deletePlayer(playerId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送deletePlayer时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onFriendsControllerDeletePlayerCallback = callback;
				var params:Object=new Object();
				params.playerId = playerId;
				ControllerFactory.getInstance().client.sendMessage(112 , params);
			}
			return null;
		}

		public function getRelationPlayerInfo(playerId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.friends.RelationPlayerInfoResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getRelationPlayerInfo时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onFriendsControllerGetRelationPlayerInfoCallback = callback;
				var params:Object=new Object();
				params.playerId = playerId;
				ControllerFactory.getInstance().client.sendMessage(113 , params);
			}
			return null;
		}

	 }
}
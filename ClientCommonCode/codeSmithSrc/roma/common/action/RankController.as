/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.rank.RankPlayerDataResponse
	import roma.common.controller.rank.RankLeagueResponse
	import roma.common.controller.rank.RankCityResponse
	import roma.common.controller.rank.RankHeroManResponse
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class RankController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function getAttackRank(key:String,page:int,size:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getAttackRank时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onRankControllerGetAttackRankCallback = callback;
				var params:Object=new Object();
				params.key = key;
				params.page = page;
				params.size = size;
				ControllerFactory.getInstance().client.sendMessage(153 , params);
			}
			return null;
		}

		public function getCityRank(key:String,page:int,size:int,type:int,zone:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.rank.RankCityResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getCityRank时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onRankControllerGetCityRankCallback = callback;
				var params:Object=new Object();
				params.key = key;
				params.page = page;
				params.size = size;
				params.type = type;
				params.zone = zone;
				ControllerFactory.getInstance().client.sendMessage(154 , params);
			}
			return null;
		}

		public function getDefenceRank(key:String,page:int,size:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getDefenceRank时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onRankControllerGetDefenceRankCallback = callback;
				var params:Object=new Object();
				params.key = key;
				params.page = page;
				params.size = size;
				ControllerFactory.getInstance().client.sendMessage(155 , params);
			}
			return null;
		}

		public function getHeroManRank(key:String,page:int,size:int,type:int,onlySelfHero:Boolean,callback:Function=null,checkSending:Boolean=true):roma.common.controller.rank.RankHeroManResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getHeroManRank时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onRankControllerGetHeroManRankCallback = callback;
				var params:Object=new Object();
				params.key = key;
				params.page = page;
				params.size = size;
				params.type = type;
				params.onlySelfHero = onlySelfHero;
				ControllerFactory.getInstance().client.sendMessage(156 , params);
			}
			return null;
		}

		public function getLeagueRank(key:String,page:int,size:int,type:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.rank.RankLeagueResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getLeagueRank时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onRankControllerGetLeagueRankCallback = callback;
				var params:Object=new Object();
				params.key = key;
				params.page = page;
				params.size = size;
				params.type = type;
				ControllerFactory.getInstance().client.sendMessage(157 , params);
			}
			return null;
		}

		public function getPlayerInfo(playerName:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.rank.RankPlayerDataResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getPlayerInfo时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onRankControllerGetPlayerInfoCallback = callback;
				var params:Object=new Object();
				params.playerName = playerName;
				ControllerFactory.getInstance().client.sendMessage(158 , params);
			}
			return null;
		}

		public function getPlayerRank(key:String,page:int,size:int,type:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.rank.RankPlayerDataResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getPlayerRank时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onRankControllerGetPlayerRankCallback = callback;
				var params:Object=new Object();
				params.key = key;
				params.page = page;
				params.size = size;
				params.type = type;
				ControllerFactory.getInstance().client.sendMessage(159 , params);
			}
			return null;
		}

	 }
}
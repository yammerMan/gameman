/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.hero.TavernHeroList
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class HeroController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function addPoints(cityId:int,heroId:int,managementAdd:int,powerAdd:int,stratagemAdd:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送addPoints时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onHeroControllerAddPointsCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				params.managementAdd = managementAdd;
				params.powerAdd = powerAdd;
				params.stratagemAdd = stratagemAdd;
				ControllerFactory.getInstance().client.sendMessage(114 , params);
			}
			return null;
		}

		public function awardItem(cityId:int,heroId:int,itemId:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送awardItem时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onHeroControllerAwardItemCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				params.itemId = itemId;
				ControllerFactory.getInstance().client.sendMessage(115 , params);
			}
			return null;
		}

		public function awardMoney(cityId:int,heroId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送awardMoney时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onHeroControllerAwardMoneyCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				ControllerFactory.getInstance().client.sendMessage(116 , params);
			}
			return null;
		}

		public function cancelHeroGrowth(cityId:int,heroId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送cancelHeroGrowth时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onHeroControllerCancelHeroGrowthCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				ControllerFactory.getInstance().client.sendMessage(117 , params);
			}
			return null;
		}

		public function dischargeLeader(cityId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送dischargeLeader时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onHeroControllerDischargeLeaderCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				ControllerFactory.getInstance().client.sendMessage(118 , params);
			}
			return null;
		}

		public function getTavernHerosList(cityId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.hero.TavernHeroList {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getTavernHerosList时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onHeroControllerGetTavernHerosListCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				ControllerFactory.getInstance().client.sendMessage(119 , params);
			}
			return null;
		}

		public function innHero(cityId:int,heroPos:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送innHero时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onHeroControllerInnHeroCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroPos = heroPos;
				ControllerFactory.getInstance().client.sendMessage(120 , params);
			}
			return null;
		}

		public function kickHero(cityId:int,heroId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送kickHero时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onHeroControllerKickHeroCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				ControllerFactory.getInstance().client.sendMessage(121 , params);
			}
			return null;
		}

		public function persuadeHero(cityId:int,heroId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送persuadeHero时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onHeroControllerPersuadeHeroCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				ControllerFactory.getInstance().client.sendMessage(122 , params);
			}
			return null;
		}

		public function reName(cityId:int,heroId:int,newName:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送reName时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onHeroControllerReNameCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				params.newName = newName;
				ControllerFactory.getInstance().client.sendMessage(123 , params);
			}
			return null;
		}

		public function reachLevel(cityId:int,heroId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送reachLevel时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onHeroControllerReachLevelCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				ControllerFactory.getInstance().client.sendMessage(124 , params);
			}
			return null;
		}

		public function refreshTavernHerosList(cityId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.hero.TavernHeroList {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送refreshTavernHerosList时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onHeroControllerRefreshTavernHerosListCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				ControllerFactory.getInstance().client.sendMessage(125 , params);
			}
			return null;
		}

		public function resetHeroPoints(cityId:int,heroId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送resetHeroPoints时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onHeroControllerResetHeroPointsCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				ControllerFactory.getInstance().client.sendMessage(126 , params);
			}
			return null;
		}

		public function sendHeroForGrowth(cityId:int,heroId:int,growthType:int,lastTime:int,coinWith:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送sendHeroForGrowth时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onHeroControllerSendHeroForGrowthCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				params.growthType = growthType;
				params.lastTime = lastTime;
				params.coinWith = coinWith;
				ControllerFactory.getInstance().client.sendMessage(127 , params);
			}
			return null;
		}

		public function setToChief(cityId:int,heroId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送setToChief时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onHeroControllerSetToChiefCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				ControllerFactory.getInstance().client.sendMessage(128 , params);
			}
			return null;
		}

		public function sortHero(cityId:int,heroId:int,sort:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送sortHero时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onHeroControllerSortHeroCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				params.sort = sort;
				ControllerFactory.getInstance().client.sendMessage(129 , params);
			}
			return null;
		}

		public function speedUpHeroGrowth(cityId:int,heroId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送speedUpHeroGrowth时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onHeroControllerSpeedUpHeroGrowthCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				ControllerFactory.getInstance().client.sendMessage(130 , params);
			}
			return null;
		}

		public function treatSeizedHero(cityId:int,heroId:int,dealType:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送treatSeizedHero时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onHeroControllerTreatSeizedHeroCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				params.dealType = dealType;
				ControllerFactory.getInstance().client.sendMessage(131 , params);
			}
			return null;
		}

	 }
}
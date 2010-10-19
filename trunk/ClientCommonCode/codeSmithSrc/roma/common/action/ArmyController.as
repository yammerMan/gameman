/**
* 生成时间 1 
*/
package roma.common.action
{
	import flash.events.Event;

	import framework.game.BaseController;
	import framework.socket.CaesaryClient;

	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.army.FreshBattleFieldResponse
	import roma.common.controller.army.BattleInfoResponse
	import roma.common.controller.army.ScoutNpcFieldResponse
	import roma.common.controller.army.BattleArmyCountResponse
	import roma.common.controller.army.CreateWarFieldResponse
	import roma.common.controller.army.ArmyExecResponse
	import roma.common.controller.army.BattleArmysInfoResponse
	import roma.common.controller.CommonResponse
	import roma.common.valueObject.*
	
	//command
	public class ArmyController extends BaseController
	{

		private var responseDispatcher:ResponseEvtDispatcher = ResponseEvtDispatcher.getInstance();
		
		public function castle2Hero(cityId:int,heroId:int,armyPos:int,troop:int,delta:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送castle2Hero时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerCastle2HeroCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				params.armyPos = armyPos;
				params.troop = troop;
				params.delta = delta;
				ControllerFactory.getInstance().client.sendMessage(32 , params);
			}
			return null;
		}

		public function changeHeroTroop(cityId:int,heroA:int,heroB:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送changeHeroTroop时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerChangeHeroTroopCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroA = heroA;
				params.heroB = heroB;
				ControllerFactory.getInstance().client.sendMessage(33 , params);
			}
			return null;
		}

		public function contrTroopForHero(cityId:int,heroId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送contrTroopForHero时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerContrTroopForHeroCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				ControllerFactory.getInstance().client.sendMessage(34 , params);
			}
			return null;
		}

		public function createArmy(cityId:int,heroId:int,retreatWhenCasualties:int,retreatWhenNoMelee:Boolean,retreatWhenNoRange:Boolean,targetPoint:int,arriveTime:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送createArmy时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerCreateArmyCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				params.retreatWhenCasualties = retreatWhenCasualties;
				params.retreatWhenNoMelee = retreatWhenNoMelee;
				params.retreatWhenNoRange = retreatWhenNoRange;
				params.targetPoint = targetPoint;
				params.arriveTime = arriveTime;
				ControllerFactory.getInstance().client.sendMessage(35 , params);
			}
			return null;
		}

		public function createWarField(cityId:int,heroId:int,retreatWhenCasualties:int,retreatWhenNoMelee:Boolean,retreatWhenNoRange:Boolean,targetPoint:int,missionType:int,waitTime:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.army.CreateWarFieldResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送createWarField时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerCreateWarFieldCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				params.retreatWhenCasualties = retreatWhenCasualties;
				params.retreatWhenNoMelee = retreatWhenNoMelee;
				params.retreatWhenNoRange = retreatWhenNoRange;
				params.targetPoint = targetPoint;
				params.missionType = missionType;
				params.waitTime = waitTime;
				ControllerFactory.getInstance().client.sendMessage(36 , params);
			}
			return null;
		}

		public function cureInjureds(cityId:int,troopTypes:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送cureInjureds时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerCureInjuredsCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.troopTypes = troopTypes;
				ControllerFactory.getInstance().client.sendMessage(37 , params);
			}
			return null;
		}

		public function disbandInjureds(cityId:int,troopTypes:String,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送disbandInjureds时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerDisbandInjuredsCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.troopTypes = troopTypes;
				ControllerFactory.getInstance().client.sendMessage(38 , params);
			}
			return null;
		}

		public function getBattleArmyCount(idField:int,battleId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.army.BattleArmyCountResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getBattleArmyCount时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerGetBattleArmyCountCallback = callback;
				var params:Object=new Object();
				params.idField = idField;
				params.battleId = battleId;
				ControllerFactory.getInstance().client.sendMessage(39 , params);
			}
			return null;
		}

		public function getBattleArmysInfo(idField:int,battleId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.army.BattleArmysInfoResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getBattleArmysInfo时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerGetBattleArmysInfoCallback = callback;
				var params:Object=new Object();
				params.idField = idField;
				params.battleId = battleId;
				ControllerFactory.getInstance().client.sendMessage(40 , params);
			}
			return null;
		}

		public function getFieldBattleInfo(idField:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.army.BattleInfoResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getFieldBattleInfo时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerGetFieldBattleInfoCallback = callback;
				var params:Object=new Object();
				params.idField = idField;
				ControllerFactory.getInstance().client.sendMessage(41 , params);
			}
			return null;
		}

		public function getFreshManBattleField(cityId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.army.FreshBattleFieldResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getFreshManBattleField时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerGetFreshManBattleFieldCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				ControllerFactory.getInstance().client.sendMessage(42 , params);
			}
			return null;
		}

		public function getPlayerBattleInfo(callback:Function=null,checkSending:Boolean=true):roma.common.controller.army.BattleInfoResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送getPlayerBattleInfo时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerGetPlayerBattleInfoCallback = callback;
				var params:Object=new Object();
				ControllerFactory.getInstance().client.sendMessage(43 , params);
			}
			return null;
		}

		public function heroTroopChangeNum(cityId:int,heroId1:int,armyPos1:int,heroId2:int,armyPos2:int,army1Num:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送heroTroopChangeNum时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerHeroTroopChangeNumCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId1 = heroId1;
				params.armyPos1 = armyPos1;
				params.heroId2 = heroId2;
				params.armyPos2 = armyPos2;
				params.army1Num = army1Num;
				ControllerFactory.getInstance().client.sendMessage(44 , params);
			}
			return null;
		}

		public function heroTroopSwapPosition(cityId:int,heroId1:int,armyPos1:int,heroId2:int,armyPos2:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送heroTroopSwapPosition时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerHeroTroopSwapPositionCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId1 = heroId1;
				params.armyPos1 = armyPos1;
				params.heroId2 = heroId2;
				params.armyPos2 = armyPos2;
				ControllerFactory.getInstance().client.sendMessage(45 , params);
			}
			return null;
		}

		public function joinWarField(cityId:int,heroId:int,retreatWhenCasualties:int,retreatWhenNoMelee:Boolean,retreatWhenNoRange:Boolean,targetPoint:int,warFieldId:int,isAttacker:Boolean,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送joinWarField时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerJoinWarFieldCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				params.retreatWhenCasualties = retreatWhenCasualties;
				params.retreatWhenNoMelee = retreatWhenNoMelee;
				params.retreatWhenNoRange = retreatWhenNoRange;
				params.targetPoint = targetPoint;
				params.warFieldId = warFieldId;
				params.isAttacker = isAttacker;
				ControllerFactory.getInstance().client.sendMessage(46 , params);
			}
			return null;
		}

		public function newScout(cityId:int,targetPoint:int,scoutNum:int,missionType:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送newScout时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerNewScoutCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.targetPoint = targetPoint;
				params.scoutNum = scoutNum;
				params.missionType = missionType;
				ControllerFactory.getInstance().client.sendMessage(47 , params);
			}
			return null;
		}

		public function reCallArmy(cityId:int,heroId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送reCallArmy时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerReCallArmyCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				ControllerFactory.getInstance().client.sendMessage(48 , params);
			}
			return null;
		}

		public function scoutNpcField(idField:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.army.ScoutNpcFieldResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送scoutNpcField时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerScoutNpcFieldCallback = callback;
				var params:Object=new Object();
				params.idField = idField;
				ControllerFactory.getInstance().client.sendMessage(49 , params);
			}
			return null;
		}

		public function sendAllianceBack(cityId:int,allianceHeroId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送sendAllianceBack时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerSendAllianceBackCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.allianceHeroId = allianceHeroId;
				ControllerFactory.getInstance().client.sendMessage(50 , params);
			}
			return null;
		}

		public function setAllowLeagueArmy(cityId:int,allow:Boolean,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送setAllowLeagueArmy时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerSetAllowLeagueArmyCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.allow = allow;
				ControllerFactory.getInstance().client.sendMessage(51 , params);
			}
			return null;
		}

		public function setAntiLoot(cityId:int,isOut:Boolean,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送setAntiLoot时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerSetAntiLootCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.isOut = isOut;
				ControllerFactory.getInstance().client.sendMessage(52 , params);
			}
			return null;
		}

		public function trainArmy(cityId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.army.ArmyExecResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送trainArmy时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerTrainArmyCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				ControllerFactory.getInstance().client.sendMessage(53 , params);
			}
			return null;
		}

		public function uninstallHeroTroop(cityId:int,heroId:int,callback:Function=null,checkSending:Boolean=true):roma.common.controller.CommonResponse {
			if (checkSending && this.responseDispatcher.sending) {
				trace("发送uninstallHeroTroop时，系统繁忙")
				ControllerFactory.getInstance().client.dispatchEvent(new Event(CaesaryClient.ON_SYSTEM_BUSY));
			} else {
				this.responseDispatcher.sending = checkSending;
				this.responseDispatcher._onArmyControllerUninstallHeroTroopCallback = callback;
				var params:Object=new Object();
				params.cityId = cityId;
				params.heroId = heroId;
				ControllerFactory.getInstance().client.sendMessage(54 , params);
			}
			return null;
		}

	 }
}
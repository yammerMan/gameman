
package views.windows.functionWins.mail.bean
{
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	import roma.common.constants.BattleConstants;
	import roma.common.constants.FieldConstant;
	import roma.logic.GameContext;
	import roma.logic.object.castle.BattleHelper;
	import roma.logic.object.field.FieldHelper;
	import roma.util.MultiLang;
	
	[Bindable]
	public class BattleReportType
	{
		public var isAttack:Boolean;
		public var prestige:int;
		public var honor:String;
		public var score:int;
		public var npcIndex:int;
		public var isTraining:Boolean = false;
		
		public var items:ArrayCollection = new ArrayCollection();
		public var seize:SeizeObjct;
		public var lootResource:ResourceType;
		public var lostRes:ResourceType;
		
		public var battle:BattleResultType;
		public var conquest:ObjectProxy; 
		public var startCastle:ObjectProxy;
		public var independentCastles:ArrayCollection = new ArrayCollection();
		public var captiveHeros:ArrayCollection = new ArrayCollection();
		public var beCaptiveHeros:ArrayCollection = new ArrayCollection();
		
		private var playerName:String = "";
		private var othersName:String = '';
		
		private	var attackStr:String = MultiLang.msg('battle.attack.label');
		private	var defenceStr:String = MultiLang.msg('battle.defence.label');
		private	var winStr:String = MultiLang.msg('report.success.desc');
		private	var loseStr:String = MultiLang.msg('report.fail.desc');
		private	var conditionReach:String = MultiLang.msg('battle.conditionReach');
		private	var conditionUnReach:String = MultiLang.msg('battle.conditionUnReach');
		private var stillBeConquestStr:String = MultiLang.msg('report.conquest.stillBeConquest.label');
		private var toIndependenceStr:String = MultiLang.msg('report.conquest.toIndependence.label');
		
		public var independentCastleDesc:String = "";
		
		public function BattleReportType(o:Object)
		{
			isAttack = o.isAttack;
			prestige = o.prestige;
			honor = honorStr(o.honor);
			score = o.score;
			npcIndex = o.npcIndex;

			items = setItems(o.items);
			seize = o.hasOwnProperty("seize")?new SeizeObjct(o.seize):null;
			lootResource = o.hasOwnProperty("lootResource")?new ResourceType(o.lootResource):null;
			lostRes = o.hasOwnProperty("lostRes")?new ResourceType(o.lostRes):null;
			battle = new BattleResultType(o.battle);
			
			conquest = o.hasOwnProperty('conquest')?o.conquest:null;
			startCastle = o.hasOwnProperty('startCastle')?o.startCastle:null;
			independentCastles = setIndependentCastle(o.independentCastles);
			captiveHeros = setItems(o.seizeHero);
			beCaptiveHeros = setItems(o.beSeizeHero);
			
//			playerName = GameContext.instance.getPlayerObj().getPlayerInfo().playerName;
			othersName = battle.battleFieldName != ""?
						(battle.battleFieldName+GameContext.getFieldPostionString(battle.battleFieldId)):
						FieldHelper.getFieldName(battle.battleFieldType,battle.battleFieldLevel)+GameContext.getFieldPostionString(battle.battleFieldId);
			setIndependentCastleDesc(independentCastles);
			
			isTraining = (battle.battleMission == BattleConstants.ARMY_MISSION_TRAINNING);
		}
		
		private function setItems(o:Object):ArrayCollection{
			var arr:ArrayCollection = new ArrayCollection();
			if(o is ObjectProxy){
				arr.addItem(o);
			}else if(o is ArrayCollection){
				for each(var oo:Object in o){
					var bb:ObjectProxy = new ObjectProxy(oo);
					arr.addItem(bb);
				}
			}
			return arr;
		}
		
		private function setIndependentCastle(o:Object):ArrayCollection{
			var arr:ArrayCollection = new ArrayCollection();
			if(o is ObjectProxy){
				arr.addItem(o);
			}else if(o is ArrayCollection){
				for each(var oo:Object in o){
					arr.addItem(oo);
				}
			}
			return arr;
		}
		
		/**
		 * 返回此次战斗中获得独立的城池的描述，只是文字的描述
		 */ 
		private function setIndependentCastleDesc(arr:ArrayCollection):String{
			var str:String = "";
			for each(var o:ObjectProxy in arr){
				str += o.caslteName+',';
			}
			str.split(-1);
			return str;
		}
		
		public function getBattleTitle():String{
			var defName:String = this.getDefenseName();
			var attName:String = this.getAttackName();
			if(this.battle.battleMission == BattleConstants.ARMY_MISSION_TRAINNING)
			return MultiLang.msg("battle.title.npc.label{0}{1}{2}{3}",attName,defName,npcIndex,this.battle.battleFieldType==FieldConstant.TYPE_NPC_FIELD?MultiLang.msg("military.mission.manoeuvre"):MultiLang.msg("military.mission.quell"));
			else
			return MultiLang.msg("battle.title.label{0}{1}{2}",attName,defName,BattleHelper.instance.getBattleMission(battle.battleMission));
		}
		
		public function getResultDesc():String{
			var str:String = "";
			var s:String = getSeizeFieldCondition();
			var s1:String = getConquestCondition();
			if(isAttack){
				if(battle.isAttackSuccess){
					if(seize != null){
						// 占领野地描述
						if(seize.field){
							str = MultiLang.msg('battle.result.desc{0}{1}{2}{3}',battle.battleRound,attackStr,winStr,honor)+" "+s;
						}
					}
					// 征服城池的描述
					else if(conquest != null){
						var str2:String = conquest.hasOwnProperty('support')?MultiLang.msg("battle.result.caslte.desc{0}{1}",conquest.support,conquest.complaint):"";
						str = MultiLang.msg("battle.result.desc{0}{1}{2}{3}",battle.battleRound,attackStr,winStr,honor)+" "+str2+" "+s1;
					}
					else{
						str = MultiLang.msg("battle.result.desc{0}{1}{2}{3}",battle.battleRound,attackStr,winStr,honor);
					}
				}
				else{
					var s2:String = "";
					str = MultiLang.msg('battle.result.desc{0}{1}{2}{3}',battle.battleRound,attackStr,loseStr,honor)+" "+s2;
				}
			}
			else{
				if(battle.isAttackSuccess){
					if(seize != null){
						if(seize.field){
							str = MultiLang.msg('battle.result.desc{0}{1}{2}{3}',battle.battleRound,defenceStr,loseStr,honor)+" "+s;
						}
					}
					else if(conquest != null){
						var str3:String = conquest.hasOwnProperty('support')?MultiLang.msg("battle.result.caslte.desc{0}{1}",conquest.support,conquest.complaint):"";
						str = MultiLang.msg('battle.result.desc{0}{1}{2}{3}',battle.battleRound,defenceStr,loseStr,honor)+" "+str3+" "+s1;
					}else{
						str = MultiLang.msg('battle.result.desc{0}{1}{2}{3}',battle.battleRound,defenceStr,loseStr,honor);
					}
				}
				else{
					str = MultiLang.msg('battle.result.desc{0}{1}{2}{3}',battle.battleRound,defenceStr,winStr,honor);
				}
			}
			return str;
		}
		
		public function getIndependenceDesc():String{
			var defName:String = battle.battleFieldName+GameContext.getFieldPostionString(battle.battleFieldId);
			var attName:String = startCastle.name+GameContext.getFieldPostionString(startCastle.idField);
			if(isAttack){
				// 宗主国
				if(battle.isAttackSuccess)return MultiLang.msg('report.conquest.keepDownBattle.desc',attName,defName,winStr,stillBeConquestStr);
				else{return MultiLang.msg('report.conquest.keepDownBattle.desc',attName,defName,loseStr,toIndependenceStr);}
			}else{
				// 附庸国
				if(battle.isAttackSuccess)return MultiLang.msg('report.conquest.independenceBattle.desc',defName,attName,loseStr,stillBeConquestStr);
				else{return MultiLang.msg('report.conquest.independenceBattle.desc',defName,attName,winStr,toIndependenceStr);}
			}
		}
		
		public function getSeizeFieldCondition():String{
			// 占领野地的条件判断
			var str:String = "";
			if(seize == null){
				return str;
			}
			if(seize.field.isSeize){
				if(isAttack){
					str = MultiLang.msg('battle.result.reason.seize{0}',othersName);
				}else{
					str = MultiLang.msg("battle.result.bySeize{0}",othersName)
				}
			}else{
				switch(seize.field.seizeProblem){
					case BattleConstants.SEIZE_PROBLEM_TOWNHALL_LEVEL_TOO_LOW:
						var l:int = GameContext.instance.getPlayerObj().getCastleByFieldId(startCastle.idField).buildingManager.getTownHall().level;
						str = MultiLang.msg('battle.result.reason.townhallToLow',l,l);
					break;
					case BattleConstants.SEIZE_PROBLEM_LEADER_QUIT:
						var s:String = MultiLang.msg("military.mission.attack");
						str = MultiLang.msg("battle.result.reason.leaderIsOver",s);
					break;
				}
			}
//			}
			return str;
		}
		
		public function getConquestCondition():String{
			// 征服城池的条件描述
			var str:String = "";
			if(this.conquest == null){
				return str;
			}
			if(conquest.isConquest == true){
				if(isAttack){
					str = MultiLang.msg("battle.result.reason.conquest{0}",othersName);
				}else{
					str = MultiLang.msg('battle.result.byConquest{0}',othersName);
				}
			}
			else{
				switch(conquest.conquestProblem){
					case BattleConstants.SEIZE_PROBLEM_SUPPORT:
						str = MultiLang.msg('battle.result.reason.hasSupport');
					break;
					case BattleConstants.SEIZE_PROBLEM_LEADER_QUIT:
						var s:String = MultiLang.msg("diplomacy.conquest.label");
						str = MultiLang.msg("battle.result.reason.leaderIsOver",s);
					break;
				}
			}
			return str;
		}
		
		private function getDefenseName():String{
			if(battle.battleFieldPlayer != null && battle.battleFieldPlayer != ""){
				return MultiLang.msg('battle.{0}s{1}',battle.battleFieldPlayer,this.othersName);
			}else{
				return this.othersName;
			}
		}
		
		private function getAttackName():String{
			if(startCastle.player != null && startCastle.player != ""){
				var nStr:String = startCastle.name;
				if(startCastle.hasOwnProperty("idField")){
					nStr += "["+GameContext.getFieldPostionX(startCastle.idField)+","+GameContext.getFieldPostionY(startCastle.idField)+"]";
				}
				return MultiLang.msg("battle.{0}s{1}",startCastle.player,nStr);
			}else{
				return " "
			}
		}
		
		private function honorStr(h:int):String{
			if(h>0) return "+"+String(h);
			else return String(h);
		}
	}
}
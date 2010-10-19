package roma.war.render
{
	import flash.utils.Dictionary;
	
	import roma.common.constants.BattleConstants;
	import roma.war.constants.ActionConstants;
	import roma.war.constants.ReportConstants;
	import roma.war.controler.MsgComDispatch;
	import roma.war.data.BattleHelper;
	import roma.war.data.ReportManager;
	import roma.war.data.actions.ActionATK;
	import roma.war.data.actions.ActionItem;
	import roma.war.data.actions.ActionMove;
	import roma.war.data.actions.ActionQuit;
	import roma.war.data.actions.ActionRetreat;
	import roma.war.data.actions.ActionRockConsume;
	import roma.war.data.actions.ActionRockMiss;
	import roma.war.data.actions.ActionTrapATK;
	import roma.war.data.actions.ActionTrapWork;
	import roma.war.data.actions.ActionWait;
	import roma.war.render.motion.Army;
	import roma.war.render.motion.Hero;
	import roma.war.resource.MultiLang;
	import roma.war.ui.MainSkin;
	import roma.war.ui.UiEvent;
	
	public class WarMesBuffer
	{
		private var skin:MainSkin;
		public var mesStr:String = "";
		
		private static const SHOW_SIZE:int = 30;
		public var mesArr:Array = new Array();
		
		public function WarMesBuffer(skinWin:MainSkin){
			this.skin = skinWin;
			mesArr = [];
			MsgComDispatch.instance.addEventListener(UiEvent.SCROLL_ACTION,onSrollAction);
		}
		
		private var str:String;
		public function addAction(a:ActionItem):void{
			switch(a.type){
				case ActionConstants.ACTION_TYPE_ATK:
					str = actionAtk(a as ActionATK);
				break;
				case ActionConstants.ACTION_TYPE_MOVE:
					str = actionMove(a as ActionMove);
				break;
				case ActionConstants.ACTION_TYPE_QUIT:
					str = actionQuit(a as ActionQuit);
				break;
				case ActionConstants.ACTION_TYPE_RETREAT:
					str = actionRetreate(a as ActionRetreat);
				break;
				case ActionConstants.ACTION_TYPE_ROCKCONSUME:
					str = actionRockConsume(a as ActionRockConsume);
				break;
				case ActionConstants.ACTION_TYPE_ROCKFALLMISS:
					str = actionRockFallMiss(a as ActionRockMiss);
				break;
				case ActionConstants.ACTION_TYPE_TRAPATTACK:
					str = actionTrapAttack(a as ActionTrapATK);
				break;
				case ActionConstants.ACTION_TYPE_TRAPWORK:
					str = actionTrapWork(a as ActionTrapWork);
				break;
				case ActionConstants.ACTION_TYPE_WAIT:
					str = actionWait(a as ActionWait);
				break;
			}
			if(str == null)return;
			if(ReportManager.instance.checkIsRoundAction(a.actionId)){
				str += setRoundResultMes(a.round+1);
			}
			mesArr.push(str);
		}
		
		public function addWinMes(g:int):void{
			mesArr.push(MultiLang.msg("wareplay.echo.winner", gGS(g)));
		}
		
		private function onSrollAction(e:UiEvent):void{
			curActionId = ReportManager.instance.warData.action.actionId;
			if(mesArr.length<= curActionId){
				echo(ReportManager.instance.warData.action.actionId,true);
			}
			if(!this.isStay)
			echo(ReportManager.instance.warData.action.actionId,true);
		}
		
		private var h:Hero;
		private var s:String;
		private var army:Army;
		/**
		 * 英雄出场
		 */ 
		private function actionMove(a:ActionMove):String{
			h = ReportManager.instance.warData.getBeanByKey(a.key);
			if(h == null)return null;
			if(h.group == ReportConstants.RED){
				s = MultiLang.msg("wareplay.echo.hero.goAttack");
				return MultiLang.msg("wareplay.echo.hero_coming", gGS(h.group), getHS(h),BattleHelper.instance.getBeanPos(h.location,true),s);
				}
			else if(h.group == ReportConstants.BLUE){
				s = MultiLang.msg("wareplay.echo.hero.goDefence");
				return MultiLang.msg("wareplay.echo.hero_coming", gGS(h.group), getHS(h),BattleHelper.instance.getBeanPos(h.location,false),s);
			}else{
				return "WarMesBuffer.actionMove.nothing";
			}
		}
		
		/**
		 * 英雄死亡
		 */ 
		private function actionQuit(a:ActionQuit):String{
			h = ReportManager.instance.warData.getBeanByKey(a.key);
			if(h == null)return null;
			return MultiLang.msg("wareplay.echo.hero_quit", gGS(h.group), getHS(h));
		}
		
		/**
		 * 英雄逃离
		 */ 
		private function actionRetreate(a:ActionRetreat):String{
			h = ReportManager.instance.warData.getBeanByKey(a.key);
			if(h == null)return null;
			return (MultiLang.msg("wareplay.echo.hero_retreat", gGS(h.group), getHS(h)));
		}
		
		private var spendTypeStr:String;
		private function actionRockConsume(a:ActionRockConsume):String{
			spendTypeStr = BattleHelper.instance.getTFName(BattleConstants.KEY_ROCK_FALL);
			return MultiLang.msg("wareplay.spend",spendTypeStr,a.consume);
		}
		
		private function actionRockFallMiss(a:ActionRockMiss):String{
			h = ReportManager.instance.warData.getBeanByKey(a.key);
			if(h == null)return null;
			return (MultiLang.msg("troop.attack.rockIsMiss"));
		}
		
		private function actionTrapWork(a:ActionTrapWork):String{
			spendTypeStr = BattleHelper.instance.getTFName(BattleConstants.KEY_TRAP);
			return MultiLang.msg("wareplay.spend",spendTypeStr,a.trapCount);
		}
		
		private function actionTrapAttack(a:ActionTrapATK):String{
			h = ReportManager.instance.warData.getBeanByKey(a.key);
			if(h == null)return null;
			army = h.armys[a.p];
			if(army == null){new Error("mes.actionTrapAttack army is null")}
			return (MultiLang.msg("wareplay.echo.who_attack_who", BattleHelper.instance.getTFName(BattleConstants.KEY_TRAP), gGHS(h) + gGLS(a.p,army.troopId,h.group), getDamage(a.count), getBattleMode(BattleConstants.MODE_TRAP)));
		}
		
		private function actionWait(a:ActionWait):String{
			h = ReportManager.instance.warData.getBeanByKey(a.key);
			if(h == null) return null;
			army = h.getArmyByPos(a.pos);
			s = getHS(h);
			return (MultiLang.msg("wareplay.echo.wait", gGS(h.group), s, gGLS(a.pos, army.troopId,h.group)));
		}
		
		
		private var h1:Hero;
		private var h2:Hero;
		private var army1:Army;
		private var army2:Army;
		private function actionAtk(a:ActionATK):String{
			if(a.k1 <0){
				// 城防攻击
				h = ReportManager.instance.warData.getBeanByKey(a.k2);
				army = h.getArmyByPos(a.p2);
				if(army == null){new Error("mes.actionAtk army is null")}
				switch(a.k1){
					case BattleConstants.KEY_ARROW_TOWER:
						return (MultiLang.msg("wareplay.echo.who_attack_who", BattleHelper.instance.getTFName(BattleConstants.KEY_ARROW_TOWER), gGHS(h) + gGLS(a.p2, army.troopId,h.group), getDamage(a.dmg), getBattleMode(a.mode)));
					break;
					case BattleConstants.KEY_ROCK_FALL:
						return (MultiLang.msg("wareplay.echo.who_attack_who", BattleHelper.instance.getTFName(BattleConstants.KEY_ROCK_FALL), gGHS(h) + gGLS(a.p2, army.troopId,h.group), getDamage(a.dmg), getBattleMode(a.mode)));
					break;
				}
			}
			if(a.k2 <0){
				// 攻击城防
				h = ReportManager.instance.warData.getBeanByKey(a.k1);
				army = h.getArmyByPos(a.p1);
				if(army == null){new Error("mes.actionAtk army is null")}
				switch(a.k2){
					case BattleConstants.KEY_ARROW_TOWER:
						return (MultiLang.msg("wareplay.echo.who_attack_who", gGHS(h) + gGLS(a.p1, army.troopId,h.group), BattleHelper.instance.getTFName(BattleConstants.KEY_ARROW_TOWER), getDamage(a.dmg), getBattleMode(a.mode)));
					break;
					case BattleConstants.KEY_WALL:
						return (MultiLang.msg("wareplay.echo.who_attack_who", gGHS(h) + gGLS(a.p1, army.troopId,h.group), BattleHelper.instance.getTFName(BattleConstants.KEY_WALL), getDamage(a.dmg), getBattleMode(a.mode)));
					break;
				}
			}
			h1 = ReportManager.instance.warData.getBeanByKey(a.k1);
			army1 = h1.getArmyByPos(a.p1);
			h2 = ReportManager.instance.warData.getBeanByKey(a.k2);
			army2 = h2.getArmyByPos(a.p2);
			if(army1 == null || army2 == null){new Error("mes.actionAtk army is null")}
			return (MultiLang.msg("wareplay.echo.who_attack_who", gGHS(h1) + gGLS(a.p1, army1.troopId,h1.group), gGHS(h2) + gGLS(a.p2, army2.troopId,h2.group), getDamage(a.dmg), getBattleMode(a.mode)));
		}
		
		/**
		 * 正下方回合的显示
		 */ 
		public function setRoundTextShow(r:int):void{
			skin.roundText = "<font color='#ffffff'>" + MultiLang.msg("war.ui.text.round",r+1)+"</font> \n";
		}
		
		/**
		 * 回合背景
		 */ 
		public function showRoundFlow(round:int,isSkip:Boolean):void{
			if(!isSkip){
//				skin.roundText = "<font color='#ffffff'>" + Lang.msg("war.ui.text.round",round)+"</font> \n";
				skin.showRound();
			}
		}
		
		//战报文字
		private var arr:Array;
		private var id:int;
		private var curActionId:int;
		private var isStay:Boolean = false;
		public function echo(aId:int,isTrue:Boolean = false):void
		{
			isStay = isTrue;
			curActionId = ReportManager.instance.warData.action.actionId;
			if(isStay){
				mesStr = mesArr.slice(0,curActionId).join("\n");
				mesStr += "\n"+mesArr[curActionId];
				skin.echo(mesStr);
				return;
			}
			if(aId >= SHOW_SIZE){
				var a:Array = mesArr.slice(aId-SHOW_SIZE,aId);
				mesStr = mesArr.slice(aId-SHOW_SIZE,aId).join("\n");
				mesStr += "\n"+mesArr[aId];
				skin.echo(mesStr);
				return;
			}
			mesStr = mesArr.slice(0,aId).join("\n");
			skin.echo(mesStr);
		}
		
		/**
		 * 每一回合结果显示
		 */ 
		private var heroesInBattleDic:Dictionary = new Dictionary();
		private function setRoundResultMes(round:int):String{
			// 进攻部队 [英雄A] null  null  null  null  投石车 10522个 H:6312608 A:32 D:13  null  )
			// 防守部队 [英雄B] null  null  null  投石车 522个 H:312608 A:32 D:13  投石车 5000个 H:3000000 A:32 D:13
			var attStr:String = "";
			var defStr:String = "";
			var ts:String = "";
			var ts1:String = "";
			heroesInBattleDic = ReportManager.instance.warData.heroesInBattle;
			s = "\n"+("<font color='#ffffff'>" + MultiLang.msg("wareplay.echo.turn.result",round)+"</font> \n");
			for each(h in heroesInBattleDic){
				if(h == null){continue;}
				if(h.group == ReportConstants.RED){
					attStr = MultiLang.msg("wareplay.echo.hero",MultiLang.msg("wareplay.attack.group.red"),getHS(h))+" : \n";
					for each(army in h.armys){
						if(army != null){
							ts = "<font color='#ff9600'>"+BattleHelper.instance.getTFName(army.troopId)+"</font>";
							attStr += ts+String(int(army.count)+int(army.damageCount))+", ";
						}
					}
					s += attStr.substr(0,attStr.length-2);
					s += "\n";
				}
				else{
					defStr = MultiLang.msg("wareplay.echo.hero",MultiLang.msg("wareplay.attack.group.blue"),getHS(h))+" : \n";
					for each(army in h.armys){
						if(army != null){
							ts1 = "<font color='#ff9600'>"+BattleHelper.instance.getTFName(army.troopId)+"</font>";
							defStr += ts1+String(int(army.count)+int(army.damageCount))+", ";
							}
						}
						s += defStr.substr(0,defStr.length-2);
						s += "\n";
				}
			}
			return s;
		}
		
		/**
		 * 位置上的军队
		 */ 
		private function gGLS(p:int,aId:int,g:int):String
		{
			s ="<font color='#ff9600'>"+BattleHelper.instance.getTFName(aId)+"</font>";
			var posStr:String;
			if(g == 0) posStr = BattleHelper.instance.getArmyPos(p,true);
			else if(g == 1)posStr = BattleHelper.instance.getArmyPos(p,false);
			return MultiLang.msg("wareplay.echo.onLocation", posStr, s);
		}
		
		/**
		 * 攻击方式
		 */ 
		private function getBattleMode(mode:int):String
		{
			return BattleHelper.instance.getAttackMode(mode);
		}
		
		/**
		 * 攻击或防御标签
		 */ 
		private function gGS(group:Number):String
		{
			return group == ReportConstants.RED ? MultiLang.msg("wareplay.attack.group.red") : MultiLang.msg("wareplay.attack.group.blue");
		}
		
		/**
		 * 有修饰的伤害值
		 */ 
		private function getDamage(d:int):String{
			return "<font color='#ff0000'>"+d+"</font>";
		}
		
		/**
		 * 有修饰的英雄名字
		 */ 
		private function getHS(h:Hero):String{
			if(h.group == ReportConstants.RED) return "<font color='#ff0000'>"+h.name+"</font>";
			else return "<font color='#0084ff'>"+h.name+"</font>";
		}
		
		/**
		 * 攻击方或防御方[英雄]标签
		 */ 
		private function gGHS(h:Hero):String
		{
			var nStr:String = "";
			if(h.group == ReportConstants.RED) nStr = "<font color='#ff0000'>"+h.name+"</font>";
			else if(h.group == ReportConstants.BLUE) nStr ="<font color='#0084ff'>"+h.name+"</font>";
			return MultiLang.msg("wareplay.echo.hero", gGS(h.group), nStr);
		}
		
		/**
		 * 通过actionId获取说明文字
		 */
		public function getMesItemForId(aId:int):String{
			return mesArr[aId];
		}
		
	}
}
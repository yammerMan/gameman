package roma.war.render
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import roma.common.constants.BattleConstants;
	import roma.war.constants.ActionConstants;
	import roma.war.constants.ReportConstants;
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
	import roma.war.data.bean.BattleReportType;
	import roma.war.data.bean.BattleTroopType;
	import roma.war.render.motion.Army;
	import roma.war.render.motion.Hero;
	
	public class WarDataBuffer
	{
		//wall
		public var wallLife:Number = 0;
		public var wallTotalLife:Number = 0;
		public var towerLife:Number = 0;
		public var stoneNumber:Number = 0;
		public var trapNumber:Number = 0;
		//hp
		private var groupHp:Array;
		private var groupHpTotal:Array;
		
		public var heroes:Dictionary;
		public var heroesInBattle:Dictionary;

		public var action:ActionItem;
		
		private var reportData:BattleReportType;
		
		public function WarDataBuffer()
		{
			heroes = new Dictionary();
			heroesInBattle = new Dictionary(true);
			groupHp = new Array();
			groupHpTotal = new Array();
			
		}
		
		public function initWarData():void{
			reportData = ReportManager.instance.battleReportType;
			setWall();
			setHeros();
			setLife();
			heroesInBattle = new Dictionary(true);
			var i:int = 0;
			for(i=0;i<6;i++){
				heroesInBattle[i] = null;
			}
		}
		
		public function roundDataUpdate():void{
			var aa:Army;
			for each(h in ReportManager.instance.warData.heroesInBattle){
				if(h == null) continue;
				for each(aa in h.armys){
					aa.updateLineup();
				}
			}
		}
		
		/**
		 * 导入action
		 */ 
		public function addAction(a:ActionItem,isSkip:Boolean = false):void{
//			trace("warDataBuffer.addAction == "+a.actionId);
			if(ReportManager.instance.checkIsRoundAction(a.actionId)){
				roundDataUpdate();
			}
			switch(a.type){
				case ActionConstants.ACTION_TYPE_ATK:
					actionAtk(a as ActionATK);
				break;
				case ActionConstants.ACTION_TYPE_MOVE:
					actionMove(a as ActionMove,isSkip);
				break;
				case ActionConstants.ACTION_TYPE_QUIT:
					actionQuit(a as ActionQuit);
				break;
				case ActionConstants.ACTION_TYPE_RETREAT:
					actionRetreate(a as ActionRetreat);
				break;
				case ActionConstants.ACTION_TYPE_ROCKCONSUME:
					actionRockConsume(a as ActionRockConsume);
				break;
				case ActionConstants.ACTION_TYPE_ROCKFALLMISS:
					actionRockFallMiss(a as ActionRockMiss);
				break;
				case ActionConstants.ACTION_TYPE_TRAPATTACK:
					actionTrapAttack(a as ActionTrapATK);
				break;
				case ActionConstants.ACTION_TYPE_TRAPWORK:
					actionTrapWork(a as ActionTrapWork);
				break;
				case ActionConstants.ACTION_TYPE_WAIT:
					actionWait(a as ActionWait);
				break;
			}
			if(a != null)
			this.action = a;
		}
		
		public function getBeanInBattleLength():int{
			var h:Hero;
			var c:int = 0;
			for each(h in heroesInBattle){
				c ++;
			}
			return c;
		}
		
		private function setHeros():void{
			var arr:Array = reportData.battle.attackerTroop.toArray().concat(reportData.battle.defenderTroop.toArray());
			for(var i:int=0;i<arr.length;i++){
				var b:BattleTroopType = arr[i] as BattleTroopType;
				var h:Hero = new Hero(b);
				heroes[b.key] = h;
			}
		}
		
		private function setWall():void{
			if(reportData.battle.wall){
				this.wallTotalLife = this.wallLife = reportData.battle.wall.totalLife;
				this.towerLife = reportData.battle.wall.hasOwnProperty("arrowTower")?(int(reportData.battle.wall.arrowTower.lose)+int(reportData.battle.wall.arrowTower.count))*reportData.battle.wall.arrowTower.life:0;
				this.stoneNumber = reportData.battle.wall.hasOwnProperty("rockFall")?int(reportData.battle.wall.rockFall.count)+int(reportData.battle.wall.rockFall.lose):0;
				this.trapNumber = reportData.battle.wall.hasOwnProperty("trap")?(int(reportData.battle.wall.trap.count)+int(reportData.battle.wall.trap.lose)):0;
			}
		} 
		
		private function setLife():void{
			var arr:Array = reportData.battle.attackerTroop.toArray();
			var c:Number = 0;
			var h:BattleTroopType;
			for each(h in arr){
				c += Number(h.totalHP);
			}
			groupHp[0] = c;
			groupHpTotal[0] = c;
			c = 0;
			arr = reportData.battle.defenderTroop.toArray();
			for each(h in arr){
				c += Number(h.totalHP);
			}
			groupHp[1] = c;
			groupHpTotal[1] = c;
		}
		
		public function dispose():void{
			heroes = new Dictionary();
			heroesInBattle = new Dictionary();
			groupHp = new Array();
			groupHpTotal = new Array();
		}
		
		private var army:Army;
		private var h:Hero;
		/**
		 * 加入出场英雄(通过出场行为)
		 */ 
		private function actionMove(a:ActionMove,isSkip:Boolean = false):void{
			h = this.getBeanByKey(a.key);
			if(!isSkip){
				h.heroStatus = ReportConstants.HERO_ENTER;
			}else{
				h.heroStatus = ReportConstants.HERO_INBATTLE;
			}
			if(h.group == ReportConstants.RED){
				if(heroesInBattle[0] == null){heroesInBattle[0] = h;h.location = 0;setArmyAbsolutePoints(h);return;}
				if(heroesInBattle[1] == null){heroesInBattle[1] = h;h.location = 1;setArmyAbsolutePoints(h);return;}
				if(heroesInBattle[2] == null){heroesInBattle[2] = h;h.location = 2;setArmyAbsolutePoints(h);return;}
			}else if(h.group == ReportConstants.BLUE){
				if(heroesInBattle[3] == null){heroesInBattle[3] = h;h.location = 3;setArmyAbsolutePoints(h);return;}
				if(heroesInBattle[4] == null){heroesInBattle[4] = h;h.location = 4;setArmyAbsolutePoints(h);return;}
				if(heroesInBattle[5] == null){heroesInBattle[5] = h;h.location = 5;setArmyAbsolutePoints(h);return;}
			}
			
//			trace("warDataBuffer.actionMove == "+a.actionId);
		}
		
		/**
		 * 删除死亡英雄
		 */ 
		private function actionQuit(a:ActionQuit):void{
			for each(h in heroesInBattle){
				if(h != null){
					if(h.key == a.key){
						h.heroStatus = ReportConstants.HERO_QUIT;
						heroesInBattle[h.location] = null;
					}
				}
			}
		}
		
		/**
		 * 删除英雄逃离
		 */ 
		private function actionRetreate(a:ActionRetreat):void{
			for each(h in heroesInBattle){
				if(h != null){
					if(h.key == a.key){
						h.heroStatus = ReportConstants.HERO_RETREAT;
						heroesInBattle[h.location] = null;
					}
				}
			}
		}
		
		private function actionRockConsume(a:ActionRockConsume):void{
			this.stoneNumber -= a.consume;
		}
		
		private function actionRockFallMiss(a:ActionRockMiss):void{
			
		}
		
		private function actionTrapWork(a:ActionTrapWork):void{
			this.trapNumber -= a.trapCount;
		}
		
		private function actionTrapAttack(a:ActionTrapATK):void{
			// 伤害多少个数
			army = getBeanByKey(a.key).armys[a.p];
			army.setDamage(- a.count*army.singleLife);
			armyDamage(army.group,-a.count*army.singleLife);
		}
		
		private function actionWait(a:ActionWait):void{
			
		}
		
		private function actionAtk(a:ActionATK):void{
			if(a.k2 <0){
				// 攻击城防
				switch(a.k2){
					case BattleConstants.KEY_ARROW_TOWER:
						this.towerLife -= a.dmg;
					break;
					case BattleConstants.KEY_WALL:
						this.wallLife -= a.dmg; 
					break;
				}
				return;
			}
			army = getBeanByKey(a.k2).armys[a.p2];
			army.setDamage(- a.dmg);
			armyDamage(army.group,-a.dmg);
		}
		
		public function getGroupHp(group:Number):Number{
			return groupHp[group];
		}
		
		public function getGroupHpTotal(group:Number):Number{
			return groupHpTotal[group];
		}
		
		private function armyDamage(group:Number,damage:Number):void{
			groupHp[group] += damage;
		}
		
		public function getBeanByKey(key:Number):Hero{
			return heroes[key];
		}
		
		public function getBeanesCount():Number{
			return heroes.length;
		}
		
		public function isHeroInBattle(hKey:int):Boolean{
			for each(h in heroesInBattle){
				if(h == null)continue;
				if(h.key == hKey){
					return true;
				}
			}
			return false;
		}
		
		private var tempPoint:Point;
		private function setArmyAbsolutePoints(h1:Hero):void{
			if(h1.armys.length <=0){
				new Error("setArmyAbsolutePoints.error  === "+h1.key);
			}
			for each(army in h1.armys){
				tempPoint = ReportManager.instance.getArmyLocation(h1.location,army.pos,h1.group);
				if(tempPoint.x == 0){
					new Error("the point is null");
				}
				army.absolutePoint = ReportManager.instance.getArmyLocation(h1.location,army.pos,h1.group);
			}
		}
		
	}
}
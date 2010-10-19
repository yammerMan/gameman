package roma.war.render
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	
	import roma.common.constants.BattleConstants;
	import roma.war.constants.ActionConstants;
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
	import roma.war.data.bean.RoundNode;
	import roma.war.render.motion.Army;
	import roma.war.render.motion.Hero;
	
	public class RenderOfWars extends EventDispatcher
	{
		private var _width:Number;
		private var _height:Number;
		
		public var troopMaker:EmbedTroopMaker;
		public var weaponMaker:EmbedWeaponMaker;
		public var otherMaker:EmbedOthersMaker;
		private var signTextMaker:SignTextMaker;
		
		internal var cacheBMP:BitmapData;
		
		public function get width():Number{
			return _width;
		}
		public function get height():Number{
			return _height;
		}
		private var rect:Rectangle;
		
		public function RenderOfWars(width:Number,height:Number)
		{
			_width = width;
			_height = height;
			
			rect = new Rectangle(0,0,_width,_height);
			cacheBMP = new BitmapData(width,height,true,0);
		}
		
		public function roundInit():void{
			weaponMaker.removeAllWeapons();
			otherMaker.removeAllOthers();
		}
		
		public function makeEmbedMaker():void{
			troopMaker = new EmbedTroopMaker();
			weaponMaker = new EmbedWeaponMaker();
			otherMaker = new EmbedOthersMaker();
			signTextMaker = new SignTextMaker();
		}
		
		public function dispose():void{
			cacheBMP.dispose();
			cacheBMP = new BitmapData(width,height,true,0);
//			if(wallBMP)wallBMP.dispose();
		}
		private var lastRound:int = 0;
		public function addAction(a:ActionItem):void{
//			trace("renderOfWar.addAction == "+a.actionId);
			if(a.round != lastRound){
				lastRound = a.round;
				signTextMaker.heroDamageCount();
			}
			switch(a.type){
				case ActionConstants.ACTION_TYPE_ATK:
					actionAtk(a as ActionATK);
				break;
				case ActionConstants.ACTION_TYPE_MOVE:
					actionMove(a as ActionMove);
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
					ActionTrapWork(a as ActionTrapWork);
				break;
				case ActionConstants.ACTION_TYPE_WAIT:
					actionWait(a as ActionWait);
				break;
			}
		}
		
		public function updateFieldScene():void{
			var wd:WarDataBuffer = ReportManager.instance.warData;
			var h:Hero;
			for each(h in wd.heroesInBattle){
				if(h != null)
				troopMaker.addHero(h);
			}
//			trace("renderOfWar.updateFieldScene ");
		}
		
		private function actionMove(a:ActionMove):void{
			var h:Hero= ReportManager.instance.warData.getBeanByKey(a.key);
			if(h == null)return;
			troopMaker.addHero(h);
		}
		
		/**
		 * 攻击
		 */ 
		private function actionAtk(a:ActionATK):void{
			if(a.k1 < 0){
				// 城防攻击（箭塔或落石）todo 对邻近的几个箭塔或落石动作同时触发
				var h:Hero = ReportManager.instance.warData.getBeanByKey(a.k2);
				var t:Army = h.getArmyByPos(a.p2);
				switch(a.k1){
					case BattleConstants.KEY_ARROW_TOWER:
						weaponMaker.addWeapon(ActionConstants.ATT_TYPE_TOWER_ARROW,t,a);
						otherMaker.addOthers(ActionConstants.OTHER_TYPE_KILL,t,a);
						signTextMaker.heroByAtkSign(t,a);
					break;
					case BattleConstants.KEY_ROCK_FALL:
						weaponMaker.addWeapon(ActionConstants.ATT_TYPE_WALL_BUILDING_STONE,t,a);
						otherMaker.addOthers(ActionConstants.OTHER_TYPE_SMOKE,t,a);
						otherMaker.addOthers(ActionConstants.OTHER_TYPE_KILL,t,a);
						signTextMaker.heroByAtkSign(t,a); 
					break;
				}
			}
			else{
				var h1:Hero = ReportManager.instance.warData.heroes[a.k1];
				var t1:Army = h1.getArmyByPos(a.p1);
				if(a.k2 <0){
					// 城防被攻击
					switch(a.k2){
						case BattleConstants.KEY_ARROW_TOWER:
							troopMaker.heroAtk(t1,a);
							signTextMaker.armyAtkEffectSign(t1,a);
							weaponMaker.addWeaponAtoB(t1,a);
						break;
						case BattleConstants.KEY_WALL:
							troopMaker.heroAtk(t1,a);
							signTextMaker.armyAtkEffectSign(t1,a);
							weaponMaker.addWeaponAtoB(t1,a);
						break;
					}
				}else{
					// 英雄之间的攻击
					var h2:Hero = ReportManager.instance.warData.getBeanByKey(a.k2);
					var t2:Army = h2.getArmyByPos(a.p2);
					troopMaker.heroAtk(t1,a);
					weaponMaker.addWeaponAtoA(t1,t2,a);
					otherMaker.addOthers(ActionConstants.OTHER_TYPE_KILL,t2,a);
					signTextMaker.armyAtkEffectSign(t1,a);
					signTextMaker.heroByAtkSign(t2,a);
				}
			}
		}
		
		private function actionRetreate(a:ActionRetreat):void{
			var h:Hero = ReportManager.instance.warData.getBeanByKey(a.key);
			if(h == null)return;
			troopMaker.removeHero(h);
		}
		
		private function actionQuit(a:ActionQuit):void{
			var h:Hero = ReportManager.instance.warData.getBeanByKey(a.key);
			if(h == null)return;
			troopMaker.removeHero(h);
		}
		
		private function actionTrapAttack(a:ActionTrapATK):void{
			var h:Hero = ReportManager.instance.warData.getBeanByKey(a.key);
			if(h == null)return;
			var t:Army = h.getArmyByPos(a.p);
			weaponMaker.addWeapon(ActionConstants.ATT_TYPE_TRAP,t,a);
			signTextMaker.heroByAtkSign(t,a);
		}
		
		private function actionTrapWork(a:ActionTrapWork):void{
			
		}
		
		private function actionRockConsume(a:ActionRockConsume):void{
			
		}
		
		private function actionRockFallMiss(a:ActionRockMiss):void{
			
		}
		
		private function actionWait(a:ActionWait):void{
			var h:Hero = ReportManager.instance.warData.getBeanByKey(a.key);
			if(h == null)return ;
			var t:Army = h.getArmyByPos(a.pos);
//			otherMaker.addOthers(a);
		}
		
		/**
		 * 是否为每一回合的临界点
		 */ 
		private function checkIsRoundEndAction(aId:int):Boolean{
			var r:RoundNode;
			for each(r in ReportManager.instance.battleReportType.battle.frames.round){
				if(r.startIndex != 0 && r.endIndex == aId){
					return true;
				}
			}
			return false;
		}
		
		private function fill(g:Graphics):void{
			g.clear();
			g.beginBitmapFill(cacheBMP,null,false,false);
			g.drawRect(0,0,width,height);
			g.endFill();
		}
		
		public function render(g:Graphics):void{
			dispose();
			renderAllItems(g);
		}
		
		/**
		 * 执行所有动作
		 */ 
		internal function renderAllItems(g:Graphics):void{
			troopMaker.playTroops(cacheBMP);
			weaponMaker.playWeapon(cacheBMP);
			otherMaker.playOthers(cacheBMP);
			signTextMaker.playText(cacheBMP);
			fill(g);
		}
		
	}
}
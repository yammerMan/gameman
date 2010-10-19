package roma.logic.object.hero
{
	import roma.common.constants.BattleConstants;
	import roma.common.constants.BuffConstants;
	import roma.common.constants.FieldConstant;
	import roma.common.constants.HeroManConstants;
	import roma.common.constants.TechConstant;
	import roma.common.valueObject.HeroInfoBean;
	import roma.common.valueObject.HeroManBean;
	import roma.logic.GameContext;
	import roma.logic.object.buff.BuffResManager;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.object.field.FieldHelper;
	import roma.logic.object.tech.BaseTechObj;
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.TechRule;
	import roma.logic.rule.TroopRule;
	import roma.resource.ImgManager;
	import roma.util.MultiLang;
	
	import views.mainModules.map.diamond2.MapDataByteArray;
	
	[Bindable]
	public class HeroObj
	{
		public var selectedInUi:Boolean = false;
		
		public var heroInfo:HeroInfoBean;
		
		public var buffManager:BuffResManager;
		
		public var armyManager:HeroArmyManager;
		
		/** 英雄状态logo*/
		public var stateIcon:Class;
		
		public var logoClass:String;

		/** 管理能力*/
		public var politics:int;
		public var politicsBuffAdd:int;

		/** 武力 */
		public var powers:int;
		public var powersBuffAdd:int;

		/** 防御力 */
		public var defend:int;
		public var defendBuffAdd:int;

		/** 统帅力 */
		public var leadership:int;
		public var tempLeadership:int; 
		public var troopStrength:int;

		public var isCaptive:Boolean;//是否被抓了
		public var isChief:Boolean;//是否城守
		public var isMoving:Boolean;//是否移动中
		public var isInCastle:Boolean;//是否在城内
		public var isGuardStatus:Boolean; //是否驻守状态
		
		public var curAction:String; //当前动态
		public var canUpdate:Boolean   // 是否可以升级
		
		public var remainTimeStr:String;
		
		public var castleObj:CastleObj;
		
		public function HeroObj(castle:CastleObj , bean:HeroManBean)
		{
			this.castleObj = castle;
			this.buffManager = new BuffResManager(bean.buffersArray);
			this.armyManager = new HeroArmyManager(bean.troopsArray , bean.retreatCondition);
			this.reCalcTroopStrength();
			heroInfo = bean.heroInfo;
			this.refreshBmpClass();
			this.afterBuffUpdate();
		}
		
		public function updateHeroObj():void{
			this.refreshBmpClass();
			this.afterBuffUpdate();
			this.reCalcTroopStrength();
		}
		
		public function get belongCastle():String {
			return this.castleObj.name+ GameContext.getFieldPostionString(this.castleObj.idField);
		}
		
		/**
		 * 获得剩余时间的字符串
		 */
		public function resetRemainTimeStr():void {
			if(this.heroInfo.status == HeroManConstants.STATUS_GROWTH){
				this.remainTimeStr=GameContext.getRemainTimeStr(this.heroInfo.growthEndTime);
			}else{
				this.remainTimeStr=GameContext.getRemainTimeStr(this.heroInfo.arriveTime);
			}
		}
		
		public function get targetStr():String{
			return this.getTargetName();
		}
		
		public function get arriveTimeStr():String {
			return GameContext.toLocalTimeStr(this.heroInfo.arriveTime);
		}
		
		public function get heroExpNeetRate():Number{
			var learnTech:BaseTechObj = GameContext.instance.getPlayerObj().techManager.getTechObjById(TechConstant.LEARNING);
			if (learnTech !=null) {
				var rule:TechRule = learnTech.getCurCastleTechRule(this.castleObj);
				if (rule!=null) {
					return 1-rule.techEffect/100;
				}else{
				return 1;
				}
			}else{
				return 1;
			}
		}
		
		public function afterBuffUpdate():void {
			this.politics = this.heroInfo.manages +this.heroInfo.managesAdd;
			this.powers = this.heroInfo.powers + this.heroInfo.powersAdd;
			this.defend = this.heroInfo.stratagems + this.heroInfo.stratagemsAdd;
			this.politicsBuffAdd = 0;
			this.powersBuffAdd = 0;
			this.defendBuffAdd = 0;
			this.remainTimeStr = GameContext.getRemainTimeStr(this.heroInfo.arriveTime);
			
			var s:int = this.heroInfo.status;
			this.isCaptive = (s == HeroManConstants.STATUS_SEIZED);
			this.isChief =   (s == HeroManConstants.STATUS_CHIEF);
			this.isMoving =  (s == HeroManConstants.STATUS_FORWARD || s == HeroManConstants.STATUS_BACKWARD);
			this.isInCastle = (s == HeroManConstants.STATUS_CHIEF || s == HeroManConstants.STATUS_FREE);
			this.isGuardStatus = (s == HeroManConstants.STATUS_GUARD);
			this.canUpdate = this.heroInfo.exp > Math.pow(this.heroInfo.level,2)*100*heroExpNeetRate?true:false;
			
			this.curAction = this.getCurAction();
			
			if (this.buffManager.hasBuff(BuffConstants.HERO_INC_POLITICS)) {
				this.politicsBuffAdd = Math.round(politics*HeroManConstants.BUFF_ADD_PERCENT*.01);
			}
			if (this.buffManager.hasBuff(BuffConstants.HERO_INC_ATTACK)) {
				this.powersBuffAdd = Math.round(powers*HeroManConstants.BUFF_ADD_PERCENT*.01);
			}
			if (this.buffManager.hasBuff(BuffConstants.HERO_INC_INTELLIGENCE)) {
				this.defendBuffAdd = Math.round(defend*HeroManConstants.BUFF_ADD_PERCENT*.01);
			}

			this.leadership = this.calcLeadership(this.politics+this.politicsBuffAdd);
			this.tempLeadership = this.leadership;
		}
		
		/**
		 * 获得任务类型的字符串
		 */
		public function get missionStr():String {
			if (this.heroInfo.mission == BattleConstants.ARMY_MISSION_ATTACK) {
				return MultiLang.msg("military.mission.attack");
			} else  if (this.heroInfo.mission == BattleConstants.ARMY_MISSION_LOOT) {
				return MultiLang.msg("military.mission.loot");
			}else if(this.heroInfo.mission == BattleConstants.ARMY_MISSION_CONQUEST){
				return MultiLang.msg('diplomacy.conquest.label');
			}else if(this.heroInfo.mission == BattleConstants.ARMY_MISSION_REINFORCE){
				return MultiLang.msg("military.mission.reinforce");
			}else if(this.heroInfo.mission == BattleConstants.ARMY_MISSION_INDEPENDENT){
				// 独立战斗的显示
				return MultiLang.msg("diplomacy.conquest.battle.label");
			}else if(this.heroInfo.mission == BattleConstants.ARMY_MISSION_TRAINNING){
				if(MapDataByteArray.instance.isRatterNpcCastle(GameContext.getFieldPostionX(this.heroInfo.targetFieldId),GameContext.getFieldPostionY(this.heroInfo.targetFieldId))){
					return MultiLang.msg('military.mission.quell');
				}else if(MapDataByteArray.instance.isTrainNpcCastle(GameContext.getFieldPostionX(this.heroInfo.targetFieldId),GameContext.getFieldPostionY(this.heroInfo.targetFieldId))){
					return MultiLang.msg('military.mission.manoeuvre');
				}
				return MultiLang.msg('military.mission.manoeuvre');
			}
			else{
				return this.heroStatus;
			}
		}

		/**
		 * 设置英雄当前的状态
		 */
		private function getCurAction():String {
			if (this.isMoving) {
				if (this.heroInfo.status == HeroManConstants.STATUS_FORWARD) {
					return MultiLang.msg("hero.action.forwardTo{0}" , this.getTargetName());
				} else {
					return MultiLang.msg("hero.action.backwardFrom{0}" , this.getTargetName());
				}
			} else if (this.isGuardStatus) {
				return MultiLang.msg("hero.action.guardAt{0}" , this.getTargetName());
			} else if (this.heroInfo.status == HeroManConstants.STATUS_SEIZED) {
				return MultiLang.msg("info.status.seized");
			}else if(this.heroInfo.status == HeroManConstants.STATUS_IN_BATTLE_FIELD){
				return MultiLang.msg("hero.action.battleAt{0}" , this.getTargetName());
			}else if(this.heroInfo.status == HeroManConstants.STATUS_GROWTH){
				return MultiLang.msg('hero.temper.btnLabel');
			}
			else {
				return MultiLang.msg("hero.action.inCastle");
			}
		}
		
		public function get heroStatus():String {
			var heroStatusStr:String="";
			switch(this.heroInfo.status){
				case HeroManConstants.STATUS_CHIEF:
					heroStatusStr=MultiLang.msg("info.status.chief");
					break;
				case HeroManConstants.STATUS_FREE:
					heroStatusStr=MultiLang.msg("info.status.free");
					break;
				case HeroManConstants.STATUS_GUARD:
					heroStatusStr=MultiLang.msg("info.status.guard");
					break;
				case HeroManConstants.STATUS_SEIZED:
					heroStatusStr=MultiLang.msg("info.status.seized");
					break;
				case HeroManConstants.STATUS_BACKWARD:
					heroStatusStr=MultiLang.msg("info.status.backward");
					break;
	 			case HeroManConstants.STATUS_FORWARD:
					heroStatusStr=MultiLang.msg("info.status.forward");
					break;
				case HeroManConstants.STATUS_GROWTH:
					heroStatusStr=MultiLang.msg('hero.temper.btnLabel');
					break;
				case HeroManConstants.STATUS_IN_BATTLE_FIELD:
					heroStatusStr=MultiLang.msg('info.status.battle');
					break;
				default:
					 heroStatusStr="Status:"+this.heroInfo.status;
			}
			return heroStatusStr;
	   }
		
		/**
		 * 获得当前的英雄的任务（即英雄行为+状态）
		 * 主要在情报中显示
		 */ 
		public function get curTask():String{
			var m:String = this.missionStr;
			var s:String = this.heroStatus;
			if(this.heroInfo.status == HeroManConstants.STATUS_GUARD){
				return s;
			}else{
				return m+" / "+s;
			}
		}
		
		/**
		 * 获得目的地的名字，如果是城堡就返回城堡名，否则就返回地形名
		 */
		private function getTargetName():String {
			var res:String;
			if (this.heroInfo.targetFieldType == FieldConstant.TYPE_CITY) {
				res = this.heroInfo.targetFieldName;
			} else {
				res = FieldHelper.getFieldName(this.heroInfo.targetFieldType);
			}
			var x:int = this.heroInfo.targetFieldId / 10000;
			var y:int = this.heroInfo.targetFieldId % 10000;
			res += " [" + x + "," + y + "]";
			return res;
		}
		
		private function refreshBmpClass():void {
			this.logoClass = ImgManager.clazz(heroInfo.logoUrl);
						
			switch( heroInfo.status){
				case HeroManConstants.STATUS_CHIEF:
					stateIcon = ImgManager.clazz('hero.heroStatus.castellan');
					break;
				case HeroManConstants.STATUS_FREE:
					stateIcon = ImgManager.clazz('hero.heroStatus.spare');
					break;
				case HeroManConstants.STATUS_GUARD:
					stateIcon = ImgManager.clazz('hero.heroStatus.guard');
					break;
				case HeroManConstants.STATUS_SEIZED:
					stateIcon = ImgManager.clazz('hero.heroStatus.seized');
					break;
				case HeroManConstants.STATUS_BACKWARD:
					stateIcon = ImgManager.clazz('hero.heroStatus.backward');
					break;
 				case HeroManConstants.STATUS_FORWARD:
					stateIcon = ImgManager.clazz('hero.heroStatus.forward');
					break;
				case HeroManConstants.STATUS_GROWTH:
					stateIcon = ImgManager.clazz('hero.heroStatus.growth');
				break; 
				case HeroManConstants.STATUS_IN_BATTLE_FIELD:
					stateIcon = ImgManager.clazz('hero.heroStatus.forward');
				break; 
			}
		}
		
		public function updateHeroInfo(bean:HeroInfoBean):void {
			bean.copyToBe(this.heroInfo);
			this.refreshBmpClass();
			this.afterBuffUpdate();
		}
		
		/**
		 * 是否能和另外一个英雄交换部队
		 */
		public function isCanSwapTroopWithOther(hero:HeroObj):Boolean {
			if (this.heroInfo.id == hero.heroInfo.id) {
				//不能和自己
				return false;
			}
			
			if (!this.heroInfo.canAssign || !hero.heroInfo.canAssign) {
				//必须能分配兵力
				return false;
			}
			
			if (this.isGuardStatus && hero.isGuardStatus && this.heroInfo.targetFieldId != hero.heroInfo.targetFieldId) {
				//如果 都是在驻防，但驻防的地点不一样，则不行
				return false;
			}
			
			if (this.isInCastle && hero.isGuardStatus || this.isGuardStatus && hero.isInCastle) {
				//必须在同一个地点
				return false;
			}
			return true;
		}
		
		/**
		 * 计算统率力
		 */
		public function calcLeadership(manages:int):int {
			var per:Number = 0;
			per += manages * HeroManConstants.ONE_POINT_ADD_LEADERSHIP;
			
			var addPer:int = 100;
			var rule:TechRule= GameContext.instance.getPlayerObj().techManager.getTechObjById(TechConstant.LEADERSHIP).getCurCastleTechRule(castleObj);

			if (rule!=null)
				addPer += rule.techEffect;

			if (this.buffManager.hasBuff(BuffConstants.HERO_INC_LEADERSHIP))
				addPer += HeroManConstants.BUFF_ADD_PERCENT;
			
			return (HeroManConstants.BASE_LEADERSHIP +per) * (addPer/ 100); 
		}
		
		/**
		 * 计算军队的军力
		 */
		public function reCalcTroopStrength():void {
			this.troopStrength = this.armyManager.calcTroopStrength();
		}
		
		/**计算英雄还可以接受指定兵种的最大数量*/
		public function getMaxContain(troop:int):int{
			var rule:TroopRule = GameRuleHelper.instance.getTroopRule(troop);
			return int((this.leadership-this.troopStrength)/rule.population);
		}
		
		/**
		 * 获得该英雄移动带一个所需要的秒数
		 */
		public function getMoveNeedTimeInSecond(fx:int , fy:int):int {
			var cx:int = castleObj.idField / 10000;
			var cy:int = castleObj.idField % 10000;
			var dist:Number = GameContext.getDistance(cx, cy , fx, fy);//距离
			
			var speed:Number = this.armyManager.getArmyMinSpeed();//速度
			
			return int(dist/speed);
		}
		/**
		 * 是否允许撤回
		 */ 
		public function isCanCallBack():Boolean{
			return this.heroInfo.callBackable;
		}
		
		/**
		 * 战局开始了多少时间(分钟)
		 */ 
		public function battleGoTime():int{
			var now:Number = new Date().valueOf();
			var r:Number = (now - GameContext.instance.getTimeDis() - this.heroInfo.startTime)/1000/60;
			return r;
		}
		
	}
}
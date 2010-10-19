package roma.logic.object.building
{
	import animation.AniPlayer;
	import animation.AnimationManager;
	import animation.BaseAnimationData;
	import animation.IAniPlayer;
	
	import flash.display.BitmapData;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.BuffConstants;
	import roma.common.constants.BuildingConstant;
	import roma.common.constants.GeneralConstants;
	import roma.common.constants.InteriorConstant;
	import roma.common.controller.CommonResponse;
	import roma.common.controller.troop.MayFinishAllResponse;
	import roma.common.valueObject.ArchitectureBean;
	import roma.common.valueObject.MaterialBean;
	import roma.logic.CaesaryConfig;
	import roma.logic.GameContext;
	import roma.logic.object.buff.BaseBuffObj;
	import roma.logic.object.castle.CastleLevelConstant;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.object.player.ItemResManager;
	import roma.logic.rule.BaseRule;
	import roma.logic.rule.BuildingRule;
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.ItemDependData;
	import roma.logic.rule.ItemRule;
	import roma.logic.rule.ruleCheck.RuleCheckResult;
	import roma.message.EvtDispacther;
	import roma.message.events.WindowSwitchEvent;
	import roma.util.JavaScriptHelper;
	import roma.util.MultiLang;
	
	import sound.MsgSound;
	
	import views.BeginnerGuide;
	import views.spreadUI.MyAlert;
	import views.spreadUI.beginnerGuide.MyAlert1;
	import views.spreadUI.speedUp.ItemSelectSpeedUpWin;
	
	[Bindable]
	public class BaseBuilding 
	{
		private static var log:ILogger = Log.getLogger("roma.logic.object.BaseBuildingObj");

		public var finishTime:Number;
		public var level:int;
		public var position:int;
		public var status:int;
		public var timeNeed:int;
		public var typeId:int;
		public var buildingStatusStr:String;
		public var isCanUpgrade:Boolean;

		
		/** 鼠标是否正在该建筑上，由BuildingSpace设置 */
		public var isMouseOver:Boolean = false;		
		
		public var castle:CastleObj;
		
		protected var normalAniPlayer:IAniPlayer;

		private var cacheDigitalPlayer1:AniPlayer;
		private var cacheDigitalPlayer2:AniPlayer;
		
		protected var levelBgPlayer:AniPlayer = new AniPlayer(AnimationManager.buildingLevelBg,53,56);
		protected var levelDigitalPlayer1:AniPlayer = new AniPlayer(AnimationManager.buildingLevelDigital,60,63);
		protected var levelDigitalPlayer2:AniPlayer = new AniPlayer(AnimationManager.buildingLevelDigital,65,63);
		protected var levelDigitalPlayer3:AniPlayer = new AniPlayer(AnimationManager.buildingLevelDigital1,60,63);
		protected var levelDigitalPlayer4:AniPlayer = new AniPlayer(AnimationManager.buildingLevelDigital1,65,63);
		
		/**建筑栅栏*/
		protected var frontFencePlayer:AniPlayer = new AniPlayer(AnimationManager.buildings.frontFenceAni);
		protected var backFencePlayer:AniPlayer = new AniPlayer(AnimationManager.buildings.backFenceAni);
		
		
		/** 建造工人 */
		private var constructingAniArray:Array = new Array();
		
		
		public function BaseBuilding(bean:ArchitectureBean ) {
			log.debug("BaseBuildingObj.newInstance:" + this);
			this.setArchitectureBean(bean);			
			this.initAni();

			this.cacheDigitalPlayer1 = levelDigitalPlayer1;
			this.cacheDigitalPlayer2 = levelDigitalPlayer2;
		}
		
		/**获取当前建筑规则*/
		protected function getCurLevelBuildingRule():BuildingRule {
			if (this.level>0 ) {
				return GameRuleHelper.instance.getBuildingRule(this.typeId , this.level);
			} else {
				return null;
			}
		}

		/**获取下一级建筑规则*/
		public function getNextLevelBuildingRule():BuildingRule {
			if (this.level < BuildingConstant.HIGHEST_LEVEL) {
				return GameRuleHelper.instance.getBuildingRule(this.typeId , this.level + 1 );
			} else {
				return null;
			}
		} 
		
		/**储存建筑属性*/
		private function setArchitectureBean(bean:ArchitectureBean):void {
			this.finishTime = bean.finishTime;
			this.level = bean.level;
			this.position = bean.positionId;
			this.status = bean.status;
			this.timeNeed = bean.timeNeed;
			this.typeId = bean.typeId;
			if(getRemainTimeSec()<=0){//如果剩余时间不大于0，把状态修改为正常
				status=BuildingConstant.STATUS_ORDINARY;
			}
			if (status == BuildingConstant.STATUS_DESTRUCT_ING) {
				this.buildingStatusStr = MultiLang.msg("label.building.status.destructing");
			} else if (status == BuildingConstant.STATUS_UPGRAD_ING){
				this.buildingStatusStr = MultiLang.msg("label.building.status.constructing");
			} else {
				this.buildingStatusStr = "";
			}
		}

		/**判断该建筑是否是唯一性建筑	*/
		public function isUniqueType():Boolean {
			return true;
		}
		
		/** 获得建筑的功能说明 ， 需要覆盖的方法*/
		public function getFuncDesc(level:int):String {
//			if (level>0 && level < BuildingConstant.HIGHEST_LEVEL+1) {
//				var rule:BuildingRule = GameRuleHelper.instance.getBuildingRule(this.typeId , level);
//				if(rule.buff3!=0){
//					return BuildingHelper.instance.getFuncDesc(this.typeId,rule.buildingLevel, rule.buff1 , rule.buff2, rule.buff3);
//				}else if(rule.buff2!=0){
//					return BuildingHelper.instance.getFuncDesc(this.typeId,rule.buildingLevel, rule.buff1 , rule.buff2);
//				}else{
//					return BuildingHelper.instance.getFuncDesc(this.typeId,rule.buildingLevel, rule.buff1);
//				}
//				
//			} else {
//				return "";
//			}
			return BuildingHelper.instance.getBuildingFuncDesc(this.typeId,level);
		}
		
		/**
		 * 获得以秒为单位的剩余时间
		 */
		public function getRemainTimeSec():Number {
			var rt:Number = (this.finishTime - new Date().valueOf() + GameContext.instance.timeDis)/1000;
			if (rt<0) {
				rt = 0;
			}
			return rt;
		}
		
		 /**获取建筑名字 */ 
		public function getName():String {
			return BuildingHelper.instance.getName(this.typeId);
		}
		
		 /**获取建筑说明 */ 
		public function getDesc():String {
			return BuildingHelper.instance.getDesc(this.typeId);
		}
		
		 /**获取建筑功能 */ 
		public function getFunctionDesc():String {
			return BuildingHelper.instance.getFunctionDesc(this.typeId);
		}
		
		/**获取图片对象 */ 
		public function getLogoClass():String{
			return BuildingHelper.instance.getLogoClass(this.typeId,this.level);
		}
		
		/**需要覆盖的方法 */
		public function onClick():void {
			log.debug("onClick(), type={0} , position={1}" , this.typeId , this.position);
		}

		/**需要覆盖的方法 */
		protected function getNormalAniPLayer():IAniPlayer {
			return null;			
		}

		/**可以覆盖的方法 */
		protected function initAni():void {
			this.normalAniPlayer = this.getNormalAniPLayer();
			this.addConstructingAni(AnimationManager.buildings.workingPeople1 , 12 , 50);
			this.addConstructingAni(AnimationManager.buildings.workingPeople , 74 , 50);
		}
				
		protected function addConstructingAni(ani:BaseAnimationData , x:int , y:int):void {
			this.constructingAniArray.push(new AniPlayer(ani,x,y));
		}
		
		/**画建筑级别背景与数字*/
		protected function drawLevel(screen:BitmapData , x:int , y:int):void {
			if (!CaesaryConfig.instance.isShowBuildingLevel) {
				return;
			}
		
			var bg:int = 0;
			with(this){
				if(level>=0 && level<=3){
					bg = 0;
				}else if(level>=4 && level<=7){
					bg = 1;
				}else if(level>=8 && level<=9){
					bg = 2;
				}else{
					bg = 3;
				}
			}
			
			if(this.level>=8){
				this.cacheDigitalPlayer1 = this.levelDigitalPlayer3;
				this.cacheDigitalPlayer2 = this.levelDigitalPlayer4;
			}else{
				this.cacheDigitalPlayer1 = this.levelDigitalPlayer1;
				this.cacheDigitalPlayer2 = this.levelDigitalPlayer2;
			}
			
			this.levelBgPlayer.gotoAndStop(bg , screen , x ,y);
			if (this.level>=10) {
				this.cacheDigitalPlayer1.gotoAndStop(this.level /10 , screen, x, y);
				this.cacheDigitalPlayer2.gotoAndStop(this.level %10 , screen, x, y);
			} else {
				this.cacheDigitalPlayer2.gotoAndStop(this.level , screen, x-2.5, y);
			}
		}
		
		/** 可以覆盖的方法 */
		public function drawToBitmapData(screen:BitmapData, x:int, y:int):void{
			if (this.isConstructing()) {
				//画建造时的动画
				this.backFencePlayer.gotoAndPlay(screen,x,y);
				this.normalAniPlayer.gotoAndPlay(screen,x,y);
				this.frontFencePlayer.gotoAndPlay(screen,x,y);
				this.drawWorkingPeopleToSecne(screen,x,y);				
								
			} else {
				this.normalAniPlayer.gotoAndPlay(screen,x,y);
			}
			this.drawLevel(screen , x , y);
		}
		
		protected function drawWorkingPeopleToSecne(scene:BitmapData,x:int , y:int):void {
			for (var i:int=0 ; i<this.constructingAniArray.length; i++ ) {
				var player:AniPlayer = AniPlayer(this.constructingAniArray[i]);
				player.gotoAndPlay(scene , x , y);
			}
		}
		
		/**是否可拆除到0级*/
		public function isCanDestroy(type:int,ary:ArrayCollection=null):Boolean{
			if(ary!=null){
				if(ary.length>0){
					this.destructTip(type);
					return false;
				}
			}
			
			return true;
		} 
		
		protected function destructTip(type:int):void{
			if(type == BuildingConstant.TYPE_MARKET_BUILDING){
				MyAlert.show(MultiLang.msg('market.destruct.tip'));
			}else if(type == BuildingConstant.TYPE_BARRACKS 
			    || type == BuildingConstant.TYPE_STABLES 
			    ||type == BuildingConstant.TYPE_WORKSHOPS){
				MyAlert.show(MultiLang.msg('barrack.destruct.tip'));
			}else if(type == BuildingConstant.TYPE_AMPHITHEATRE){
				MyAlert.show(MultiLang.msg('hero.isHere'));	
			}
		}
		
		/**建筑更新*/
		public function updateArchitectureBean(bean:ArchitectureBean):void {
			if (this.isConstructing() && bean.status == BuildingConstant.STATUS_ORDINARY) {
				MsgSound.instance.playMsgSound();
			}
			this.setArchitectureBean(bean);
		}
		
		/**当前是否在建筑**/
		public function isConstructing():Boolean {
			return (this.status != BuildingConstant.STATUS_ORDINARY);
		}
		
		/** 获得需要升级的校验结果 */
		public function getRuleCheckResultForUpgrade():RuleCheckResult {
			if (this.level < BuildingConstant.HIGHEST_LEVEL) {
				var rule:BaseRule = GameRuleHelper.instance.getBuildingRule(this.typeId , this.level + 1 );
				return rule.check();
			} else {
				return null;
			}
		} 
		
		/** 获得需要降级的校验结果 */
		public function getRuleCheckResultForDegrade():RuleCheckResult {
			if (this.level < BuildingConstant.HIGHEST_LEVEL+1&&this.level>0) {
				var rule:BaseRule = GameRuleHelper.instance.getBuildingRule(this.typeId , this.level );
				return rule.check();
			} else {
				return null;
			}
		} 
		
		/** 是否能拆除 , 官府、城墙、4种资源田不能拆除 */
		public function isCanDestruct():Boolean {
			return !(this.typeId == BuildingConstant.TYPE_WALL_BUILDING 
				|| this.typeId == BuildingConstant.TYPE_TOWN_HALLS 
				|| this.typeId== BuildingConstant.TYPE_FARM
				|| this.typeId == BuildingConstant.TYPE_MINE_IRON 
				|| this.typeId == BuildingConstant.TYPE_QUARRY 
				|| this.typeId == BuildingConstant.TYPE_SAWMILL);
		}

		/********************************************所有建筑共用接口***********************************/
		
		/**升级建筑*/
		private var itemData:ItemDependData;
		private var itemRule:ItemRule;
		
		public function upgradeBulidding():void{
			var buffObj:BaseBuffObj = GameContext.instance.getPlayerObj().buffManager.getBuffById(BuffConstants.PLAYER_INCREASE_CONSTRUCT_LIMIT);
			if(buffObj !=null){
				if(GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getUnNormalBuilidngArr().length>=BuildingConstant.AFTER_INCREASE_CONSTRUCT_LIMIT){
					MyAlert.show(MultiLang.msg('public.construct.full'));
				}else{
					sureToBuild();
				}
			}else{
				if(GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getUnNormalBuilidngArr().length>=BuildingConstant.NORMAL_CONSTRUCT_LIMIT){
					ItemSelectSpeedUpWin.show(ItemResManager.prolongBuildingProcessItemArrayCollection,null,null,null,sureToBuild);
				}else{
					sureToBuild();
				}
			}
		}
		
		private function recharge(ok:Boolean):void{
			if (ok){
				ClientMain.recharge();
			}
		}
		
		private function sureToBuild():void{
			//当升5、11、9、10级时，需要判断城池是否已经扩张			
			if(this.level== InteriorConstant.FIRST_EXPAND_TOWNHALL_LEVEL_DEPEND && this.castle.level==CastleLevelConstant.CASTLE_LEVEL_ONE){
				MyAlert.show(MultiLang.msg('castle.extend.level',2));
				return;
			}else if(this.level ==InteriorConstant.SECOND_EXPAND_TOWNHALL_LEVEL_DEPEND && this.castle.level == CastleLevelConstant.CASTLE_LEVEL_TWO){
				MyAlert.show(MultiLang.msg('castle.extend.level',3));
				return;
			}
			
			//升级神庙需要先选择神
			if(this.typeId == BuildingConstant.TYPE_TEMPLE && this.castle.godType<=0){
				MyAlert.show(MultiLang.msg('temple.select.first'));
				return;
			}
			
			//是新手的话告诉升级将脱离新手保护期
			if(this.typeId==BuildingConstant.TYPE_TOWN_HALLS && this.level ==4 && GameContext.instance.getPlayerObj().buffManager.getBuffById(BuffConstants.PLAYER_BEGINNER) !=null){
					MyAlert.show(MultiLang.msg('player.beginner.ignore'),isUpgradeNeedItem);
					return;
			}
							
			isUpgradeNeedItem(true);				
		}
		
		private function isUpgradeNeedItem(_true:Boolean):void{
			if(_true){
				if(this.getNextLevelBuildingRule().itemDepends.length>0){
					var itemAry:Array = this.getNextLevelBuildingRule().itemDepends;
					this.itemData = itemAry[0];
					this.itemRule = GameRuleHelper.instance.getItemRuleById(this.itemData.itemId);
					
					MyAlert.show(MultiLang.msg('building.upgrade.need.item',level+1,itemData.count,itemRule.name),isSureUpgrade);
				}else{
					this.upgrade();
				}
			}
		}
		
		/**升级需要物品，是否确定升级*/
		private function isSureUpgrade(_true:Boolean):void{
			if(_true){
				var bean:MaterialBean = GameContext.instance.getPlayerObj().itemManager.getMaterialBeanById(this.itemData.itemId);
				
				if(bean ==null || bean.count <= 0){
					MyAlert.show(MultiLang.msg('public.item.not.enough',this.itemRule.name),buyItemAndUseItem);
				}else{
					this.upgrade();
				}
			}
		}
		
		/**购买物品并使用*/
		private function buyItemAndUseItem(_true:Boolean):void{
			if(_true){
                var b:Boolean = GameContext.instance.getPlayerObj().itemManager.ifEnoughGold(this.itemData.itemId,this.itemData.count);
				if(b){
					this.upgrade();
				}else{
					MyAlert.show(MultiLang.msg('public.coin.lack'),recharge,MultiLang.msg('systemMsg.getGold'));
				}
			}
		}
		
 		private function upgrade():void{
			log.debug("building: "+this.getName()+" upgrade");
			ControllerFactory.getInstance().getBuildingController().upgradeArchitecture(this.castle.cityId,this.position,onUpgradeResPonse);
			
			function onUpgradeResPonse(event:CommonResponse):void{
				if(!event.isSuccess()){
					MyAlert.show(MyAlert.msg(event.errorMsg));
				} else {
					JavaScriptHelper.instance.trackEvent("gameEvent","UpdateBuilding",getName(),level+1);
				}
			}
 		}
		
		/**
		 * 加速
		 */
		public function speedUp(str:String =""):void{
			//5分钟内免费加速,只对升级免费加速
			if(this.status == BuildingConstant.STATUS_UPGRAD_ING){
				if(this.getNextLevelBuildingRule() !=null){
					if(this.getNextLevelBuildingRule().costTime/60<=BuildingConstant.FREE_SPEED_UP_MINS_TIME){
						log.debug("free speedUp start");				
						ControllerFactory.getInstance().getBuildingController().speedUpBuilding(this.castle.cityId,this.position,BuildingConstant.FREE_BUILDING_SPEED_UP_ITEM,onFreeSpeedUp);
						return;
					}
				}
			}
			
			//普通拆除与升级加速物品一样
			ItemSelectSpeedUpWin.instance.speedUpType = ItemSelectSpeedUpWin.COIN_FORBUILD_SPEEDUP;
			ItemSelectSpeedUpWin.instance.buildingObj = this;
			ItemSelectSpeedUpWin.show(ItemResManager.speedItemArrayCollection,speedBuilding);
			
			function onFreeSpeedUp(event:CommonResponse):void{
				if(event.isSuccess()){
					if(str == BeginnerGuide.BEGINNER_GUIDE){
						MyAlert1.instance.show(MultiLang.msg('public.free.speedUp'));
					}else{
						MyAlert.show(MultiLang.msg('public.free.speedUp'));
					}
					JavaScriptHelper.instance.trackEvent("gameEvent","FreeSpeedupBuilding",getName(),level+1);
				}else{
					MyAlert.show(MyAlert.msg(event.errorMsg));
				}
			}
		}
		
 		/**加速建筑*/
		public function speedBuilding(rule:ItemRule=null,fun:Function = null):void{
			log.debug("building: "+this.getName()+" speed");
			
			var itemId:String;
			if(rule ==null){
				itemId = GeneralConstants.SPEED_UP_BY_COINS;
			}else{
				itemId = rule.itemId;
			}

			ControllerFactory.getInstance().getBuildingController().speedUpBuilding(this.castle.cityId,this.position,itemId,onSpeedResPonse);

			function onSpeedResPonse(event:CommonResponse):void{
				if(event.isSuccess()){
					if(fun!=null) fun.apply(this);
					JavaScriptHelper.instance.trackEvent("gameEvent","SpeedupBuilding",getName(),level+1);
					if(rule ==null) JavaScriptHelper.instance.addItemLog(1,null,JavaScriptHelper.COIN_SPEED,ItemSelectSpeedUpWin.instance.needCoin);
				}else{
					MyAlert.show(MyAlert.msg(event.errorMsg));
				}
			}
		}
		
		/**取消建筑*/
		public function cancelBuilding():void{
			log.debug("building: "+this.getName()+" cancel");

			ControllerFactory.getInstance().getBuildingController().cancleBuilding(this.castle.cityId,this.position,onCancelResPonse);

			function onCancelResPonse(event:CommonResponse):void{
				if(event.isSuccess()){
					//当是0级的建筑取消的时候直接关闭窗口
					if(level == 0){
						EvtDispacther.instance.eventDispatch(WindowSwitchEvent.WINDOW_CLOSE_ID);
					}
				}else{
					MyAlert.show(MyAlert.msg(event.errorMsg));
				}
			}
		}
		
		/**拆除建筑 */ 
		public function destructDownBuilding(isComplete:Boolean):void{
			log.debug("building: "+this.getName()+" demolition  "+isComplete);

			ControllerFactory.getInstance().getBuildingController().destructDownBuilding(this.castle.cityId,this.position,isComplete,onDestructResPonse);

			function onDestructResPonse(event:CommonResponse):void{
				if(!event.isSuccess()){
					MyAlert.show(MyAlert.msg(event.errorMsg));
				}
			}
		}
		
		/********************************************学院、研究所共用接口***********************************/
		
		/**
		 *科技研究 
		 * @param id
		 * 
		 */
		public function startResearch(id:int):void{
			ControllerFactory.getInstance().getTechController().startResearch(this.castle.cityId,this.position,id,onReserchResPonse);
			
			function onReserchResPonse(event:CommonResponse):void{
				if(!event.isSuccess()){
					MyAlert.show(MyAlert.msg(event.errorMsg));
				}
				log.debug("tech: "+id+" startResearch");
			}
		}
		
		/**
		 *科技研究加速 
		 * @param id
		 * @param itemId
		 * 
		 */
		public function speedUpResearch(id:int,itemId:String=null,fun:Function =null):void{
			if(itemId ==null){
				itemId = GeneralConstants.SPEED_UP_BY_COINS;
			}
			
			ControllerFactory.getInstance().getTechController().speedUpResearch(this.castle.cityId,this.position,id,itemId,onSpeedResPonse);
			
			function onSpeedResPonse(event:CommonResponse):void{
				if(event.isSuccess()){
					if(fun !=null) fun.apply(this);
					if(itemId ==null) JavaScriptHelper.instance.addItemLog(1,null,JavaScriptHelper.COIN_SPEED,ItemSelectSpeedUpWin.instance.needCoin);
				}else{
					MyAlert.show(MyAlert.msg(event.errorMsg));
				}
			}
		}

		/**
		 *科技研究取消 
		 * @param id
		 * 
		 */
		public function cancelTechResearch(id:int):void{
			ControllerFactory.getInstance().getTechController().cancelTechResearch(this.castle.cityId,this.position,id,onCancelResPonse);
			
			function onCancelResPonse(event:CommonResponse):void{
				if(!event.isSuccess()){
					MyAlert.show(MyAlert.msg(event.errorMsg));
				}
			}
		}

		/********************************************军营 、马厩、工场共用接口***********************************/
		
		/**
		 *军队生产 
		 * @param type
		 * @param num
		 */
		public function produceMoreTroop(type:int,num:int,method:int):void{
			ControllerFactory.getInstance().getTroopController().produceMoreTroop(this.castle.cityId,this.position,type,num,method,onProduceResPonse);
			
			function onProduceResPonse(event:CommonResponse):void{
				if(!event.isSuccess()){
					MyAlert.show(MyAlert.msg(event.errorMsg));
				}
			}
		}

		/**
		 * 取消军队生产
		 * @param queue
		 */
		public function cancelProduce(queue:int):void{
			ControllerFactory.getInstance().getTroopController().cancelProduce(this.castle.cityId,this.position,queue,onCancelResPonse);
			
			function onCancelResPonse(event:CommonResponse):void{
				if(!event.isSuccess()){
					MyAlert.show(MyAlert.msg(event.errorMsg));
				}
			}
		}

		/**
		 * 加速军队生产
		 * @param queue
		 * @param itemId
		 */
		public function speedTroopProduce(queue:int,itemId:String):void{
			ControllerFactory.getInstance().getTroopController().speedTroopProduce(this.castle.cityId,this.position,queue,itemId,onSpeedResPonse);
			
			function onSpeedResPonse(event:MayFinishAllResponse):void{
				if(!event.isSuccess()){
					MyAlert.show(MyAlert.msg(event.errorMsg));
				}else{
					if(event.finishAll){
						MyAlert.show(MultiLang.msg("public.speedUp.buildingAllDone"));
					}
				}
			}
		}

		/**
		 * 解散部队
		 * @param type
		 * @param num
		 */
		public function disbandTroopss(type:int,num:int,fun:Function=null):void{
			ControllerFactory.getInstance().getTroopController().disbandTroops(this.castle.cityId,this.position,type,num,onDisbandResPonse);
			
			function onDisbandResPonse(event:CommonResponse):void{
				if(event.isSuccess()){
					if(fun!=null){
						fun.apply(this);
					}
				}else{
					MyAlert.show(MyAlert.msg(event.errorMsg));
				}
			}
		}
		
		/*********************************************************4种工人公用接口***************************************************************************/
		
		/**
		 *训练工人 
		 * @param type
		 * @param num
		 * 
		 */		
		public function trainningWorker(type:int,num:int):void{
			ControllerFactory.getInstance().getWorkerController().trainningWorker(this.castle.cityId,type,num,onTrainningWorker);
			
			function onTrainningWorker(event:CommonResponse):void{
				if(!event.isSuccess()){
					MyAlert.show(MyAlert.msg(event.errorMsg));
				}else{
					EvtDispacther.sendEvent(EvtDispacther.TRAINING_WORKER,this);
				}
			}
		}
		
		/**
		 *遣散工人 
		 * @param type
		 * @param num
		 * 
		 */		
		public function severanceWorker(type:int,num:int):void{
			ControllerFactory.getInstance().getWorkerController().severanceWorker(this.castle.cityId,type,num,onSeveranceWorker);
			
			function onSeveranceWorker(event:CommonResponse):void{
				if(!event.isSuccess()){
					MyAlert.show(MyAlert.msg(event.errorMsg));
				}
			}
		}
		
		/**
		 *加速工人生产 
		 * @param itemId
		 * 
		 */		
		public function speedUpTrainning(rule:ItemRule =null,fun:Function=null):void{
			var itemId:String ;
			if(rule ==null){
				itemId = GeneralConstants.SPEED_UP_BY_COINS;
			}else{
				itemId = rule.itemId;
			}
			
			ControllerFactory.getInstance().getWorkerController().speedUpTrainning(this.castle.cityId,itemId,onSpeedUpTrainningResPonse);
			
			function onSpeedUpTrainningResPonse(event:CommonResponse):void{
				if(event.isSuccess()){
					EvtDispacther.sendEvent(EvtDispacther.TRAINING_WORKER);
					if(fun !=null) fun.apply(this);
					if(rule ==null) JavaScriptHelper.instance.addItemLog(1,null,JavaScriptHelper.COIN_SPEED,ItemSelectSpeedUpWin.instance.needCoin);
				}else{
					MyAlert.show(MyAlert.msg(event.errorMsg));
				}
			}
		}
	
		/**
		 *取消工人生产 
		 * 
		 */			
		public function cancelWorkerTrainning():void{
			ControllerFactory.getInstance().getWorkerController().cancelWorkerTrainning(this.castle.cityId,onCancelWorkerTrainningResPonse);
		
			function onCancelWorkerTrainningResPonse(event:CommonResponse):void{
				if(!event.isSuccess()){
					MyAlert.show(MyAlert.msg(event.errorMsg));
				}
			}
		}
	}
}
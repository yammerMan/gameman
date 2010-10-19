package roma.logic.object.building.impl
{
	import animation.AniPlayer;
	import animation.AnimationManager;
	import animation.IAniPlayer;
	
	import flash.utils.Dictionary;
	
	import roma.common.constants.BuildingConstant;
	import roma.common.constants.ResourceConstant;
	import roma.common.constants.TechConstant;
	import roma.common.constants.TradeConstant;
	import roma.common.valueObject.ArchitectureBean;
	import roma.common.valueObject.TransportBean;
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.object.castle.TradeManager;
	import roma.logic.object.tech.BaseTechObj;
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.TechRule;
	
	import views.PopupWindows;
	import views.windows.buildings.market.MarketWin;
	
	/**
	 * 
	 * 市场
	 */	
	public class Market extends BaseBuilding
	{
		
		public function Market(bean:ArchitectureBean)
		{
			super(bean);
		}
		
		/**
		 * 重写父类的方法
		 * 点击弹出界面
		 **/
		override public function onClick():void {
			PopupWindows.openBuildingInfoWin(MarketWin.WINDOW_SHOW ,this);
		}

		/** 获得建筑的动画*/
		override protected function getNormalAniPLayer():IAniPlayer {
			return new AniPlayer(AnimationManager.buildings.marketNormal);
		}
		
		/**
		 * 正在运输的骡马队
		 */ 
		public var oldTransportDic:Dictionary = new Dictionary();
		public function getTransport():int{
			var transportings:int = 0;
			var tradeManager:TradeManager = GameContext.instance.getPlayerObj().getCurCastleObj().tradeManager;
			for each(var t2:TransportBean in tradeManager.transportList){
				if(t2.self)
				transportings += t2.taravanUsed;
				/* if(t2.self && !t2.back){
					transportings += Math.ceil((t2.food+t2.wood+t2.stone+t2.iron+t2.golds)/10000);
					oldTransportDic[t2.id] = Math.ceil((t2.food+t2.wood+t2.stone+t2.iron+t2.golds)/10000);
				}else if(t2.self && t2.back){
					transportings += oldTransportDic[t2.id];
				} */
			}
			return transportings;
		}
		
		/* public function getTrade():int{
			var trades:int = 0;
			var tradeManager:TradeManager = GameContext.instance.getPlayerObj().getCurCastleObj().tradeManager;
			for each(var t1:TransingBusinessBean in tradeManager.transportList){
				trades += Math.ceil(t1.amounts/TradeConstant.RESOURCE_LOAD_PER_CARAVAN);
			}
			return trades;
		} */
		
		/**
		 * 运输车队拥有个数
		 */ 
		public function getTradeSpace():int{
			var lev:int = GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_MARKET_BUILDING).level;
			if(lev <=0){
				return 0;
			}else{
			return GameRuleHelper.instance.getBuildingRule(BuildingConstant.TYPE_MARKET_BUILDING,lev).buff1;}
		}
		
		/**
		 * 挂单空闲个数
		 */
		public function getPendingSpace():int{
			var lev:int = GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_MARKET_BUILDING).level;
			if(lev <=0){
				return 0;
			}else{
			return GameRuleHelper.instance.getBuildingRule(BuildingConstant.TYPE_MARKET_BUILDING,lev).buff2;}
		}
		
		/**
		 * 计算运输时间
		 */
		public function getTransportTime(fid:int):Number{
			var startX:int = GameContext.instance.getPlayerObj().getCurCastleObj().idField/10000;
			var startY:int = GameContext.instance.getPlayerObj().getCurCastleObj().idField%10000;
			var targetX:int = fid/10000;
			var targetY:int = fid%10000;
			var distance:Number = GameContext.getDistance(startX,startY,targetX,targetY);
			
			var marchAbility:BaseTechObj = GameContext.instance.getPlayerObj().techManager.getTechObjById(TechConstant.MARCH_ABILITY);
			var c:CastleObj = GameContext.instance.getPlayerObj().getCurCastleObj();
			var rule:TechRule = marchAbility.getCurCastleTechRule(c);
			var speed:int = 0;
			if(rule != null)
				speed = TradeConstant.TRANS_SPEED*(1+rule.techEffect/100);
			else{
				speed = TradeConstant.TRANS_SPEED;
			}
			return Number(distance/speed);
		}
		
		public function checkResource(t:int,c:int):Boolean{
			var castle:CastleObj = GameContext.instance.getPlayerObj().getCurCastleObj();
			var count:int = 0;
			switch(t){
				case ResourceConstant.TYPE_FOOD:
					count = castle.resourceManager.food.curAmount;
				break;
				case ResourceConstant.TYPE_WOOD:
					count = castle.resourceManager.wood.curAmount;
				break;
				case ResourceConstant.RESOURCE_TYPE_STONES:
					count = castle.resourceManager.stone.curAmount;
				break;
				case ResourceConstant.TYPE_IRON:
					count = castle.resourceManager.iron.curAmount;
				break;
				case ResourceConstant.RESOURCE_TYPE_MONEY:
					count = castle.resourceManager.golds.curAmount;
				break;
			}
			return c<=count;
		}
		
	}
}
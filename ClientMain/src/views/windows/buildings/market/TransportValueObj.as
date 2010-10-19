package views.windows.buildings.market
{
	import roma.common.constants.BuildingConstant;
	import roma.common.constants.ResourceConstant;
	import roma.common.constants.TradeConstant;
	import roma.logic.GameContext;
	import roma.logic.object.building.impl.Market;
	import roma.logic.object.castle.CastleResourceManager;
	
	public class TransportValueObj
	{
		private var resourceManager:CastleResourceManager;
		private var marketObj:Market;
		private var resourceSpace:int = 0;
		
		private var totalValue:int = 0;
		private var valueFun:Function;
		public function TransportValueObj(fun:Function = null)
		{
			valueFun = fun;
		}
		
		public function getValueMax(tId:int):int{
			resourceManager = GameContext.instance.getPlayerObj().getCurCastleObj().resourceManager;
			marketObj = GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_MARKET_BUILDING) as Market;
			resourceSpace = (marketObj.getTradeSpace()-marketObj.getTransport())*TradeConstant.RESOURCE_LOAD_PER_CARAVAN;
			totalValue = valueFun.call(this,tId);
			if(valueFun != null)
			var curSpaceValue:int = Math.max(resourceSpace-totalValue,0);
			switch(tId){
				case ResourceConstant.TYPE_FOOD:
					return Math.min(resourceManager.food.curAmount,curSpaceValue);
				case ResourceConstant.TYPE_WOOD:
					return Math.min(resourceManager.wood.curAmount,curSpaceValue);
				case ResourceConstant.RESOURCE_TYPE_STONES:
					return Math.min(resourceManager.stone.curAmount,curSpaceValue);
				case ResourceConstant.TYPE_IRON:
					return Math.min(resourceManager.iron.curAmount,curSpaceValue);
				case ResourceConstant.RESOURCE_TYPE_MONEY:
					return Math.min(resourceManager.golds.curAmount,curSpaceValue);
				default:
					return 0;
			}
		}
		
	}
}
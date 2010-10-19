package roma.logic.object.castle
{
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.constants.GeneralConstants;
	import roma.common.events.BusinessUpdate;
	import roma.common.events.TransingBusinessUpdate;
	import roma.common.events.TransportUpdate;
	import roma.common.valueObject.BusinessBean;
	import roma.common.valueObject.TransingBusinessBean;
	import roma.common.valueObject.TransportBean;
	import roma.logic.GameContext;
	import roma.message.EvtDispacther;
	import roma.message.events.MarketEvent;
	
	public class TradeManager
	{
		
		private static var log:ILogger = Log.getLogger("roma.logic.object.castle.TradeManager");
		public var tradeList:ArrayCollection = new ArrayCollection();
		public var transingList:ArrayCollection = new ArrayCollection();
		public var transportList:ArrayCollection = new ArrayCollection();
		
		public function TradeManager(castle:CastleObj , tradeArray:ArrayCollection , transingTradeArray:ArrayCollection,transportArray:ArrayCollection)
		{
			tradeList = tradeArray;
			transingList = transingTradeArray;
			transportList = transportArray;
		}
		
		/**
		 * 挂单更新
		 */
		public function updateTrade(event:BusinessUpdate):void {
			if(event.updateType == GeneralConstants.UPDATE_ADD_TYPE){
				tradeList.addItem(event.bean);
			} else {
				//如果不是增加就寻找原来的挂单
				for(var i:int=0;i<tradeList.length;i++){
					if (BusinessBean(tradeList[i]).id == event.bean.id){
						if(event.updateType == GeneralConstants.UPDATE_DELETE_TYPE) {
							//如果是删除就删除了
							tradeList.removeItemAt(i);
						} else {
							//如果是更新就将新的数据复制过去
							event.bean.copyToBe(BusinessBean(tradeList[i]));
						}
						break;
					}
				}
			}
			if(event.cityId == GameContext.instance.getPlayerObj().getCurCastleObj().cityId) {
				EvtDispacther.instance.dispatchEvent(new MarketEvent(MarketEvent.TRADE_UPDATE,tradeList));
			}
		}
		
		/**
		 * 交易完成的更新
		 */
		public function updateTransingTrade(event:TransingBusinessUpdate):void {
			if(event.updateType == GeneralConstants.UPDATE_ADD_TYPE){
				transingList.addItem(event.bean);
			} else {
				for(var i:int =0;i<transingList.length;i++){
					if(TransingBusinessBean(transingList[i]).id == event.bean.id){
						if(event.updateType == GeneralConstants.UPDATE_DELETE_TYPE) {
							//删除
							transingList.removeItemAt(i);
						} else {
							//更新
							event.bean.copyToBe(TransingBusinessBean(transingList[i]));
						}
						break;
					}
				}
			}
			if(event.cityId == GameContext.instance.getPlayerObj().getCurCastleObj().cityId) {
				EvtDispacther.instance.dispatchEvent(new MarketEvent(MarketEvent.TRADE_TRANSING_UPDATE,transingList))
			}
		}
		
		/**
		 * 运输更新
		 */ 
		public function updateTransport(event:TransportUpdate):void{
			log.debug("updateTransport"+event);
			if(event.updateType == GeneralConstants.UPDATE_ADD_TYPE){
				transportList.addItem(event.transport);
			} else {
				for(var i:int=0;i<transportList.length;i++){
					if(TransportBean(transportList[i]).id == event.transportId){
						if(event.updateType == GeneralConstants.UPDATE_DELETE_TYPE) {
							transportList.removeItemAt(i);
						} else {
							event.transport.copyToBe(TransportBean(transportList[i]));
						}
						break;
					}
				}
			}

			if(event.cityId == GameContext.instance.getPlayerObj().getCurCastleObj().cityId){
				EvtDispacther.instance.dispatchEvent(new MarketEvent(MarketEvent.TRANSPORT_UPDATE,transportList));
			}
		}
		
	}
}
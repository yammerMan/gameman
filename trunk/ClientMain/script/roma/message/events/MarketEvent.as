package roma.message.events
{
	import flash.events.Event;

	public class MarketEvent extends Event
	{
		// 市场运输
		public static const TRANSPORT_UPDATE:String = "transportUpdate";
		// 交易成功
		public static const TRADE_TRANSING_UPDATE:String = "tradeTransingUpdate"
		// 挂单的更新
		public static const TRADE_UPDATE:String = "tradeUpdate";
		
		public var eventData:Object = new Object();
		
		public function MarketEvent(type:String,dataObj:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.eventData = dataObj;
			super(type, bubbles, cancelable);
		}
		
	}
}
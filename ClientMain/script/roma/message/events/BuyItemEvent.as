package roma.message.events
{
	import flash.events.Event;
	
	import roma.logic.rule.ItemRule;
	
	public class BuyItemEvent extends Event
	{
		public static const EVENT_NAME:String = "buyitemevent.buy";
		public static const EVENT_NAME_BUY_ONE:String = "buyitemevent.buy.buyone";
		public var itemRule:ItemRule;
		
		public function BuyItemEvent(type:String,data:ItemRule, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.itemRule = data;
		}

	}
}
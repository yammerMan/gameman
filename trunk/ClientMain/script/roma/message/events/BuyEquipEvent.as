package roma.message.events
{
	import flash.events.Event;
	
	import roma.common.valueObject.EquipBean;
	
	public class BuyEquipEvent extends Event
	{
		public static const EVENT_NAME:String = "buyequipevent.buy";
		public static const EVENT_NAME_BUY_ONE:String = "buyequipevent.buy.buyone";
		public static const EVENT_NAME_MYITEM:String = "myItemWinClick";
		public var itemRule:EquipBean;
		
		public function BuyEquipEvent(type:String,data:EquipBean, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.itemRule = data;
		}

	}
}
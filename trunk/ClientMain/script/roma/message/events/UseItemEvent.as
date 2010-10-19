package roma.message.events
{
	import flash.events.Event;
	
	import roma.common.valueObject.MaterialBean;
	
	public class UseItemEvent extends Event
	{
		public static const EVENT_NAME:String = "useitemevent.use";
		public static const USE_ITEM:String = "suer.to.use";
		public var itemBean:MaterialBean;
		public var useCount:int=1;
		
		public function UseItemEvent(type:String,data:MaterialBean,useCount:int=1,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.itemBean = data;
			this.useCount=useCount;
		}

	}
}
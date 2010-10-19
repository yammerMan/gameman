package roma.message.events
{
	import flash.events.Event;

	/**
	 *通用事件，用于数据传输 
	 */
	 	
	public class PublicEvent extends Event
	{
		public var evtData:Object;
		
		public static var COMMON_EVENT:String = "common.event";
				
		public function PublicEvent(type:String,data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.evtData = data;
		}
		
	}
}
package roma.message.events
{
	import flash.events.Event;
	
	public class AllianceHandleEvent extends Event
	{
		public static const EVENT_NAME_LOGOCHANGE:String = "event.name.logochange";
		
		public static const EVENT_NAME_RELATIONCHANGE:String = "event_name_relationchange";
		
		public function AllianceHandleEvent(type:String,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

	}
}
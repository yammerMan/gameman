package roma.message.events
{
	import flash.events.Event;

	public class ConquestEvent extends Event
	{
		public static var APPLY_CONQUEST_UPDATE:String = "applyConquestUpdate";
		public static var CONQUEST_LIST_UPDATE:String = "conquestListUpdate";
		public static var CONQUEST_HOST_UPDATE:String = "conquestHostUpdate";
		
		public function ConquestEvent(type:String,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}
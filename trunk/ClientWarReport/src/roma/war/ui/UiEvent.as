package roma.war.ui
{
	import flash.events.Event;

	public class UiEvent extends Event
	{
		public static const SCROLL_STAY:String = "scrollStay";
		public static const SCROLL_ACTION:String = "scrollAction";
		
		public var eventData:Object = {};
		
		public function UiEvent(type:String,data:Object=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			eventData = data;
			super(type, bubbles, cancelable);
		}
		
	}
}
package roma.message.events
{
	import flash.events.Event;

	public class NewMailEvent extends Event
	{
		
		public static const NEW_MAIL:String = "new.mail";
		
		public function NewMailEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}
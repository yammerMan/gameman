package roma.message.events
{
	import flash.events.Event;
	
	public class PrivateChatEvent extends Event
	{
		public static const EVENT_NAME:String = "chat.private";
		public var playerName:String;
		
		public function PrivateChatEvent(type:String,playerName:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.playerName = playerName		
		}
	}
}
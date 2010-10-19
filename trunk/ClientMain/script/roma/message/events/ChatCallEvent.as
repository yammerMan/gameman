package roma.message.events
{
	import flash.events.Event;

	public class ChatCallEvent extends Event
	{
		public static const TYPE_WORLD:String = "typeWorld";
		public static const TYPE_ALLIANCE:String = "typeAlliance";
		public static const TYPE_PRIVATE:String = "typePrivate";
		
		public static const CHAT_CALL:String = "chatCall";
		
		public var eventData:String;
		public var showType:String;
		
		public function ChatCallEvent(typeStr:String,data:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(typeStr, bubbles, cancelable);
			this.showType = typeStr;
			eventData = String(data);
		}
		
	}
}
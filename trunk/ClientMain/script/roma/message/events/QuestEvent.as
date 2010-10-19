package roma.message.events
{
	import flash.events.Event;

	public class QuestEvent extends Event
	{
		public static var HAS_EVENT_FINISHED:String = "hasEventFinished";
		public static var QUESTCOUNT_CHANGE:String = "questCountChange";
		public static var QUEST_REFRESH:String = "questRefresh";
		
		public var questData:Object;
		
		public function QuestEvent(type:String,data:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.questData = data;
			super(type, bubbles, cancelable);
		}
		
	}
}
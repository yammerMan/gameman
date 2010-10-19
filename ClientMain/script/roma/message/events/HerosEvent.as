package roma.message.events
{
	import flash.events.Event;

	public class HerosEvent extends Event
	{
		public static var HERO_UPDATE:String = "heroUpdate";
		public var evtData:Object;
		
		public function HerosEvent(type:String,obj:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.evtData = obj;
		}
		
	}
}
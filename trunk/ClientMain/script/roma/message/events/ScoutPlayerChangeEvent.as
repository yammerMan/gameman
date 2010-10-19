package roma.message.events
{
	import flash.events.Event;
	
	import roma.common.valueObject.FriendRelationBean;
	import roma.common.valueObject.ScoutPlayerBean;

	public class ScoutPlayerChangeEvent extends Event
	{
		public static var SCOUTPLAYER_CHANGE:String = "ScoutPlayerChange";
		public var eventData:ScoutPlayerBean;
		
		public function ScoutPlayerChangeEvent(type:String,obj:ScoutPlayerBean, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.eventData = obj;
		}
		
	}
}
package roma.message.events
{
	import flash.events.Event;
	
	import roma.common.valueObject.FriendRelationBean;

	public class PlayerRelationChangeEvent extends Event
	{
		public static var PLAYERRELATION_CHANGE:String = "PlayerRelationChange";
		public var eventData:FriendRelationBean;
		
		public function PlayerRelationChangeEvent(type:String,obj:FriendRelationBean, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.eventData = obj;
		}
		
	}
}
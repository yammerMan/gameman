package roma.message.events
{
	import flash.events.Event;

	public class MsgEvent extends Event
	{
		public var data:Object;
		
		public function MsgEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
	}
}
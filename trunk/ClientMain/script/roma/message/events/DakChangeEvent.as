package roma.message.events
{
	import flash.events.Event;
	
	import roma.common.valueObject.PostTransportBean;
	


	/**
	 * 当驿站运输发生改变发生此事件
	 */
	public class DakChangeEvent extends Event
	{
		public static const EVENT_NAME:String = "DakChangeEvent.name";
		
		
		public function DakChangeEvent(type:String,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
		}	
	}
}
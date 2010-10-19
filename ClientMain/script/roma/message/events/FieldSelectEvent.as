package roma.message.events
{
	import flash.events.Event;
	
	import roma.common.valueObject.FieldCollectBean;


	public class FieldSelectEvent extends Event
	{
		public static const FIELD_COLLECT_CHANGE:String = "fieldcollect.change";
		
		public var fieldCollectBean:FieldCollectBean;
		
		public function FieldSelectEvent(type:String,fieldCollectBean:FieldCollectBean,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.fieldCollectBean=fieldCollectBean;
		}	
	}
}
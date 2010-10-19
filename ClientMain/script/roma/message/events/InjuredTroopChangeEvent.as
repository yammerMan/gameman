package roma.message.events
{
	import flash.events.Event;

	public class InjuredTroopChangeEvent extends Event
	{
		public static var INJUREDTROOP_CHANGE:String = "injuredtroopchange";
		public var cityId:int;
		
		public function InjuredTroopChangeEvent(type:String,cityId:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.cityId = cityId;
		}
	}
}
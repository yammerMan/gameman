package roma.message.events
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import roma.logic.object.player.OtherArmyObj;
	
	public class ShowOtherArmyTipEvent extends Event
	{
		public var otherArmyObj:OtherArmyObj;
		public static var SHOWO_THERARMYTIP:String = "showotherarmytip";
		public var curMouseEvent:MouseEvent;
		public function ShowOtherArmyTipEvent(type:String,obj:OtherArmyObj,curMouseEvent:MouseEvent, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.otherArmyObj = obj;
			this.curMouseEvent=curMouseEvent;
		}

	}
}
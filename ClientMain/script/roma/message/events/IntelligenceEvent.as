package roma.message.events
{
	import flash.events.Event;

	public class IntelligenceEvent extends Event
	{
		public static var HAS_BATTLECOUNT_CHANGE:String = "hasBattleCountChange"; 
		public static var HAS_BATTLE_CHANGE:String = "hasBattleChange"; 
		public static var REMOVE_BATTLE:String = "removeBattle";
		public var battleField:Object = {};
		
		public function IntelligenceEvent(type:String,data:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			battleField = data;
			super(type, bubbles, cancelable);
		}
		
	}
}
package roma.message.events
{
	import flash.events.Event;
	
	import roma.logic.object.hero.HeroObj;
	

	
	public class ChiefChangeEvent extends Event
	{
		public static const CHIEF_CHANGE:String = "chief.change";
		public var chief:HeroObj;
		
		public function ChiefChangeEvent(type:String,hero:HeroObj, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.chief = hero;
		}

	}
}
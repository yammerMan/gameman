package roma.message.events
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import roma.logic.object.hero.HeroObj;
	
	public class ShowMyArmyTipEvent extends Event
	{
		public var heroObj:HeroObj;
		public static var SHOW_MYARMYTIP:String = "showmyarmytip";
		public var curMouseEvent:MouseEvent;
		public function ShowMyArmyTipEvent(type:String,obj:HeroObj,curMouseEvent:MouseEvent, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.heroObj = obj;
			this.curMouseEvent=curMouseEvent;
		}

	}
}
package roma.message.events
{

	import flash.events.Event;
	
	import roma.logic.rule.ItemRule;

	public class GoodsSelectEvent extends Event
	{
		
		public var itemRule:ItemRule;
		
		public static const GOODS_SELECT_NAME:String = "GoodsSelectEvent";
		public function GoodsSelectEvent(itemRule:ItemRule, b:Boolean=false, c:Boolean=false)
		{
			super(GOODS_SELECT_NAME, b, c);
			this.itemRule = itemRule;
		}
		
	}
}
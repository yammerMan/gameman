package roma.message.events
{
	import flash.events.Event;
	
	import roma.common.valueObject.ManufactureBean;
	import roma.logic.rule.ItemRule;
	import roma.message.EvtDispacther;
	
	public class ProduceEvent extends Event
	{
	    public var bean:ManufactureBean;
	    
	    public var id:int;
	    
	    public var num:int;
		
		public var isShare:Boolean;
		
		public var rule:ItemRule;
		
		public var evtName:String;
		
	    public var evtData:Object;
	
		public function ProduceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public static function produce(eName:String , tId:int , num:int,isShare:Boolean):void {
			var event:ProduceEvent = new ProduceEvent(eName);
			event.id = tId;
			event.num = num;
			event.isShare = isShare;
			EvtDispacther.instance.dispatchEvent(event);
		}
		
		public static function cancel(eventName:String , produceBean:ManufactureBean):void {
			var event:ProduceEvent = new ProduceEvent(eventName);
			event.bean = produceBean;
			EvtDispacther.instance.dispatchEvent(event);
		}
		
		public static function speedup(eventName:String , produceBean:ManufactureBean, item:ItemRule =null):void {
			var event:ProduceEvent = new ProduceEvent(eventName);
			event.bean = produceBean;
			if(item != null){
				event.rule = item;
			}
			event.evtName = eventName;
			EvtDispacther.instance.dispatchEvent(event);
		}
		
		public static function destruct(eventName:String ,typeId:int, num:int):void {
			var event:ProduceEvent = new ProduceEvent(eventName);
			event.id = typeId;
			event.num = num;
			EvtDispacther.instance.dispatchEvent(event);
		}
		
		public static function refresh(eName:String):void {
			var event:ProduceEvent = new ProduceEvent(eName);
			EvtDispacther.instance.dispatchEvent(event);
		}
	}
}
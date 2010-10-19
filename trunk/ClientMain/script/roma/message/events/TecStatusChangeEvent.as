package roma.message.events
{
	import flash.events.Event;
	
	import roma.logic.object.tech.BaseTechObj;
	

	/**
	 * 当服务器发送科技更新的时候，如果科技的状态发生了变化，就产生这个事件，用于通知生产队列显示界面更新
	 */
	public class TecStatusChangeEvent extends Event
	{
		
		public static const EVENT_NAME:String = "TecStatusChangeEvent.name";
		
		public var tecObj:BaseTechObj;
		
		public function TecStatusChangeEvent(obj:BaseTechObj, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(EVENT_NAME, bubbles, cancelable);
			this.tecObj = obj;
		}
		
	}
}
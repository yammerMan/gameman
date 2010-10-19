package roma.message.events
{
	import flash.events.Event;
	
	public class WindowSwitchEvent extends Event
	{
		public static const WINDOW_CLOSE_ID:String = "window.close.id";
		
		private var evtId:String;
		private var data:Object;
		private var bl:Boolean;		
		
		public static const EVENT_CHANGE:String = "popup.window.change";

		public function WindowSwitchEvent(id:String, eventData:Object=null,b:Boolean=false, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(EVENT_CHANGE, bubbles, cancelable);
			
			this.evtId = id;
			this.data = eventData;
			this.bl =b;
		}
		
		public function getEvtId():String{
			return this.evtId;
		}
		
		public function getBl():Boolean{
			return bl;
		}
				
		public function set eventData(data:Object):void{
			this.data =data;
		}
		
		public function get eventData():Object{
			return this.data;
		}
	}
}
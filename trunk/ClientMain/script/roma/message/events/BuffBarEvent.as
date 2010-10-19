package roma.message.events
{
	import flash.events.Event;
	
	public class BuffBarEvent extends Event
	{
		public static const BUFFBAR_EVENT:String = "buffer.change.event";
		
		private var str:String;
		private var isShow:Boolean
		
		public function BuffBarEvent(isShow:Boolean,str:String="",bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(BUFFBAR_EVENT, bubbles, cancelable);
			this.str = str;	
			this.isShow=isShow;
		}
		
		public function getStr():String{
			return this.str;
		}
		
		public function getIsShow():Boolean{
			return this.isShow;
		}

	}
}
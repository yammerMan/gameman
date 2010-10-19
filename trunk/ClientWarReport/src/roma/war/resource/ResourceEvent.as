package roma.war.resource
{
	import flash.events.Event;

	public class ResourceEvent extends Event
	{
		public static const SETTINGS_COMPLETE:String = "settings_complete";
		public static const LANG_COMPLETE:String = "langComplete";
		public static const OUTSIDE_COMPLETE:String = "outside_complete";
		public static const REPORT_COMPLETE:String = "report_complete";
		
		//public static const ICONS_COMPLETE:String = "icons_complete";
		public static const EMBED_COMPLETE:String = "embed_complete";
		
		public function ResourceEvent(type:String,value:Object=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_value = value;
		}
		
		private var _value:Object = null;
		public function get value():Object{
			return _value;
		}
		
	}
}
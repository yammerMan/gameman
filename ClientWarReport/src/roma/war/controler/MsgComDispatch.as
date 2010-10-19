package roma.war.controler
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class MsgComDispatch extends EventDispatcher
	{
		public static var instance:MsgComDispatch = new MsgComDispatch();
		public function MsgComDispatch(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public static function dispatch(e:Event):void{
			instance.dispatchEvent(e);
		}
	}
}
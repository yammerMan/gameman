package framework.game
{
	import flash.events.Event;

	public class CommandEvent extends Event
	{
		
		public static const EVENT:String = "CommandEvent";
		private var command:String
		private var bean:BaseResponse;
		
		public function CommandEvent(command:String, bean:BaseResponse, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(EVENT, bubbles, cancelable);
			this.command = command;
			this.bean = bean;
		}
		
		public function getThisResponseName():String {
			return this.command;
		}
		
		public function getThisResponse():BaseResponse {
			return this.bean;
		}
		
	}
}
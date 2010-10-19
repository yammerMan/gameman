package framework.game
{
	import framework.socket.CaesaryClient;
	
	public class BaseController
	{
		public var client:CaesaryClient;

		protected function sendMessage(cmdCode:int, params:Object):void {
			if (this.client != null) {
				this.client.sendMessage(cmdCode , params);
			}
		}

	}
}
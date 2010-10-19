package framework.socket
{
	import flash.events.Event;

	public class CaesaryClientEvent extends Event
	{

		public var cmdCode:int;
		public var data:Object;
		
		public function CaesaryClientEvent($p:Object)
		{
			super(CaesaryClient.ON_EXTENSION_RESPONSE);
			if ($p){
				if ($p.data)
				{
					this.data = $p.data;
				}
				if ($p.cmd)
				{
					this.cmdCode = $p.cmd;
				}
			}
		}
		
	}
}
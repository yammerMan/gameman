package framework.socket
{
	public class ConnectionError extends Error
	{
		public function ConnectionError(messageType:String="", id:int=0)
		{
			super(messageType, id);
		}
		
	}
}
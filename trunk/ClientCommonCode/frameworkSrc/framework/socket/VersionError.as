package framework.socket
{
	public class VersionError extends Error
	{
		public function VersionError(messageType:String="", id:int=0)
		{
			super(messageType, id);
		}
		
	}
}
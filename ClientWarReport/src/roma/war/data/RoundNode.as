package roma.war.data
{
	public class RoundNode
	{
		public function RoundNode()
		{
		}
		public var id:Number = -1;
		public var startIndex:Number = -1;
		public var endIndex:Number = -1;
		
		public function toString():String{
			return "[RoundNode] action:"+"("+id+"){"+startIndex+"-"+endIndex+"}";
		}	
	}
}
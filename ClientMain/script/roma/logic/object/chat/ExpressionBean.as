package roma.logic.object.chat
{
	[Bindable]
	public class ExpressionBean
	{
		public var name:String;
		public var id:String;
		
		public function ExpressionBean(i:String,n:String)
		{
			name = n;
			id = i;
		}
	}
}
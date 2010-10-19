package views.windows.functionWins.ranking
{
	import mx.containers.Canvas;
	
	public class BaseRanking extends Canvas
	{
		[Bindable]
		public var searchName:String = "";
		[Bindable]
		public var searchNum:int = 0;
		
		public function BaseRanking()
		{
		}
	}
}
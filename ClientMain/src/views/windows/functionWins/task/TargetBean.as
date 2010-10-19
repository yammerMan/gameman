package views.windows.functionWins.task
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class TargetBean
	{
		public var targetContent:String = "";
		public var finish:Boolean = false;
		
		public function TargetBean(name:String,isTrue:Boolean)
		{
			targetContent = name;
			finish = isTrue;
		}

	}
}
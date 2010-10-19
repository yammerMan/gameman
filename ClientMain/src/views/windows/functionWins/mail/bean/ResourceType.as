package views.windows.functionWins.mail.bean
{
	[Bindable]
	public class ResourceType
	{
		public var food:int;
		public var wood:int;
		public var stone:int;
		public var iron:int;
		public var gold:int;
		public function ResourceType(o:Object)
		{
			food = o.food;
			wood = o.wood;
			stone = o.stone;
			iron = o.iron;
			gold = o.gold;
		}

	}
}
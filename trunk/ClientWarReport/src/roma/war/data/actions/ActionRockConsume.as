package roma.war.data.actions
{
	public class ActionRockConsume extends ActionItem
	{
		public function ActionRockConsume(round:Number)
		{
			super(round);
		}
		public function get consume():Number{
			return contents[1];
		}
	}
}
package roma.war.data.actions
{
	public class ActionRetreat extends ActionItem
	{
		public function ActionRetreat(round:Number)
		{
			super(round);
		}
		public function get key():Number{
			return contents[1];
		}
		
		public function get p():Number{
			return contents[2];
		}	
	}
}
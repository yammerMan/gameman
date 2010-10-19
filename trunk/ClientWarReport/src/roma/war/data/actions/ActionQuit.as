package roma.war.data.actions
{
	public class ActionQuit extends ActionItem
	{
		public function ActionQuit(round:Number)
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
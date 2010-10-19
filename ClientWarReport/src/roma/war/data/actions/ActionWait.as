package roma.war.data.actions
{
	public class ActionWait extends ActionItem
	{
		public function ActionWait(round:Number)
		{
			super(round);
		}
		
		public function get key():Number{
			return contents[1];
		}
		public function get pos():Number{
			return contents[2];
		}
	}
}
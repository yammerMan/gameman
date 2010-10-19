package roma.war.data.actions
{
	public class ActionTrapWork extends ActionItem
	{
		public function ActionTrapWork(round:Number)
		{
			super(round);
		}
		public function get trapCount():Number{
			return contents[1];
		}
		
		public function get hitCount():Number{
			return contents[2];
		}	

	}
}
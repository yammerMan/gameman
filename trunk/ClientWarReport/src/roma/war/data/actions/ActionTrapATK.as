package roma.war.data.actions
{
	public class ActionTrapATK extends ActionItem
	{
		public function ActionTrapATK(round:Number)
		{
			super(round);
		}

		public function get key():Number{
			return contents[1];
		}
		
		public function get p():Number{
			return contents[2];
		}	
		
		public function get count():Number{
			return contents[3];
		}
	}
}
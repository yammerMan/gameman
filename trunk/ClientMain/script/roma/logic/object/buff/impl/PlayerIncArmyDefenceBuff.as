package roma.logic.object.buff.impl
{
	import roma.logic.object.buff.BaseBuffObj;

	public class PlayerIncArmyDefenceBuff extends BaseBuffObj
	{
		public function PlayerIncArmyDefenceBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "PlayerIncArmyDefenceBuff";
		}

		override public function isShow():Boolean {
			return true;
		}
	}
}
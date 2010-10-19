package roma.logic.object.buff.impl
{
	import roma.logic.object.buff.BaseBuffObj;

	public class PlayerTroopReliveBuff extends BaseBuffObj
	{
		public function PlayerTroopReliveBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "PlayerTroopReliveBuff";
		}
		
		override public function isShow():Boolean {
			return true;
		}
	}
}
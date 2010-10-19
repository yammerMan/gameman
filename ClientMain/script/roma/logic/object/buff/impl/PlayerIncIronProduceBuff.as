package roma.logic.object.buff.impl
{
	import roma.common.constants.BuffConstants;
	import roma.logic.object.buff.BaseBuffObj;
	import roma.logic.object.castle.CastleResourceManager;

	public class PlayerIncIronProduceBuff extends BaseBuffObj 
	{
		public function PlayerIncIronProduceBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "PlayerIncIronProduceBuff";
		}

		override public function isShow():Boolean {
			return true;
		}
	}
}
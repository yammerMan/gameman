package roma.logic.object.buff.impl
{
	import roma.common.constants.BuffConstants;
	import roma.logic.object.buff.BaseBuffObj;
	import roma.logic.object.castle.CastleResourceManager;

	public class PlayerIncFoodProduceBuff extends BaseBuffObj
	{
		public function PlayerIncFoodProduceBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "PlayerIncFoodProduceBuff";
		}

		override public function isShow():Boolean {
			return true;
		}
	}
}
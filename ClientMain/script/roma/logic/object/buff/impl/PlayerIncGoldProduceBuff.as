package roma.logic.object.buff.impl
{
	import roma.common.constants.BuffConstants;
	import roma.logic.object.buff.BaseBuffObj;
	import roma.logic.object.castle.CastleResourceManager;

	public class PlayerIncGoldProduceBuff extends BaseBuffObj 
	{
		public function PlayerIncGoldProduceBuff()
		{
			super();
		}

		override protected function getClassName():String {
			return "PlayerIncGoldProduceBuff";
		}

		override public function isShow():Boolean {
			return true;
		}
	}
}
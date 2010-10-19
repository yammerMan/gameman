package roma.logic.object.buff.impl
{
	import roma.common.constants.BuffConstants;
	import roma.logic.object.buff.BaseBuffObj;
	import roma.logic.object.castle.CastleResourceManager;

	public class PlayerIncWoodProduceBuff extends BaseBuffObj 
	{
		public function PlayerIncWoodProduceBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "PlayerIncWoodProduceBuff";
		}

		override public function isShow():Boolean {
			return true;
		}
	}
}
package roma.logic.object.buff.impl
{
	import roma.common.constants.BuffConstants;
	import roma.logic.object.buff.BaseBuffObj;
	import roma.logic.object.castle.CastleResourceManager;

	public class PlayerIncStoneProduceBuff extends BaseBuffObj 
	{
		public function PlayerIncStoneProduceBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "PlayerIncStoneProduceBuff";
		}

		override public  function isShow():Boolean {
			return true;
		}
	}
}
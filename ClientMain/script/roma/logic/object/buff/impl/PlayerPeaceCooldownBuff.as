package roma.logic.object.buff.impl
{
	import roma.logic.object.buff.BaseBuffObj;

	public class PlayerPeaceCooldownBuff extends BaseBuffObj
	{
		public function PlayerPeaceCooldownBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "PlayerPeaceCooldownBuff";
		}
		override public function isShow():Boolean {
			return true;
		}
	}
}
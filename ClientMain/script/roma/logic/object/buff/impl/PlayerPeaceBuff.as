package roma.logic.object.buff.impl
{
	import roma.logic.object.buff.BaseBuffObj;

	public class PlayerPeaceBuff extends BaseBuffObj
	{
		public function PlayerPeaceBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "PlayerPeaceBuff";
		}

		override public function isShow():Boolean {
			return true;
		}
	}
}
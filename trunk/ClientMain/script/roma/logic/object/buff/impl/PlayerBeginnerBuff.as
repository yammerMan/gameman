package roma.logic.object.buff.impl
{
	import roma.logic.object.buff.BaseBuffObj;

	public class PlayerBeginnerBuff extends BaseBuffObj
	{
		public function PlayerBeginnerBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "PlayerBeginnerBuff";
		}

		override public function isShow():Boolean {
			return true;
		}
	}
}
package roma.logic.object.buff.impl
{
	import roma.logic.object.buff.BaseBuffObj;

	public class PlayerKeepSilenceBuff extends BaseBuffObj
	{
		public function PlayerKeepSilenceBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "PlayerKeepSilenceBuff";
		}
		
		override public  function isShow():Boolean {
			return true;
		}
	}
}
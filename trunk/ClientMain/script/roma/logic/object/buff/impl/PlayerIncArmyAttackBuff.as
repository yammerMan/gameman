package roma.logic.object.buff.impl
{
	import roma.logic.object.buff.BaseBuffObj;

	public class PlayerIncArmyAttackBuff extends BaseBuffObj
	{
		public function PlayerIncArmyAttackBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "PlayerIncArmyAttackBuff";
		}

		override public function isShow():Boolean {
			return true;
		}
	}
}
package roma.logic.object.buff.impl
{
	import roma.logic.object.buff.BaseBuffObj;

	public class CastleMoveCooldownBuff extends BaseBuffObj
	{
		public function CastleMoveCooldownBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "CastleMoveCooldownBuff";
		}
	}
}
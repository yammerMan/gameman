package roma.logic.object.buff.impl
{
	import roma.logic.object.buff.BaseBuffObj;

	public class CastleLevyCoolDownBuff extends BaseBuffObj
	{
		public function CastleLevyCoolDownBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "CastleLevyCoolDownBuff";
		}
	}
}
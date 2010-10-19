package roma.logic.object.buff.impl
{
	import roma.logic.object.buff.BaseBuffObj;

	public class CastleConstructingBuff extends BaseBuffObj
	{
		public function CastleConstructingBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "CastleConstructingBuff";
		}
	}
}
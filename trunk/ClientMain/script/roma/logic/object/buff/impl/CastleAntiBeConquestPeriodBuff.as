package roma.logic.object.buff.impl
{
	import roma.logic.object.buff.BaseBuffObj;

	public class CastleAntiBeConquestPeriodBuff extends BaseBuffObj
	{
		public function CastleAntiBeConquestPeriodBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "castleAntiBeConquestBuff";
		}
	}
}
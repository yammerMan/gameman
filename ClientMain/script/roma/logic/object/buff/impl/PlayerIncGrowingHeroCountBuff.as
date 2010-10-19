package roma.logic.object.buff.impl
{
	import roma.logic.object.buff.BaseBuffObj;

	public class PlayerIncGrowingHeroCountBuff extends BaseBuffObj
	{
		public function PlayerIncGrowingHeroCountBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "CastleProcessBuff";
		}
	}
}
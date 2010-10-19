package roma.logic.object.buff.impl
{
	import roma.logic.object.buff.BaseBuffObj;

	public class HeroAwardCoolDownBuff extends BaseBuffObj
	{
		public function HeroAwardCoolDownBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "HeroAwardCoolDownBuff";
		}
	}
}
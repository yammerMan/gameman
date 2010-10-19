package roma.logic.object.buff.impl
{
	import roma.logic.object.buff.BaseBuffObj;

	public class HeroIncIntelligenceBuff extends BaseBuffObj
	{
		public function HeroIncIntelligenceBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "HeroIncIntelligenceBuff";
		}
	}
}
package roma.logic.object.buff.impl
{
	import roma.logic.object.buff.BaseBuffObj;

	public class HeroIncAttackBuff extends BaseBuffObj
	{
		public function HeroIncAttackBuff()
		{
			super();
		}
		
		override protected function getClassName():String {
			return "HeroIncAttackBuff";
		}
	}
}
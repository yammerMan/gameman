package roma.logic.object.tech.impl
{
	import roma.logic.object.castle.CastleResourceManager;
	import roma.logic.object.tech.BaseTechObj;
	import roma.logic.rule.TechRule;

	/**
	 * 冶炼技术.铁锭基础产量*冶炼技术级别*5%=科技加成
	 */
	public class Metallurgy extends BaseTechObj
	{
		public function Metallurgy()
		{
			super();
		}
	}
}
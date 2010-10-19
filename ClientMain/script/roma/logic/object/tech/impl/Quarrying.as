package roma.logic.object.tech.impl
{
	import roma.logic.object.castle.CastleResourceManager;
	import roma.logic.object.tech.BaseTechObj;
	import roma.logic.rule.TechRule;

	/**
	 * 采石技术.石料基础产量*挖掘技术级别*5%=科技加成
	 */
	public class Quarrying extends BaseTechObj
	{
		public function Quarrying()
		{
			super();
		}
	}
}
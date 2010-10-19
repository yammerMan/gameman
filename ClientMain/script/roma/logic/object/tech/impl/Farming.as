package roma.logic.object.tech.impl
{

	import roma.logic.object.castle.CastleResourceManager;
	import roma.logic.object.tech.BaseTechObj;
	import roma.logic.rule.TechRule;

	/**
	 * 耕种技术.粮食基础产量*种植技术级别*5%=科技加成
	 */
	public class Farming extends BaseTechObj
	{
		public function Farming()
		{
			super();
		}
	}
}
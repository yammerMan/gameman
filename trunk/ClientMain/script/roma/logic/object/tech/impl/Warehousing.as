package roma.logic.object.tech.impl
{
	import roma.logic.object.castle.CastleResourceManager;
	import roma.logic.object.tech.BaseTechObj;
	import roma.logic.rule.TechRule;

	/**
	 * 仓储技术.每升1级，增加仓库的可保护的资源量1% 公式：初始可保护的资源量（总储量的10%）*（1+储存技术级别*1%）=加成后可保护资源量
	 */
 	public class Warehousing extends BaseTechObj 
	{
		public function Warehousing()
		{
			super();
		}
	}
}
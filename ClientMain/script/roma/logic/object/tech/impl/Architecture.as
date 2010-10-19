package roma.logic.object.tech.impl
{
	import roma.logic.object.castle.CastleResourceManager;
	import roma.logic.object.tech.BaseTechObj;
	
	/**
	 * 建筑学.每升1级，提高建筑、城墙、箭塔的耐久5% 公式：建筑、城墙、箭塔耐久值*（1+城防技术等级*5%）=加成后耐久
	 */
 	public class Architecture extends BaseTechObj 
	{
		public function Architecture()
		{
			super();
		}
	}
}
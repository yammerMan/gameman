package roma.logic.object.tech.impl
{
	import roma.logic.object.tech.BaseTechObj;
	/**
	 * 维修技术.每升1级，城防工事的修复率提高50%。
	 * 公式：城防初始修复率*（1+维修技术等级*50%）=加成后修复率.城防初始修复率：陷阱5%，箭塔3%，落石6%。
	 */
	public class RepairTechniques extends BaseTechObj
	{
		public function RepairTechniques()
		{
			super();
		}
		
	}
}
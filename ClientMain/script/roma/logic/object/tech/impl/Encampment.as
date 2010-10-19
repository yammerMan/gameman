package roma.logic.object.tech.impl
{
	import roma.logic.object.castle.CastleResourceManager;
	import roma.logic.object.tech.BaseTechObj;

	/**
	 * 扎营技巧.每升一级，营寨移动一格冷却所需的时间减少15秒 公式：初始拔营冷却时间-等级*15秒=加成后拔营冷却时间
	 */
 	public class Encampment extends BaseTechObj
	{
		public function Encampment()
		{
			super();
		}
	}
}
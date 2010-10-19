package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class IronMineNormalAni extends BaseAnimationData
	{
		public function IronMineNormalAni()
		{
			super();

			rect = new Rectangle(0,0,128,96);
			addAction("building.ironMine",0,0);
		}
	}
}
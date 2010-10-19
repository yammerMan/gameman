package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class StableNormalAni extends BaseAnimationData
	{
		public function StableNormalAni()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("building.stableNormal",0,0);
		}
	}
}
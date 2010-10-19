package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class BarrackNormalAni extends BaseAnimationData
	{
		public function BarrackNormalAni()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("building.barrackNormal",0,0);
		}
	}
}
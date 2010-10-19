package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class TempleNormalAni extends BaseAnimationData
	{
		public function TempleNormalAni()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("building.templeNormal",0,0);
		}
	}
}
package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class DakNormalAni extends BaseAnimationData
	{
		public function DakNormalAni()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("building.dakNormal",0,0);
		}
	}
}
package animation.animationData.building
{
	import animation.BaseAnimationData;
	import flash.geom.Rectangle;

	public class AcademyNormalAni extends BaseAnimationData
	{
		public function AcademyNormalAni()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("building.academyNormal",0,0);
		}
	}
}
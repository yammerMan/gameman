package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class MilitaryInstituteNormalAni extends BaseAnimationData
	{
		public function MilitaryInstituteNormalAni()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("building.militaryInstituteNormal",0,0);
		}
	}
}
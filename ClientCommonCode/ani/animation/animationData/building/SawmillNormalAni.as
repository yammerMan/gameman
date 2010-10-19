package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class SawmillNormalAni extends BaseAnimationData
	{
		public function SawmillNormalAni()
		{
			super();

			rect = new Rectangle(0,0,128,96);
			addAction("building.sawmill",0,0);
		}
		
	}
}
package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class AmphitheatreNormalAni extends BaseAnimationData
	{
		public function AmphitheatreNormalAni()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("building.amphitheatreNormal",0,0);
		}
	}
}
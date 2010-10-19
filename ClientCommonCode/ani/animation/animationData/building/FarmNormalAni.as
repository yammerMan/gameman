package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class FarmNormalAni extends BaseAnimationData
	{
		public function FarmNormalAni()
		{
			super();

			rect = new Rectangle(0,0,128,96);
			addAction("building.farm",0,0);
		}
	}
}
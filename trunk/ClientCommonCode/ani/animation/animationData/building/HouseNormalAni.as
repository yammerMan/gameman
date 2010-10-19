package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class HouseNormalAni extends BaseAnimationData
	{
		public function HouseNormalAni()
		{
			rect = new Rectangle(0,0,128,96);
			addAction("building.houseNormal",0,0);
		}
	}
}
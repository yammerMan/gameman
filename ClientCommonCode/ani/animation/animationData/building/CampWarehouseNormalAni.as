package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class CampWarehouseNormalAni extends BaseAnimationData
	{
		public function CampWarehouseNormalAni()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("building.barrackNormal",0,0);
		}
	}
}
package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class WarehouseNormalAni extends BaseAnimationData
	{
		public function WarehouseNormalAni()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("building.wareHouseNormal",0,0);
		}
	}
}
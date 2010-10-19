package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class MarketNormalAni extends BaseAnimationData
	{
		public function MarketNormalAni()
		{
			rect = new Rectangle(0,0,128,96);
			addAction("building.marketNormal",0,0);
		}
	}
}
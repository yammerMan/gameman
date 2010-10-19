package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class QuarryNormalAni extends BaseAnimationData
	{
		public function QuarryNormalAni()
		{
			super();

			rect = new Rectangle(0,0,128,96);
			addAction("building.quarry",0,0);
		}
		
	}
}
package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class BackFenceAni extends BaseAnimationData
	{
		public function BackFenceAni()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("building.backFence",0,0);
		}
	}
}
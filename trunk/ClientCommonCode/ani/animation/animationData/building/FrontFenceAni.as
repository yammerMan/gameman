package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class FrontFenceAni extends BaseAnimationData
	{
		public function FrontFenceAni()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("building.frontFence",0,0);
		}
	}
}
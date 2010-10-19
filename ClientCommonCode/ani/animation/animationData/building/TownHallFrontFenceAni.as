package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class TownHallFrontFenceAni extends BaseAnimationData
	{
		public function TownHallFrontFenceAni()
		{
			super();
			rect = new Rectangle(0,0,190,110);
			addAction("townHall.frontFence",0,0);
		}
	}
}
package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class TownHallBackFenceAni extends BaseAnimationData
	{
		public function TownHallBackFenceAni()
		{
			super();
			rect = new Rectangle(0,0,190,110);
			addAction("townHall.backFence",0,0);
		}
	}
}
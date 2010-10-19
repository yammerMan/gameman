package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;
	
	public class RatterNpcAni extends BaseAnimationData
	{
		public function RatterNpcAni()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("field.ratterNpc",0,0);
		}

	}
}
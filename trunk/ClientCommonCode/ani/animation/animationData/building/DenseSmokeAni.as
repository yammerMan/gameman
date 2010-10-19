package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class DenseSmokeAni extends BaseAnimationData
	{
		public function DenseSmokeAni()
		{
			super();

			rect = new Rectangle(0,0,25,39);
			
			for (var i:int=0; i<12; i++) {
				addAction("ani.denseSmoke",i*25,0);
				addSkipAction(1);
			}
		}
	}
}
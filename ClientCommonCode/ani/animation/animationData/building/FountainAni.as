package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class FountainAni extends BaseAnimationData
	{
		public function FountainAni()
		{
			super();
			rect = new Rectangle(0,0,40,32);
			
			for (var i:int=0; i<6; i++) {
				addAction("ani.fountain",i*40,0);
			}
		}
	}
}
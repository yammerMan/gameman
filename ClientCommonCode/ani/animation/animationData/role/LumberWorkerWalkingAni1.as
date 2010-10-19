package animation.animationData.role
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class LumberWorkerWalkingAni1 extends BaseAnimationData
	{
		public function LumberWorkerWalkingAni1()
		{
			super();

			rect = new Rectangle(0,0,42,42);

			for (var i:int=0; i<7; i++) {
				addAction("ani.woodWorkerWalk1",0,i*42);
			}
			
		}
		
	}
}
package animation.animationData.role
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class WorkerWalkingAni extends BaseAnimationData
	{
		public function WorkerWalkingAni()
		{
			super();

			rect = new Rectangle(0,0,42,42);
			
			for (var i:int=0; i<7; i++) {
				addAction("ani.workerWalk",0,i*42);
			}
			
		}
		
	}
}
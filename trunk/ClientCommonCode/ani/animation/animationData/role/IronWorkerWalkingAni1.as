package animation.animationData.role
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class IronWorkerWalkingAni1 extends BaseAnimationData
	{
		public function IronWorkerWalkingAni1()
		{
			super();

			rect = new Rectangle(0,0,42,42);

			for (var i:int=0; i<7; i++) {
				addAction("ani.ironWorkerWalk1",0,i*42);
			}
		}
	}
}
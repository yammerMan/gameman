package animation.animationData.role
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class IronWorkerWalkingAni extends BaseAnimationData
	{
		public function IronWorkerWalkingAni()
		{
			super();

			rect = new Rectangle(0,0,42,42);

			for (var i:int=0; i<7; i++) {
				addAction("ani.ironWorkerWalk",0,i*42);
			}
		}
		
	}
}
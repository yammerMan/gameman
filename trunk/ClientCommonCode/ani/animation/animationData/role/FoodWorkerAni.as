package animation.animationData.role
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class FoodWorkerAni extends BaseAnimationData
	{
		public function FoodWorkerAni()
		{
			super();

			rect = new Rectangle(0,0,42,42);
			
			for (var i:int=0; i<7; i++) {
				addAction("ani.foodWorker",0,i*42);
			}
		}
	}
}
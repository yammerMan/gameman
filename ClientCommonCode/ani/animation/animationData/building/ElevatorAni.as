package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class ElevatorAni extends BaseAnimationData
	{
		public function ElevatorAni()
		{
			super();

			rect = new Rectangle(0,0,26,47);
			
			for(var i:int =0;i<10;i++){
				this.addAction("ani.elevator",i*26,0);
				this.addSkipAction(3);
			}
			
		}
		
	}
}
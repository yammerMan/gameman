package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class WorkingPeopleAniSec extends BaseAnimationData
	{
		public function WorkingPeopleAniSec()
		{
			super();
			rect = new Rectangle(0,0,42,42);
			
			for (var i:int=0; i<6; i++) {
				addAction("ani.workingPeople1",0,i*42);
			}
		}
		
	}
}
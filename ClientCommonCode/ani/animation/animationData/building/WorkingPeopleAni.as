package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class WorkingPeopleAni extends BaseAnimationData
	{
		public function WorkingPeopleAni()
		{
			super();
			rect = new Rectangle(0,0,42,42);
			
			for (var i:int=0; i<6; i++) {
				addAction("ani.workingPeople",0,i*42);
			}
		}
	}
}
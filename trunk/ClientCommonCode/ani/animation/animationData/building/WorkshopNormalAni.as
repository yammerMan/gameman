package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class WorkshopNormalAni extends BaseAnimationData
	{
		public function WorkshopNormalAni()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("building.workshopNormal",0,0);
		}
	}
}
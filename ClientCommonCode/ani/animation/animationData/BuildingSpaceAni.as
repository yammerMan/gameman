package animation.animationData
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class BuildingSpaceAni extends BaseAnimationData
	{
		public function BuildingSpaceAni()
		{
			super();
			rect = new Rectangle(0,0,128,64);
					
			addAction("town.buildingSpace",0 , 0);
		}
		
	}
}
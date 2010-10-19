package animation.animationData
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;
	
	public class BuildingLevelBgAni extends BaseAnimationData
	{
		public function BuildingLevelBgAni()
		{
			super();
			rect = new Rectangle(0,0,25,25);
					
			for (var i:int=0 ; i<4; i++ ) {
				addAction("buildingLevel.bg",i*25 , 0);
			}
		}
	}
}
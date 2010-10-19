package animation.animationData
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class BuildingLevelDigitalAni extends BaseAnimationData
	{
		public function BuildingLevelDigitalAni()
		{
			super();
			rect = new Rectangle(0,0,5,8);
					
			for (var i:int=0 ; i<=9; i++ ) {
				addAction("buildingLevel.digital",i*5 , 0);
			}
		}
	}
}
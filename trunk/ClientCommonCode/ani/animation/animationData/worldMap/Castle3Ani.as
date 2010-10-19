package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class Castle3Ani extends BaseAnimationData
	{
		public function Castle3Ani()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("field.castle3",0,0);
		}
	}
}
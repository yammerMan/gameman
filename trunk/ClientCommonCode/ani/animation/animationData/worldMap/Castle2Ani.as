package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class Castle2Ani extends BaseAnimationData
	{
		public function Castle2Ani()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("field.castle2",0,0);
		}
	}
}
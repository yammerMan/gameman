package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class Castle1Ani extends BaseAnimationData
	{
		public function Castle1Ani()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("field.castle1",0,0);
		}
	}
}
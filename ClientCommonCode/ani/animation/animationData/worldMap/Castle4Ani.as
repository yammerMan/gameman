package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class Castle4Ani extends BaseAnimationData
	{
		public function Castle4Ani()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("field.castle4",0,0);
		}
	}
}
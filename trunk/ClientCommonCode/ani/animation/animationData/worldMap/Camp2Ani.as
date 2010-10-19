package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class Camp2Ani extends BaseAnimationData
	{
		public function Camp2Ani()
		{
			super();
			rect = new Rectangle(0,0,100,75);
			addAction("field.camp2",0,0);
		}
	}
}
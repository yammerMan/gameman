package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class Camp1Ani extends BaseAnimationData
	{
		public function Camp1Ani()
		{
			super();
			rect = new Rectangle(0,0,100,75);
			addAction("field.camp1",0,0);
		}
	}
}
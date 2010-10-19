package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class Camp4Ani extends BaseAnimationData
	{
		public function Camp4Ani()
		{
			super();
			rect = new Rectangle(0,0,100,75);
			addAction("field.camp4",0,0);
		}
	}
}
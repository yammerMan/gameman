package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class Camp3Ani extends BaseAnimationData
	{
		public function Camp3Ani()
		{
			super();
			rect = new Rectangle(0,0,100,75);
			addAction("field.camp3",0,0);
		}
	}
}
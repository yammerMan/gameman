package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class Desert1Ani extends BaseAnimationData
	{
		public function Desert1Ani()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			
			addAction("field.desert1",0,0);
		}
	}
}
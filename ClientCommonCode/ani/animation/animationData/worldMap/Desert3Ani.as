package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class Desert3Ani extends BaseAnimationData
	{
		public function Desert3Ani()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			
			addAction("field.desert3",0,0);
		}
	}
}
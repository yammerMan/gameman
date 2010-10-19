package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class Desert2Ani extends BaseAnimationData
	{
		public function Desert2Ani()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			
			addAction("field.desert2",0,0);
		}
	}
}
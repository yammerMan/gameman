package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class Hill2Ani extends BaseAnimationData
	{
		
		public function Hill2Ani()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			
			addAction("field.hill2");
		}
	}
}
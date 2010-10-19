package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class Hill3Ani extends BaseAnimationData
	{
		
		public function Hill3Ani()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			
			addAction("field.hill3");
		}
	}
}
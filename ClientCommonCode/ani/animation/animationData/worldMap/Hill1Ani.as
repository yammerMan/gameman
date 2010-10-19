package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class Hill1Ani extends BaseAnimationData
	{
		
		public function Hill1Ani()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			
			addAction("field.hill1",0,0);
		}
	}
}
package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class Forest3Ani extends BaseAnimationData
	{
		public function Forest3Ani()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			
			for(var i:int=0;i<6;i++){
				addAction("field.forest3",i*128,0);
				this.addSkipAction(7);
			}
		}
	}
}
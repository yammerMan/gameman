package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class Forest2Ani extends BaseAnimationData
	{
		public function Forest2Ani()
		{
			super();
			rect = new Rectangle(0,0,128,96);

			for(var i:int=0;i<6;i++){
				addAction("field.forest2",i*128,0);
				this.addSkipAction(6);						
			}
		}
	}
}
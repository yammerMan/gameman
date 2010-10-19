package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class Forest1Ani extends BaseAnimationData
	{
		public function Forest1Ani()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			
			for(var i:int=0;i<6;i++){
				addAction("field.forest1",i*128,0);
				this.addSkipAction(5);
			}
		}
	}
}
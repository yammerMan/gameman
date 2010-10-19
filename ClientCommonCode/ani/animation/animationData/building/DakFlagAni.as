package animation.animationData.building
{
	import animation.BaseAnimationData;
	import flash.geom.Rectangle;

	public class DakFlagAni extends BaseAnimationData
	{
		public function DakFlagAni()
		{
			super();

			rect = new Rectangle(0,0,12,9);
			
			for(var i:int =0;i<4;i++){
				this.addAction("ani.dakflag",i*12,0);
				this.addSkipAction(3);
			}
		}
		
	}
}
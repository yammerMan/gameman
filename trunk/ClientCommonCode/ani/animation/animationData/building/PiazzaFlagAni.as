package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class PiazzaFlagAni extends BaseAnimationData
	{
		public function PiazzaFlagAni()
		{
			super();
			
			rect = new Rectangle(0,0,48,24);
			
			for(var i:int =0;i<4;i++){
				addAction("ani.piazzaFlag",i*48,0);
				this.addSkipAction(4);
			}
		}
	}
}
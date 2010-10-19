package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class FlameAni extends BaseAnimationData
	{
		public function FlameAni()
		{
			super();
			rect = new Rectangle(0,0,12,16);
			
			for(var i:int =0;i<8;i++){
				this.addAction("ani.flame",i*12,0);
			}
		}
	}
}
package animation.animationData
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class SmokeAni extends BaseAnimationData
	{
		public function SmokeAni()
		{
			super();
			this.rect = new Rectangle(0,0,33,41);
			for (var c:int=0; c<2; c++) {
				for (var i:int=0; i<10; i++) {
					addAction("ani.smoke", 33*i, 0);
					this.addSkipAction(1);
				}
			}
			
			for (var j:int=0; j<100; j++) {
				this.addAction(null);
			}
		}
	}
}
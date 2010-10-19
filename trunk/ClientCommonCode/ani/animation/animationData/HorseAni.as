package animation.animationData
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class HorseAni extends BaseAnimationData
	{
		public function HorseAni()
		{
			super();
			this.rect = new Rectangle(0,0,34,20);
			
			for(var i:int =0;i<6;i++){
				this.addAction("ani.horse",i*34,0);
				this.addSkipAction(2);	
			}			
		}
	}
}
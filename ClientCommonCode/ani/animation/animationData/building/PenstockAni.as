package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class PenstockAni extends BaseAnimationData
	{
		public function PenstockAni()
		{
			super();
			rect = new Rectangle(0,0,23,30);
			
			for(var i:int =0;i<4;i++){
				addAction("ani.penstock",i*23,0);
				this.addSkipAction(2);
			}
		}
	}
}
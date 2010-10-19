package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class JackAni extends BaseAnimationData
	{
		public function JackAni()
		{
			super();

			rect = new Rectangle(0,0,65,46);
			for(var i:int =0;i<8;i++){
				addAction("ani.jack",i*65,0);
				this.addSkipAction(2);
			}
			
			for(var j:int =0;j<8;j++){
				addAction("ani.jack",j*65,46);
				this.addSkipAction(2);
			}
		}
		
	}
}
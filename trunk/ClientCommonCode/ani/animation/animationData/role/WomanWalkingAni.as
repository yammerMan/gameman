package animation.animationData.role
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class WomanWalkingAni extends BaseAnimationData
	{
		public function WomanWalkingAni()
		{
			super();
			
			rect = new Rectangle(0,0,28,28);
			
			for(var w:int =0;w<4;w++){
				if(w>1){
					for (var k:int=0; k<8; k++) {
						addAction("ani.woman",k*28,w*28);
					}
				}else{
					for (var i:int=0; i<10; i++) {
						addAction("ani.woman",i*28,w*28);
					}
				}
			}
		}
	}
}
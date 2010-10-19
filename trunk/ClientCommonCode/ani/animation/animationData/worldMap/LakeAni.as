package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class LakeAni extends BaseAnimationData
	{
		public function LakeAni()
		{
			super();

			rect = new Rectangle(0,0,50,30);
			this.convertFromMc("ani","map.spray");
			
			for (var j:int=0; j<8; j++) {
				this.addAction(null);
			}
		}
	}
}
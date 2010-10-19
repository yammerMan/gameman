package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class BattleFumeAni extends BaseAnimationData
	{
		public function BattleFumeAni()
		{
			super();
			rect = new Rectangle(0,0,42,63);
			for(var i:int=0;i<8;i++){
				addAction("ani.battleFume",i*42,0);
				this.addSkipAction(1);
			}
		}
	}
}
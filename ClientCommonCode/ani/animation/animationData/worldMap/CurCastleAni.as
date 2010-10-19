package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class CurCastleAni extends BaseAnimationData
	{
		public function CurCastleAni()
		{
			super();
			rect = new Rectangle(0,0,18,21);
			var i:int;
			for (i = 0 ; i<=16 ; i+=2) {
				addAction("field.curCastle",0,0,0,i);
			}
			for ( ; i>0 ; i-=2) {
				addAction("field.curCastle",0,0,0,i);
			}
		}
	}
}
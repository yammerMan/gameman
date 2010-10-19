package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;
	
	public class KingsCastleAni extends BaseAnimationData
	{
		public function KingsCastleAni()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("field.kingCastle",0,0);
		}

	}
}
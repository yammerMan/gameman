package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class TownHannNormalAni extends BaseAnimationData
	{
		public function TownHannNormalAni()
		{
			this.rect = new Rectangle(0,0,256,196);
			addAction("building.townHallNormal");
		}
	}
}
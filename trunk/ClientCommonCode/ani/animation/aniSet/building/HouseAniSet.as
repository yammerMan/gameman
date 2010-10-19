package animation.aniSet.building
{
	import animation.AnimationManager;
	import animation.aniSet.BaseAniSetPlayer;
	
	public class HouseAniSet extends BaseAniSetPlayer
	{
		public function HouseAniSet()
		{
			this.addAni(AnimationManager.buildings.houseNormal);
			this.addAni(AnimationManager.buildingsSet.somkeAni,40,0,true);
		}
	}
}
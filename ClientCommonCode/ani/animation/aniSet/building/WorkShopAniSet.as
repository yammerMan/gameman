package animation.aniSet.building
{
	import animation.AnimationManager;
	import animation.aniSet.BaseAniSetPlayer;

	public class WorkShopAniSet extends BaseAniSetPlayer
	{
		public function WorkShopAniSet()
		{
			super();
			this.addAni(AnimationManager.buildings.workshopNormal);
			this.addAni(AnimationManager.buildingsSet.elvatorAni,61,28);
		}
	}
}
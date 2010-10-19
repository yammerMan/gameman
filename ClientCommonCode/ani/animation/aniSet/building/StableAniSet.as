package animation.aniSet.building
{
	import animation.AnimationManager;
	import animation.aniSet.BaseAniSetPlayer;

	public class StableAniSet extends BaseAniSetPlayer
	{
		public function StableAniSet()
		{
			super();
			this.addAni(AnimationManager.buildings.stableNormal);
			this.addAni(AnimationManager.buildingsSet.horseAni,47,70);
		}
	}
}
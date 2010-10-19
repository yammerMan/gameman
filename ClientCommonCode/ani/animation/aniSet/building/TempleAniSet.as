package animation.aniSet.building
{
	import animation.AnimationManager;
	import animation.aniSet.BaseAniSetPlayer;

	public class TempleAniSet extends BaseAniSetPlayer
	{
		public function TempleAniSet()
		{
			super();
			this.addAni(AnimationManager.buildings.templeNormal);
			this.addAni(AnimationManager.buildingsSet.flameAni,37,45);
			this.addAni(AnimationManager.buildingsSet.flameAni,52,52);
		}
	}
}
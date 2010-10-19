package animation.aniSet.building
{
	import animation.AnimationManager;
	import animation.aniSet.BaseAniSetPlayer;

	public class SawmillAniSet extends BaseAniSetPlayer
	{
		public function SawmillAniSet()
		{
			super();
			this.addAni(AnimationManager.buildings.sawmillNormal);
			this.addAni(AnimationManager.buildingsSet.jackAni,1,6);
		}
	}
}
package animation.aniSet.building
{
	import animation.AnimationManager;
	import animation.aniSet.BaseAniSetPlayer;

	public class DakAniSet extends BaseAniSetPlayer
	{
		public function DakAniSet()
		{
			super();
			this.addAni(AnimationManager.buildings.dakNormal);
			this.addAni(AnimationManager.buildingsSet.dakflagAni,87,38);			
		}
	}
}
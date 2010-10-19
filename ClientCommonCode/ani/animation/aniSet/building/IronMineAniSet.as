package animation.aniSet.building
{
	import animation.AnimationManager;
	import animation.aniSet.BaseAniSetPlayer;

	public class IronMineAniSet extends BaseAniSetPlayer
	{
		public function IronMineAniSet()
		{	
			super();
			this.addAni(AnimationManager.buildings.ironMineNormal);
			this.addAni(AnimationManager.buildingsSet.denseSmokeAni,19,-13);
			this.addAni(AnimationManager.buildingsSet.denseSmokeAni,28,-16);
		}
	}
}
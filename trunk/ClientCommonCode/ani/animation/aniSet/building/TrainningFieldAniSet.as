package animation.aniSet.building
{
	import animation.AnimationManager;
	import animation.aniSet.BaseAniSetPlayer;

	public class TrainningFieldAniSet extends BaseAniSetPlayer
	{
		public function TrainningFieldAniSet()
		{
			super();
			
			this.addAni(AnimationManager.buildings.trainningFeildNormal);
			this.addAni(AnimationManager.buildingsSet.piazzaFlagAni,40,25);
		}
	}
}
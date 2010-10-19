package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class TrainningFeildNormalAni extends BaseAnimationData
	{
		public function TrainningFeildNormalAni()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("building.trainningFieldNormal",0,0);
		}
	}
}
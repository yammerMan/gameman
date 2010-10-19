package animation.animationData.worldMap
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;
	
	public class TrainingRoomAni extends BaseAnimationData
	{
		public function TrainingRoomAni()
		{
			super();
			rect = new Rectangle(0,0,128,96);
			addAction("field.trainingRoom",0,0);
		}

	}
}
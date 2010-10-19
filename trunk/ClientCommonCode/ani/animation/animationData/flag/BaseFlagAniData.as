package animation.animationData.flag
{
	import animation.BaseAnimationData;
	
	import flash.geom.Rectangle;

	public class BaseFlagAniData extends BaseAnimationData
	{
		public function BaseFlagAniData(index:int) {
			super();
			this.rect = new Rectangle(0,0,34,24);
			
			for (var i:int=0; i<6; i++) {
				addAction("field.flag", index * 34, i *24);
				addSkipAction(1);
			}
		}
	}
}
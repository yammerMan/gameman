package framework.util
{
	import mx.collections.ArrayCollection;
	
	public class CopyAryUtil
	{
		public static function copyArray(sourceArr:ArrayCollection , targetArr:ArrayCollection):void {
			if (sourceArr==null || targetArr==null) {
				return ;
			}

			targetArr.removeAll();
			for (var i:int=0; i<sourceArr.length; i++) {
				targetArr.addItem(sourceArr[i]);
			}
		}
	}
}
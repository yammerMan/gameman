package animation
{
	import flash.display.BitmapData;
	
	public class FrameObj
	{
		public var frameBitmap:BitmapData;
		public var mx:int = 0;
		public var my:int = 0;
		public function FrameObj(bit:BitmapData,x:int,y:int)
		{
			if (bit==null) {
				throw new Error("动画数据错误");
			}
			frameBitmap = bit;
			mx = x;
			my = y;
		}

	}
}
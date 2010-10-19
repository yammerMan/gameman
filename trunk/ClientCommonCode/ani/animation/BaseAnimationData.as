package animation
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.resources.ResourceManager;
	
	public class BaseAnimationData
	{
		public var curFrame:int = 0;
		public var totalFrame:int = 0;
		public var rect:Rectangle;
		public var resourceArray:Array = new Array();
		
		protected function addAction(name:String,startPointX:int = 0,startPointY:int = 0,x:int=0,y:int=0):void{
			if (name!=null) {
				var tempObj:FrameObj = new FrameObj(AniDataManager.instance.getAniBitmapData(name,rect,new Point(startPointX,startPointY)),x,y);
				resourceArray.push(tempObj);
			} else {
				this.resourceArray.push(null);
			}
			totalFrame = resourceArray.length;
		}
		
		public function addBitMapDataAction(bitmapData:BitmapData, x:int=0, y:int=0):void{
			var tempObj:FrameObj = new FrameObj(bitmapData, x, y);
			resourceArray.push(tempObj);
			totalFrame = resourceArray.length;
		}

		public function addSkipAction(num:int):void{
			for(var i:int=0;i<num;i++){
				resourceArray.push(resourceArray[resourceArray.length-1]);
			}
			totalFrame = resourceArray.length;
		}
		
		public function nextFrame(num:int):FrameObj{
			var tempObj:FrameObj = resourceArray[num % totalFrame] as FrameObj;
			return tempObj;
		}
		
		public function convertFromMc(bundleName:String, resourceName:String, skip:int=0, x:int=0, y:int=0):void {
			var mcClazz:Class = ResourceManager.getInstance().getClass(bundleName,resourceName);
			
			if (mcClazz == null) {
				throw new Error("无法找到Mc: bundleName=" + bundleName + " resourceName=" + resourceName);
			}
			
			var matrix:Matrix = new Matrix();
			var mc:MovieClip = new mcClazz;
			for (var i:int=0; i<mc.totalFrames; i++) {
				var bd:BitmapData = new BitmapData(this.rect.width, this.rect.height,true,0);
				mc.gotoAndStop(i);
				bd.draw(mc, matrix,null,null,rect,true);
				var tempObj:FrameObj = new FrameObj(bd,x,y);
				this.resourceArray.push(tempObj);
				
				this.addSkipAction(skip);
			}
			totalFrame = resourceArray.length;
		}
	}
}
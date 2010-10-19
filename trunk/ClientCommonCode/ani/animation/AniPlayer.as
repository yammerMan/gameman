package animation
{
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class AniPlayer implements IAniPlayer
	{
		private var animationData:BaseAnimationData;
		public var sceneX:int;
		public var sceneY:int;
		public var curFrame:int = 0;
		
		private var log:ILogger = Log.getLogger("animation.PlayerAnimation");

		public function AniPlayer(aniData:BaseAnimationData=null,x:int=0, y:int=0, startFrame:int=0,endFrame:int =0)
		{
			animationData = aniData;
			sceneX = x;
			sceneY = y;
			curFrame = startFrame;
			
			if (this.curFrame<0 || this.curFrame> this.animationData.totalFrame) {
				this.curFrame = Math.random() * this.animationData.totalFrame;
			}
		}
		
		public function setAniData(aniData:BaseAnimationData):void {
			this.animationData = aniData;
			this.curFrame = 0;
		}
		
		public function reset():void {
			this.curFrame = 0;
		}
		
		public function gotoAndStop( frame:int, sceneContain:BitmapData, screenX:int=0, screenY:int=0,  
			alphaBitmapData:BitmapData = null, alphaPoint:Point = null, mergeAlpha:Boolean = true ):void{
			var frameObj:FrameObj = this.animationData.nextFrame(frame);
			if(frameObj==null || frameObj.frameBitmap == null){
				return;
			}
			var destPoint:Point = new Point(this.sceneX+frameObj.mx+ screenX , this.sceneY+frameObj.my + screenY ); 
			sceneContain.copyPixels(
				frameObj.frameBitmap, 
				animationData.rect,
				destPoint ,
				alphaBitmapData,
				alphaPoint,
				mergeAlpha);
		}
		
		public function gotoAndPlay(sceneContain:BitmapData, screenX:int=0, screenY:int=0, 
			alphaBitmapData:BitmapData = null, alphaPoint:Point = null, mergeAlpha:Boolean = true ):void{
			if(animationData == null){
				log.debug("the animationData is null");
				return;
			}
			if(curFrame >= animationData.totalFrame){
				curFrame = 0;
			}
			
			var frameObj:FrameObj = this.animationData.nextFrame(this.curFrame);
			if(frameObj!=null && frameObj.frameBitmap != null){
				var destPoint:Point = new Point(this.sceneX+frameObj.mx+ screenX , this.sceneY+frameObj.my + screenY); 
				sceneContain.copyPixels(
					frameObj.frameBitmap, 
					animationData.rect,
					destPoint ,
					alphaBitmapData,
					alphaPoint,
					mergeAlpha);
			}
			
			this.curFrame ++ ;
		}
	}
}
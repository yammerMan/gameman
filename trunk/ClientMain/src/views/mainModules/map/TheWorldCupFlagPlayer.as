package views.mainModules.map
{
	import animation.AniPlayer;
	import animation.AnimationManager;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class TheWorldCupFlagPlayer extends AniPlayer
	{
		private static var FLAG_TEXT_Y_ADD:int = 0;
		private static var FLAG_TEXT_X_ADD:int = 3; 
		
		public static const FLAG_TEXT_X:int = 30;
		public static const FLAG_TEXT_Y:int = -4;

		private static const TEXT_HEIGHT:int = 20;
		private static const TEXT_WIDTH:int = 27;
		
		private static const sourceRect:Rectangle = new Rectangle(34,15,TEXT_WIDTH,TEXT_HEIGHT);
		
		private var bitmapData:BitmapData;
		
		
		public function TheWorldCupFlagPlayer(type:int, x:int=FLAG_TEXT_X, y:int=FLAG_TEXT_Y, )
		{
			super(AnimationManager.flagAni.getTheWorldCupFlag(type), x, y, startFrame);
		}
		
		
		override public function gotoAndPlay(sceneContain:BitmapData, screenX:int=34, screenY:int=15, alphaBitmapData:BitmapData=null, alphaPoint:Point=null, mergeAlpha:Boolean=true):void {
			super.gotoAndPlay(sceneContain,screenX,screenY,alphaBitmapData,alphaPoint,mergeAlpha);
			
		}
		
		override public function gotoAndStop( frame:int, sceneContain:BitmapData, screenX:int=0, screenY:int=0,  
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
	}
}
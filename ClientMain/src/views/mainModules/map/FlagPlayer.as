package views.mainModules.map
{
	import animation.AniPlayer;
	import animation.AnimationManager;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import roma.util.FiltersUtil;
	
	import views.mainModules.map.diamond2.DiamondMapTile2;

	public class FlagPlayer extends AniPlayer
	{
		private static var FLAG_TEXT_Y_ADD:int = 0;
		private static var FLAG_TEXT_X_ADD:int = 3; 
		
		public static const FLAG_TEXT_X:int = 30;
		public static const FLAG_TEXT_Y:int = -4;

		private static const TEXT_HEIGHT:int = 20;
		private static const TEXT_WIDTH:int = 27;
		
		private static const sourceRect:Rectangle = new Rectangle(0,0,TEXT_WIDTH,TEXT_HEIGHT);
		
		public var flagTextBitmapData:BitmapData ;
		
		public function FlagPlayer(relation:int, flag:String=null, x:int=FLAG_TEXT_X, y:int=FLAG_TEXT_Y, startFrame:int=-1)
		{
			super(AnimationManager.flagAni.getFlagAniByRelation(relation), x, y, startFrame);
			if (flag!=null && flag.length>0) {
				this.flagTextBitmapData = getFlagTextBitmapData(flag);
			}
		}
		
		public static function getFlagTextBitmapData(flag:String):BitmapData {

			var hasGBK:Boolean = false;
			for (var i:int=0; i< flag.length; i++) {
				if (flag.charCodeAt(i)>19968) {
					hasGBK = true;
					break;
				}					
			}	

			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			if(hasGBK) {
				format.size = 12;
				format.font = "MingLiU";
			} else {
				format.size = 10;
				format.font = "Tahoma";
			}
			
			var flagText:TextField = new TextField() ;
			flagText.filters = [FiltersUtil.glowFilter];
			flagText.textColor = 0xffffff;
			flagText.height = TEXT_HEIGHT;
			flagText.width = TEXT_WIDTH;
			flagText.defaultTextFormat = format;


			if (hasGBK) {
				flagText.text = flag.substr(0,1);
			} else {
				flagText.text = flag.substr(0,3).toUpperCase();
			}
			
			var flagTextBitmapData:BitmapData;
			flagTextBitmapData = new BitmapData(TEXT_WIDTH,TEXT_WIDTH,true,0);
			flagTextBitmapData.draw(flagText);
			return flagTextBitmapData;
		}
		
		override public function gotoAndPlay(sceneContain:BitmapData, screenX:int=0, screenY:int=0, alphaBitmapData:BitmapData=null, alphaPoint:Point=null, mergeAlpha:Boolean=true):void {
			super.gotoAndPlay(sceneContain,screenX,screenY,alphaBitmapData,alphaPoint,mergeAlpha);
			
			if (this.flagTextBitmapData!=null) {
				var px:int = this.sceneX + screenX + FLAG_TEXT_X_ADD;
				var py:int = this.sceneY + screenY + FLAG_TEXT_Y_ADD;
				sceneContain.copyPixels(this.flagTextBitmapData , sourceRect, new Point(px,py));
			}
		}
	}
}
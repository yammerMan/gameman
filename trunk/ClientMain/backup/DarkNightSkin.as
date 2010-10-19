package skins
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.core.BitmapAsset;
	import mx.core.UIComponent;
	
	public class DarkNightSkin extends MyRectangularBorder
	{
		public function DarkNightSkin() 
		{
			super();
		}
		
	    private  var g:Graphics = graphics;

		private var tile:BitmapData;//背景图
		
 		[Embed("assets/images/EmbedImages/uiBackGround/skyBG.jpg")]
		public static const imgCls:Class;//设置之后不接收css定义的背景设置

        override protected function updateDisplayList(w:Number, h:Number):void {
	        if (!parent)
	            return;
			super.updateDisplayList(w, h);
			
			if( imgCls != null ) {
			var background:BitmapAsset = BitmapAsset(new imgCls());
			tile= background.bitmapData;
	  
			
			  
			graphics.clear();
			var tile1:BitmapData = new BitmapData(background.width,background.height*.5);  
            tile1.copyPixels(tile,new Rectangle(0, background.height*.5,background.width, background.height),new Point(0,0));  
            graphics.beginBitmapFill(tile1);
            graphics.drawRect(0, 0, w, h);
            graphics.endFill();
 
			}
        }
	}
}
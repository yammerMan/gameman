package skins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	public class DupBorderSkin extends RecBorder
	{
		private var backgroundColor:uint;
        private var backgroundAlpha:Number;
        private var outSidebordorColor:uint;
        private var insideBordorColor:uint=0xaf956f;
        private  var bit:Graphics = graphics;
		public function DupBorderSkin()
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
	        if (!parent)
	            return;

			super.updateDisplayList(unscaledWidth,unscaledHeight);
            bit.clear();
            backgroundColor = getStyle("backgroundColor");
            backgroundAlpha = getStyle("backgroundAlpha");
            
        	var outSidebordorColor:uint = getStyle("borderColor");
        	var cornerRadius:Number = getStyle("cornerRadius");
        	if (isNaN(cornerRadius)) {
        		cornerRadius = 0;
        	}
            if(unscaledWidth != 0){
				  var matrix:Matrix = new Matrix();
				 
				  matrix.createGradientBox(20, 20, 0, 0, 0);
				  matrix.rotate(Math.PI / 2);
				bit.lineStyle(1,outSidebordorColor,1);
				bit.beginFill(0xfdea95,backgroundAlpha);
				bit.drawRoundRect(0,0,unscaledWidth,unscaledHeight,cornerRadius,cornerRadius);
				
				bit.lineStyle(1,insideBordorColor,1);
				bit.beginFill(backgroundColor,backgroundAlpha);
				bit.drawRoundRectComplex(3,3,unscaledWidth-6,unscaledHeight-6,cornerRadius-2,cornerRadius-2,cornerRadius-2,cornerRadius-2);      
				bit.endFill();

            }
        }
	}		
}
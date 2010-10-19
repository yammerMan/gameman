package skins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	public class ShadeSkin extends RecBorder
	{
		private var _backgroundColor:uint;
        private var _backgroundAlpha:Number;
        private  var bit:Graphics = graphics;
		public function ShadeSkin()
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
	        if (!parent)
	            return;

			super.updateDisplayList(unscaledWidth,unscaledHeight);
            bit.clear();
        	var cornerRadius:Number = getStyle("cornerRadius");
        	if (isNaN(cornerRadius)) {
        		cornerRadius = 0;
        	}
            if(unscaledWidth != 0){
			 	var colors1Arr:Array = [0xfffceb, 0xfeeeb0];
			  	var alphasArr:Array = [1, 1];
			  	var ratiosArr:Array = [0x00, 0xcc];
			  	var matrix:Matrix = new Matrix();
			  	
			 
				matrix.createGradientBox(unscaledWidth, unscaledHeight, 0, 0, 0);
				matrix.rotate(Math.PI/2);
				
				bit.beginGradientFill(GradientType.LINEAR, colors1Arr, alphasArr, ratiosArr, matrix, SpreadMethod.PAD);  

				bit.drawRoundRectComplex(0,0,unscaledWidth,unscaledHeight,0,0,0,0);

				
            }
        }
	}		
}
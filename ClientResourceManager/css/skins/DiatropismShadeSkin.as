package skins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	public class DiatropismShadeSkin extends RecBorder
	{
		private var backgroundColor:uint;
        private var backgroundAlpha:Number;
        private  var bit:Graphics = graphics;
		public function DiatropismShadeSkin()
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
			 	var colors1:Array = [0x000000, 0x000000];
			  	var alphas:Array = [0.8, 0.0];
			  	var ratios:Array = [0x00, 0xFF];
			  	var matrix:Matrix = new Matrix();
			 
				matrix.createGradientBox(unscaledWidth, unscaledHeight, 0, 0, 0);
				
				bit.beginGradientFill(GradientType.LINEAR, colors1, alphas, ratios, matrix, SpreadMethod.PAD);  

				bit.drawRoundRectComplex(0,0,unscaledWidth,unscaledHeight,0,0,0,0);

				
            }
        }
	}		
}
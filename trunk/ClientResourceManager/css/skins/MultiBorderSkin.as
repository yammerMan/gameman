package skins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	public class MultiBorderSkin extends RecBorder
	{
		private var backgroundColor:uint;
        private var backgroundAlpha:Number;
        private  var bit:Graphics = graphics;
		public function MultiBorderSkin()
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
	        if (!parent)
	            return;

			super.updateDisplayList(unscaledWidth,unscaledHeight);
            bit.clear();
            backgroundColor = getStyle("backgroundColor");
            backgroundAlpha = getStyle("backgroundAlpha");
            
        	var borderColor:uint = getStyle("borderColor");
        	var cornerRadius:Number = getStyle("cornerRadius");
        	if (isNaN(cornerRadius)) {
        		cornerRadius = 0;
        	}
            if(unscaledWidth != 0){
            	  var fillTypeId:String = GradientType.LINEAR;
				  var colorArr:Array = [0xfdea95, 0xefbd65];
				  var alphaArr:Array = [1, 1];
				  var ratioArr:Array = [0x00, 0xFF];
				  var matrix:Matrix = new Matrix();
				 
				  matrix.createGradientBox(20, 20, 0, 0, 0);
				  matrix.rotate(Math.PI / 2);
				  var spMethod:String = SpreadMethod.PAD;
				  bit.beginGradientFill(fillTypeId, colorArr, alphaArr, ratioArr, matrix, spMethod);  

				  bit.lineStyle(1,borderColor,1);
				  bit.drawRoundRectComplex(0,0,unscaledWidth,unscaledHeight,0,0,0,0);
				
				  var colorArr2:Array = [0xf9f0bd, 0xd5ba78];
				  bit.beginGradientFill(fillTypeId, colorArr2, alphaArr, ratioArr, matrix, spMethod);  

				  bit.lineStyle(1,0xa6885e,1);
				  bit.drawRoundRectComplex(2,2,unscaledWidth-4,unscaledHeight-4,0,0,0,0);
            
            }
        }
	}		
}
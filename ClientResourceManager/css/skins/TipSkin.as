package skins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	public class TipSkin extends RecBorder
	{
		private var firstBorderColor:uint=0xac9688;
        private var secondBorderColor:uint=0xfdea95;
        private var thirdBorderColor:uint=0x420000;
        private var fourBorderColor:uint=0x816050;
        private var cornerRadius:Number=6;
        private var bit:Graphics = graphics;
        private var fillType:String = GradientType.LINEAR;
		private var colors:Array = [0xFFffff, 0xfdeea9];
		private var alphas:Array = [0.9, 0.9];
		private var ratios:Array = [0x0, 0xff];
		private var matr:Matrix = new Matrix();
		private var spreadMethod:String = SpreadMethod.PAD;
		public function TipSkin()
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
	        if (!parent)
	            return;

			super.updateDisplayList(unscaledWidth,unscaledHeight);
            bit.clear();
        	if (isNaN(cornerRadius)) {
        		cornerRadius = 0;
        	}
            if(unscaledWidth != 0){
				bit.lineStyle(1,firstBorderColor,1);
				bit.drawRoundRect(2,2,unscaledWidth-5,unscaledHeight-4,cornerRadius,cornerRadius);
				
				bit.lineStyle(1,secondBorderColor,1);
				bit.drawRoundRect(1,1,unscaledWidth-3,unscaledHeight-2,cornerRadius,cornerRadius);
				
				bit.lineStyle(1,thirdBorderColor,.3);
				bit.drawRoundRect(0,0,unscaledWidth-1,unscaledHeight,cornerRadius,cornerRadius);
				
			    matr.createGradientBox(unscaledWidth,unscaledHeight, 0, 0, 0);
			    matr.rotate(Math.PI/2);

			    bit.lineStyle(1,secondBorderColor,1);
			    bit.moveTo(4,3);
			    bit.lineTo(unscaledWidth-4,3);
			    
			    bit.lineStyle(1,secondBorderColor,1);
			    bit.moveTo(4,unscaledHeight-3);
			    bit.lineTo(unscaledWidth-4,unscaledHeight-3);
			    
			    
			    bit.lineStyle(1,thirdBorderColor,0);
			    bit.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);  
			    bit.drawRect(3,4,unscaledWidth-6,unscaledHeight-8);


			    
			    bit.lineStyle(1,fourBorderColor,1);
			    bit.moveTo(3,4);
			    bit.lineTo(unscaledWidth-3,4);
			    
			    bit.lineStyle(1,fourBorderColor,1);
			    bit.moveTo(3,unscaledHeight-4);
			    bit.lineTo(unscaledWidth-3,unscaledHeight-4);

				
				bit.endFill();
            }
        }
	}		
}
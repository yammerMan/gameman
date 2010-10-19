package skins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	public class MenuBorderSkin extends RecBorder
	{
		private var firstBorderColor:uint=0xac9688;
        private var secondBorderColor:uint=0xfdea95;
        private var thirdBorderColor:uint=0x420000;
        private var fourBorderColor:uint=0x816050;
        private var cornerRadius:Number=6;
        private var bit:Graphics = graphics;
        private var fillType:String = GradientType.LINEAR;
		private var colors:Array = [0xFFffff, 0xfdeea9];
		private var alphas:Array = [1, 1];
		private var ratios:Array = [0x00, 0xFF];
		private var matr:Matrix = new Matrix();
		private var spreadMethod:String = SpreadMethod.PAD;
		public function MenuBorderSkin()
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
	        if (!parent)
	            return;

			super.updateDisplayList(unscaledWidth,unscaledHeight);
            graphics.clear();
        	if (isNaN(cornerRadius)) {
        		cornerRadius = 0;
        	}
            if(unscaledWidth != 0){
				graphics.lineStyle(1,firstBorderColor,1);
				graphics.drawRoundRect(-1,-2,unscaledWidth+1,unscaledHeight+4,cornerRadius,cornerRadius);
				
				graphics.lineStyle(1,secondBorderColor,1);
				graphics.drawRoundRect(-2,-3,unscaledWidth+3,unscaledHeight+6,cornerRadius,cornerRadius);
				
				graphics.lineStyle(1,thirdBorderColor,.3);
				graphics.drawRoundRect(-3,-4,unscaledWidth+5,unscaledHeight+8,cornerRadius,cornerRadius);
				
			    matr.createGradientBox(80,100, 0, 0, 0);
			    matr.rotate(Math.PI/2);

			    graphics.lineStyle(1,secondBorderColor,1);
			    graphics.moveTo(1,-1);
			    graphics.lineTo(unscaledWidth-1,-1);
			    
			    graphics.lineStyle(1,secondBorderColor,1);
			    graphics.moveTo(1,unscaledHeight+1);
			    graphics.lineTo(unscaledWidth-1,unscaledHeight+1);
			    
			    graphics.lineStyle(1,fourBorderColor,1);
			    graphics.moveTo(0,0);
			    graphics.lineTo(unscaledWidth,0);
			    
			    graphics.lineStyle(1,fourBorderColor,1);
			    graphics.moveTo(0,unscaledHeight);
			    graphics.lineTo(unscaledWidth,unscaledHeight);
			    
			    graphics.lineStyle(1,thirdBorderColor,0);
			    graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);  
			    graphics.drawRect(0,0,unscaledWidth,unscaledHeight);


				
				graphics.endFill();
            }
        }
	}		
}
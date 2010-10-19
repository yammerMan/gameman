package skins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	public class OnlyBorderSkin extends RecBorder
	{
		private var firstBorderColor:uint=0x000000;
        private var secondBorderColor:uint=0xfde48a;
        private var thirdBorderColor:uint=0x563e1c;
        private var cornerRadius:Number=0;
        private  var bit:Graphics = graphics;
		public function OnlyBorderSkin()
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
				bit.drawRoundRect(0,0,unscaledWidth,unscaledHeight,cornerRadius,cornerRadius);
				
				bit.lineStyle(1,secondBorderColor,1);
				bit.drawRoundRect(1,1,unscaledWidth-2,unscaledHeight-2,cornerRadius,cornerRadius);
				
				bit.lineStyle(1,thirdBorderColor,1);
				bit.drawRoundRect(2,2,unscaledWidth-4,unscaledHeight-4,cornerRadius,cornerRadius);
				bit.endFill();
            }
        }
	}		
}
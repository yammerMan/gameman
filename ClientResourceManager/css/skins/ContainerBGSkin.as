package skins
{
	import flash.display.Graphics;

	public class ContainerBGSkin extends RecBorder
	{
		public function ContainerBGSkin()
		{
			super();
		}
		private var backgroundColor:uint;
        private var backgroundAlpha:Number;
        private  var bit:Graphics = graphics;

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
	        if (!parent)
	            return;

			super.updateDisplayList(unscaledWidth,unscaledHeight);
            bit.clear();
            backgroundColor = getStyle("backgroundColor");
            backgroundAlpha = getStyle("backgroundAlpha");
            
            //避免第一次觸發updateDisplayList的時候,unscaledWidth是0
//        	var borderColor:uint = getStyle("borderColor");
            if(unscaledWidth != 0){
            	bit.lineTo(0,0);
				bit.beginFill(backgroundColor,backgroundAlpha);
//				bit.lineStyle(1,borderColor);
				bit.drawRoundRectComplex(0,0,unscaledWidth,unscaledHeight,4,4,4,4); 
				bit.endFill();  		
            }
        }
	}		
}
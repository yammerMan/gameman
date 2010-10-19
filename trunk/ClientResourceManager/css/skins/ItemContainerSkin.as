package skins
{
	import flash.display.Graphics;
	
	public class ItemContainerSkin extends RecBorder
	{
		private var bit:Graphics = graphics;
		private var squareWidth:int=22;
		private var squareHeight:int=55;
		private var colorD:uint=0xf8e9c8;
		private var _borderColor:uint=0x9b8764;
		
		public function ItemContainerSkin()
		{
			super();
		}
 		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
	        if (!parent)
	            return;

			super.updateDisplayList(unscaledWidth,unscaledHeight);
            bit.clear();
            if(unscaledHeight%squareHeight!=0){
            	for(var i:int=0;i<Math.ceil(unscaledHeight/squareHeight);i++){
            		if(i==Math.ceil(unscaledHeight/squareHeight)-1){
	            		bit.lineStyle(1,_borderColor);
	            		bit.beginFill(colorD,1);	
	            		bit.drawRoundRectComplex(0,i*squareHeight,unscaledWidth,unscaledHeight-i*squareHeight-2,0,0,0,0);
            		}
            		bit.lineStyle(1,_borderColor);
            		bit.beginFill(colorD,1);	
            		bit.drawRoundRectComplex(0,i*squareHeight,unscaledWidth,squareHeight-2,0,0,0,0);
            	}
            	
            }else{
            	for(var j:int=0;j<unscaledHeight/squareHeight;j++){
            		bit.lineStyle(1,_borderColor);
            		bit.beginFill(colorD,1);	
            		bit.drawRoundRectComplex(0,j*squareHeight,unscaledWidth,squareHeight-2,0,0,0,0);
            	}
            }
           
		}
	}		
}
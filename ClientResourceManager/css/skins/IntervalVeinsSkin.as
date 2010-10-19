package skins
{
	import flash.display.Graphics;
	
	public class IntervalVeinsSkin extends RecBorder
	{
		private var bit:Graphics = graphics;
		private var squareWidth:int=22;
		private var squareHeight:int=22;
		private var colorS:uint=0xfcf7e5;
		private var colorD:uint=0xf5e7bd;
		public function IntervalVeinsSkin()
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
            			if(i%2==0){
	            			bit.beginFill(colorS,1);
	            		}else{
	            			bit.beginFill(colorD,1);	
	            		}
	            		bit.drawRoundRectComplex(0,i*squareHeight,unscaledWidth,unscaledHeight-i*squareHeight,0,0,0,0);
            		}
            		if(i%2==0){
            			bit.beginFill(colorS,1);
            		}else{
            			bit.beginFill(colorD,1);	
            		}
            		bit.drawRoundRectComplex(0,i*squareHeight,unscaledWidth,squareHeight,0,0,0,0);
            	}
            	
            }else{
            	for(var j:int=0;j<unscaledHeight/squareHeight;j++){
            		if(j%2==0){
            			bit.beginFill(colorS,1);
            		}else{
            			bit.beginFill(colorD,1);	
            		}
            		bit.drawRoundRectComplex(0,j*squareHeight,unscaledWidth,squareHeight,0,0,0,0);
            	}
            }
           
		}
	}		
}
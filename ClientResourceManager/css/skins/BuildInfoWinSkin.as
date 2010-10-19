package skins
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.core.BitmapAsset;
	import mx.core.UIComponent;

	public class BuildInfoWinSkin extends RecBorder
	{
		public function BuildInfoWinSkin()
		{
			super();
		}
		private var backgroundColor:uint;
        private var backgroundAlpha:Number;
        private  var bit:Graphics = graphics;

		private var tile:BitmapData;
		

		private var borderWidth:int=100;//边框宽
		private var borderHeight:int=100;//边框高
        
		private var imgCls:Class;//设置之后不接收css定义的背景设置
        
        

    	
        override protected function updateDisplayList(w:Number, h:Number):void {
	        if (!parent)
	            return;
			super.updateDisplayList(w, h);
			
			if( imgCls == null ) {
	            	var backgroundImage:Object = UIComponent( this.parent ).getStyle( "backgroundImage" );
	            	if( backgroundImage != null && backgroundImage != "" ) {
						imgCls = Class( backgroundImage );
						(this.parent as UIComponent).setStyle( "backgroundImage", "" );
					}
				}
			if( imgCls != null ) {
			  var background:BitmapAsset = BitmapAsset(new imgCls());
			  tile= background.bitmapData;
	  
			  //上左
			  var tile0:BitmapData = new BitmapData(borderWidth,borderHeight);  
			  
			  //上中
			  var tile1:BitmapData = new BitmapData(background.width-borderWidth*2,borderHeight);  
			  
			  //中间区域
			  var tile2:BitmapData = new BitmapData(background.width-borderWidth*2,background.height-borderHeight*2); 

			  
			  //上右
			   var tile3:BitmapData = new BitmapData(borderWidth,borderHeight);
			  
			  //中左
			  var tile4:BitmapData = new BitmapData(borderWidth,background.height-borderHeight*2);
			
			  
			  //中右
			  var tile5:BitmapData = new BitmapData(borderWidth,background.height-borderHeight*2);

			  
			  //下左
			   var tile6:BitmapData = new BitmapData(borderWidth,borderHeight);

			  
			  //下中
			   var tile7:BitmapData = new BitmapData(background.width-borderWidth*2,borderHeight); 

			 
			  //下右
			  var tile8:BitmapData = new BitmapData(borderWidth,borderHeight);


			  
			  bit.clear();

				//上左
				tile0.copyPixels(tile,new Rectangle(0, 0,borderWidth, borderHeight),new Point(0,0));
				bit.beginBitmapFill(tile0);
                bit.drawRect(0, 0,borderWidth, borderHeight);
                
                //上中
                tile1.copyPixels(tile,new Rectangle(borderWidth, 0,background.width-borderWidth*2, borderHeight),new Point(0,0));  
                bit.beginBitmapFill(tile1);
                bit.drawRect(borderWidth, 0, w-borderWidth*2, borderHeight);
                

   
                //中间区域
                tile2.copyPixels(tile,new Rectangle(borderWidth, borderHeight,background.width-borderWidth*2, background.height-borderHeight*2),new Point(0,0));  
                bit.beginBitmapFill(tile2);
                bit.drawRect(borderWidth, borderHeight, w-borderWidth*2, h-borderHeight*2);
                
                //上右
                tile3.copyPixels(tile,new Rectangle(background.width-borderWidth, 0,borderWidth, borderHeight),new Point(0,0));
				bit.beginBitmapFill(tile3);
                bit.drawRect(w-borderWidth, 0, borderWidth, borderHeight);
                
                //中左
                tile4.copyPixels(tile,new Rectangle(0, borderHeight,borderWidth, background.height-borderHeight*2),new Point(0,0)); 
                bit.beginBitmapFill(tile4);
                bit.drawRect(0, borderHeight, borderWidth, h-borderHeight*2);
                
                 //中右
                tile5.copyPixels(tile,new Rectangle(background.width-borderWidth, borderHeight,borderWidth, background.height-borderHeight*2),new Point(0,0));
				bit.beginBitmapFill(tile5);
                bit.drawRect(w-borderWidth, borderHeight, borderWidth, h-borderHeight*2);

                //下左
				tile6.copyPixels(tile,new Rectangle(0, background.height-borderHeight, borderWidth, background.height),new Point(0,0));
				bit.beginBitmapFill(tile6);
                bit.drawRect(0, h-borderHeight, borderWidth, borderHeight);
                
                //下中
				tile7.copyPixels(tile,new Rectangle(borderWidth,background.height-borderHeight,background.width-borderWidth*2, borderHeight),new Point(0,0));
				bit.beginBitmapFill(tile7);
                bit.drawRect(borderWidth, h-borderHeight, w-borderWidth*2, borderHeight);
                
                //下右
                tile8.copyPixels(tile,new Rectangle(background.width-borderWidth, background.height-borderHeight, borderWidth, borderHeight),new Point(0,0));
				bit.beginBitmapFill(tile8);
                bit.drawRect(w-borderWidth, h-borderHeight, borderWidth, borderHeight);
                bit.endFill();
                
			}
        }
	}		
}
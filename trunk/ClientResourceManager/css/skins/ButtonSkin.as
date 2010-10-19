package skins
{

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	import mx.core.BitmapAsset;
	import mx.core.UIComponent;
	import mx.skins.Border;
	

	
	
	
	

	public class ButtonSkin extends Border
	{
		private var tile:BitmapData;
        
        private var imgCls:Class;
        
        private var btnW:Number;
        
        private var butH:Number;
					
        
		public function ButtonSkin()
		{
			super();
		}
		
		
		/**
	     *  @private
	     */    
	    override public function get measuredWidth():Number
	    {
	        return this.btnW;
	    }
	    
	    
	    /**
	     *  @private
	     */        
	    override public function get measuredHeight():Number
	    {
	        return this.butH;
	    }
		
		
		/**
		 * 
		 * @param w
		 * @param h
		 * 
		 */		
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			var g:Graphics = graphics;
			
           
//			imgCls=ResourceImg.buttonNormal;
//			var background:BitmapAsset = BitmapAsset(new imgCls());
			
			if( imgCls == null ) {
            	var backgroundImage:Object = UIComponent( this.parent ).getStyle( "backgroundImage" );
            	if( backgroundImage != null && backgroundImage != "" ) {
					imgCls = Class( backgroundImage );
//					(this.parent as UIComponent).setStyle( "backgroundImage", "" );
				}
			}
			var background:BitmapAsset = BitmapAsset(new imgCls());
			
			
            tile = background.bitmapData;
            var btnW:Number=background.width>w?w:background.width;
            var btnH:Number=background.height>h?h:background.height;
            
            var transform: Matrix = new Matrix();
//            var yScale:Number=background.height/4>h?background.height/4/h:h/(background.height/4);
//            var xScale:Number=background.width>w?background.width/w:w/background.width;
            var yScale:Number=h/(background.height/4);
            var xScale:Number=w/background.width;
            transform.scale(xScale,yScale);
			
			switch(name)
			{
				case "upSkin":
				{
					transform.ty=0;

					break;
				}
				case "OverSkin":
				case "overSkin":
				{
					transform.ty=yScale*background.height*1/4;

					break;
				}
				case "DownSkin":
				case "downSkin":
				{
					transform.ty=yScale*background.height*2/4;

					break;
				}
				case "disabledSkin":
				{
					transform.ty=yScale*background.height*3/4;

					break;
				}
				default:

			}
			
            g.clear();
            
            g.beginBitmapFill(tile, transform, true,true);
            g.drawRect(0, 0, w, h);
            g.endFill();
		} 


	}
}
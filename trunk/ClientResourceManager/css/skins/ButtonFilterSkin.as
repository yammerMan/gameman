package skins
{

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	
	import mx.core.BitmapAsset;
	import mx.core.UIComponent;
	import mx.skins.Border;
	

	

	
	
	
	

	public class ButtonFilterSkin extends Border
	{
		private var tile:BitmapData;
        
        private var imgCls:Class;
        
        private var btnW:Number;
        
        private var butH:Number;
        
        private var backgroundImage:Object;
        
        private  var brightnessColorMatrixFilter:ColorMatrixFilter=new ColorMatrixFilter([1.5,0,0,0,
 																							   0,0,1.5,0,
 																							   0,0,0,0,
 																							   1.5,0,0,0,
 																							   0,0,1,0,
 																							   0,0,1,0]); 
					
        
		public function ButtonFilterSkin()
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
			
			if( imgCls == null ) {
				if(this.parent==null) return;
            	backgroundImage = UIComponent( this.parent ).getStyle( "selectedDisabledIcon" );
            	if( backgroundImage != null && backgroundImage != "" ) {
					imgCls = Class( backgroundImage );
//					(this.parent as UIComponent).setStyle( "selectedDisabledIcon", null );
				}
			}
			var background:BitmapAsset = BitmapAsset(new imgCls());
			
			
            tile = background.bitmapData;
            var btnW:Number=background.width;
            var btnH:Number=background.height;
            
            var transform: Matrix = new Matrix();	
			switch(name)
			{
				case "upSkin":
				{
					
					this.filters=null;
					break;
				}
				case "OverSkin":
				case "overSkin":
				{
					
					this.filters=[brightnessColorMatrixFilter];
					break;
				}
				case "DownSkin":
				case "downSkin":
				{
					
					this.filters=null;
					break;
				}
				case "disabledSkin":
				{
					this.filters=null;
					this.alpha=0.5;
					break;
				}
				default:
				this.filters=null;

			}
			
            g.clear();
            
            g.beginBitmapFill(tile, transform, true,true);
            g.drawRect(0, 0, btnW, btnH);
            g.endFill();
		} 


	}
}
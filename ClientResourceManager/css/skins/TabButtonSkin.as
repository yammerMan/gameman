package skins
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	import mx.skins.Border;
	

	
	
	
	

	public class TabButtonSkin extends Border
	{
		private var tile:BitmapData;
        
        private var imgCls:Class;
        
        private var buttonWidth:int;
        private var buttoneHeight:int;
					
        
		public function TabButtonSkin()
		{
			super();
		}
		
		
		/**
	     *  @private
	     */    
	    override public function get measuredWidth():Number
	    {
	        return this.buttonWidth;
	    }
	    
	    
	    /**
	     *  @private
	     */        
	    override public function get measuredHeight():Number
	    {
	        return this.buttoneHeight;
	    }
		
		
		/**
		 * 
		 * @param w
		 * @param h
		 * 
		 */		
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			this.buttonWidth=w;
			this.buttoneHeight=h;
			var g:Graphics = graphics;
			g.clear();
			switch(name)
			{
				case "UpSkin":
				case "upSkin":
				{
					drawOverSkin(g);
					break;
				}
				case "OverSkin":
				case "overSkin":
				{
					drawOverSkin(g);
					break;
				}
				case "DownSkin":
				case "downSkin":
				{
					drawSelectOverSkin(g);

					break;
				}
				case "DisabledSkin":
				case "disabledSkin":
				{

					break;
				}
				case "SelectedOverSkin":
				case "selectedOverSkin":
				{
					drawSelectOverSkin(g);
					break;
				}
				case "SelectedUpSkin":
				case "selectedUpSkin":
				{
					drawSelectOverSkin(g);
					break;
				}
				case "SelectedDownSkin":
				case "selectedDownSkin":
				{
					drawSelectOverSkin(g);
					break;
				}
				case "selectedDisabledSkin":
				case "SelectedDisabledSkin":
				{
					drawSelectOverSkin(g);
					break;
				}
				default:

			}         
            g.endFill();
		} 
		private function drawOverSkin(g:Graphics):void{
			g.lineStyle(1,0xd1c186,1);
			g.moveTo(0,0);
			g.lineTo(0,buttoneHeight);
			g.moveTo(buttonWidth,0);
			g.lineTo(buttonWidth,buttoneHeight);
		}
		private function drawSelectOverSkin(g:Graphics):void{
			g.beginFill(0xf5ebc7,1);
			g.drawRect(0,0,buttonWidth,buttoneHeight);
			g.moveTo(0,0);
			g.lineStyle(1,0xd1c186,1);
			g.lineTo(0,buttoneHeight);
			g.moveTo(buttonWidth,0);
			g.lineTo(buttonWidth,buttoneHeight);
		}


	}
}
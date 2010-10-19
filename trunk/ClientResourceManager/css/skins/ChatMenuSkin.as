package skins
{
	import flash.display.Graphics;
	
	import mx.core.UIComponent;
	import mx.skins.Border;
	

	
	
	
	

	public class ChatMenuSkin extends Border
	{
        
        private var buttonWidth:int;
        private var buttoneHeight:int;
        private var backgroundColor:int;
					
        
		public function ChatMenuSkin()
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
			backgroundColor = UIComponent( this.parent ).getStyle( "borderColor" );
//  			(this.parent as UIComponent).setStyle( "borderColor", "" );

			this.buttonWidth=w;
			this.buttoneHeight=h;
			var g:Graphics = graphics;
			g.clear();
			switch(name)
			{
				case "UpSkin":
				case "upSkin":
				{
					drawUpSkin(g);
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
					drawUpSkin(g);

					break;
				}
				case "DisabledSkin":
				case "disabledSkin":
				{
					drawUpSkin(g);
					break;
				}
				case "SelectedOverSkin":
				case "selectedOverSkin":
				{
					drawUpSkin(g);
					break;
				}
				case "SelectedUpSkin":
				case "selectedUpSkin":
				{
					drawUpSkin(g);
					break;
				}
				case "SelectedDownSkin":
				case "selectedDownSkin":
				{
					drawUpSkin(g);
					break;
				}
				case "selectedDisabledSkin":
				case "SelectedDisabledSkin":
				{
					drawUpSkin(g);
					break;
				}
				default:

			}         
            g.endFill();
		} 
		private function drawOverSkin(g:Graphics):void{
			g.beginFill(backgroundColor,1);
			g.drawRect(0,0,buttonWidth,buttoneHeight);
		}
		private function drawUpSkin(g:Graphics):void{
			g.beginFill(backgroundColor,0);
			g.drawRect(0,0,buttonWidth,buttoneHeight);
		}


	}
}
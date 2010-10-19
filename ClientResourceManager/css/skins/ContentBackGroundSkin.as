package skins
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	import mx.core.BitmapAsset;
	import mx.core.UIComponent;

	public class ContentBackGroundSkin extends RecBorder
	{
		public function ContentBackGroundSkin()
		{
			super();
		}
		private var backgroundColor:uint;
        private var backgroundAlpha:Number;
        private var borderColor:uint;
        private var cornerRadius:int;
        
        private  var bit:Graphics = graphics;

		private var tile:BitmapData;//背景图
		
		private var pattern:BitmapData;//边角
		
		private var patternSpace:int=3;//边角离边框宽度
		


        
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
				 bit.clear();
			  	
				backgroundColor = getStyle("backgroundColor");
				backgroundAlpha = getStyle("backgroundAlpha");
				borderColor = getStyle("borderColor");
				cornerRadius = getStyle("cornerRadius");
				backgroundColor=backgroundColor=null?0xffffff:backgroundColor;
				backgroundAlpha=backgroundAlpha=null?1:backgroundAlpha;
				borderColor=borderColor=null?0xffffff:borderColor;
				cornerRadius=cornerRadius=null?0:cornerRadius;
	            if(w != 0){
	            	bit.lineTo(0,0);
					bit.beginFill(backgroundColor,backgroundAlpha);
					bit.lineStyle(1,borderColor);
					bit.drawRoundRectComplex(0,0,w,h,cornerRadius,cornerRadius,cornerRadius,cornerRadius); 
					bit.endFill();  	
	            }
	            
//	             bit.lineStyle(0,0,0);
//	             var background:BitmapAsset = BitmapAsset(new imgCls());
//			     tile= background.bitmapData;
//
//                 var background_bianjiao:BitmapAsset = BitmapAsset( new CssImager.pattern);
//			     pattern= background_bianjiao.bitmapData;
//				
//
//
//				 
//				
//				 var bgImgWidht:int=w>=background.width?background.width:w;
//				
//				 var bgImgHeight:int=h>=background.height?background.height:h;
//				
//				  var bgScale:Number=1;
//				 if(w>=background.width){
//				 	if(h>=background.height){
//				 		bgScale=1;
//				 	}else{
//				 		bgScale=h/background.height;
//				 	}
//				 	
//				 }else{
//				 	if(h>=background.height){
//				 		bgScale=background.height/h;
//				 	}else{
//				 		bgScale=w/background.width>=h/background.height?h/background.height:w/background.width;
//				 	}
//				 }
////				 var bgImgWidthDistance:int=w-background.width*bgScale;
////				 var bgImgHeightDistace:int=h-background.height*bgScale;
////				 var bgImgMatrix:Matrix=new Matrix();
////				 bgImgMatrix.scale(bgScale,bgScale);
////				 bgImgMatrix.translate(bgImgWidthDistance,bgImgHeightDistace);
//				 
//				 var bgImgBitmapData:BitmapData = new BitmapData(bgImgWidht, bgImgHeight,true,0x0);
////				 bgImgBitmapData.draw(tile,bgImgMatrix);
////				 bit.beginBitmapFill(tile,bgImgMatrix,true);
////                 bit.drawRect(bgImgWidthDistance+patternSpace, bgImgHeightDistace+patternSpace, background.width*bgScale-patternSpace*2, background.height*bgScale-patternSpace*2);	
//				
//
//				
//				
//				
//				
//				 //左上
//			     var leftTopMatrix:Matrix = new Matrix();
//				 leftTopMatrix.translate(patternSpace,patternSpace);
//				 leftTopMatrix.rotate(0);
//				 
//				 
//				 var leftTopBitmapData:BitmapData = new BitmapData(pattern.width+patternSpace, pattern.height+patternSpace,true,0x0);
//				 leftTopBitmapData.draw(pattern,leftTopMatrix);
//
//				 bit.beginBitmapFill(leftTopBitmapData);
//				 bit.drawRect(patternSpace,patternSpace, pattern.width, pattern.height);
//				 
//				 //右上
//				 var rightTopMatrix:Matrix = new Matrix();
//				 rightTopMatrix.translate(patternSpace,-pattern.height-patternSpace);
//				 rightTopMatrix.rotate(Math.PI/2);
//				 
//				 var rightTopBitmapData:BitmapData = new BitmapData(w-pattern.width-patternSpace*2, pattern.height+patternSpace,true,0x0);
//				 rightTopBitmapData.draw(pattern,rightTopMatrix);
//				 bit.beginBitmapFill(rightTopBitmapData);
//				 bit.drawRect(w-pattern.width-patternSpace,patternSpace, pattern.width, pattern.height);
//				 
//				 
//				//左下
//   				 var leftBottomMatrix:Matrix = new Matrix();
//				 leftBottomMatrix.translate(-pattern.width-patternSpace,patternSpace);
//				 leftBottomMatrix.rotate(Math.PI/2*3);
//				 
//				 
//				 var leftBottomBitmapData:BitmapData = new BitmapData(pattern.width+patternSpace, h-pattern.height-patternSpace*2,true,0x0);
//				 leftBottomBitmapData.draw(pattern,leftBottomMatrix);
//				 bit.beginBitmapFill(leftBottomBitmapData);
//				 bit.drawRect(patternSpace,h-pattern.height-patternSpace, pattern.width, pattern.height);
//			
//			
//				//右下
//				 var rightBottomMatrix:Matrix = new Matrix();
//				 rightBottomMatrix.translate(-pattern.width-patternSpace,-pattern.height-patternSpace);
//				 rightBottomMatrix.rotate(Math.PI);
//				 
//				 var rightBottomBitmapData:BitmapData = new BitmapData(w-pattern.width-patternSpace*2, h-pattern.height-patternSpace*2,true,0x0);
//				 rightBottomBitmapData.draw(pattern,rightBottomMatrix);
//				 bit.beginBitmapFill(rightBottomBitmapData);
//				 bit.drawRect(w-pattern.width-patternSpace,h-pattern.height-patternSpace, pattern.width, pattern.height);
//			
			
			}
        }
	}		
}
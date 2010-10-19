package skins
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.core.BitmapAsset;
	import mx.core.UIComponent;
	
	public class FunctionWinSkin extends RecBorder
	{
		public function FunctionWinSkin() 
		{
			super();
		}
		[Embed("assets/images/EmbedImages/uiBackGround/functionInfoBG.png")]
		private var imgCls:Class;//设置之后不接收css定义的背景设置
		
	    private var bit:Graphics = graphics;
		private var tile:BitmapData;//背景图
		private var borderWidth:int=30;//边框宽
		private var borderHeight:int=30;//边框高
		private var topV:int=27;
		private var bottomV:int=10;
		private var leftV:int=20;
		private var rightV:int=20;
		private var matrix:Matrix=new Matrix();
    	
        override protected function updateDisplayList(w:Number, h:Number):void {
	        if (!parent)
	            return;
			super.updateDisplayList(w, h);
			
			if( imgCls == null ) {
	            	var backgroundImage:Object = UIComponent( this.parent ).getStyle("backgroundImage");
	            	if( backgroundImage != null && backgroundImage != "" ) {
						imgCls = Class( backgroundImage );
//						(this.parent as UIComponent).setStyle( "backgroundImage", "" );
					}
				}
			if( imgCls != null ) {
			  var background:BitmapAsset = BitmapAsset(new imgCls());
			  tile= background.bitmapData;
	  
			  //上左
			  var tile0:BitmapData = new BitmapData(leftV,topV);  
			  
			  //上中
			  var tile1:BitmapData = new BitmapData(background.width-leftV-rightV,topV);  
			  
			  //中间区域
			  var tile2:BitmapData = new BitmapData(background.width-leftV-rightV,background.height-topV-bottomV); 

			  
			  //上右
			   var tile3:BitmapData = new BitmapData(rightV,topV);
			  
			  //中左
			  var tile4:BitmapData = new BitmapData(leftV,background.height-topV-bottomV);
			
			  
			  //中右
			  var tile5:BitmapData = new BitmapData(rightV,background.height-topV-bottomV);

			  
			  //下左
			   var tile6:BitmapData = new BitmapData(leftV,bottomV);

			  
			  //下中
			   var tile7:BitmapData = new BitmapData(background.width-leftV-rightV,bottomV); 

			 
			  //下右
			  var tile8:BitmapData = new BitmapData(rightV,bottomV);


			  
			  bit.clear();

				//上左
				tile0.copyPixels(tile,new Rectangle(0, 0,leftV, topV),new Point(0,0));
				bit.beginBitmapFill(tile0);
                bit.drawRect(0, 0,leftV, topV);
                
                //上中
                tile1.copyPixels(tile,new Rectangle(leftV, 0,background.width-leftV-rightV, topV),new Point(0,0));  
                matrix.tx=-(leftV-w%leftV);
				matrix.ty=0;
                bit.beginBitmapFill(tile1,matrix);
                bit.drawRect(leftV, 0, w-leftV-rightV, topV);
                

   
                //中间区域
                tile2.copyPixels(tile,new Rectangle(leftV, topV,background.width-leftV-rightV, background.height-topV-bottomV),new Point(0,0));  
                matrix.tx=-(leftV-w%leftV);
				matrix.ty=-(topV-h%topV);
                bit.beginBitmapFill(tile2,matrix);
                bit.drawRect(leftV, topV, w-leftV-rightV, h-topV-bottomV);
                
                //上右
                matrix.tx=-(rightV-w%rightV);
                matrix.ty=0;
                tile3.copyPixels(tile,new Rectangle(background.width-rightV, 0,rightV, topV),new Point(0,0));
				bit.beginBitmapFill(tile3,matrix);
                bit.drawRect(w-rightV, 0, rightV, topV);
                
                //中左
                tile4.copyPixels(tile,new Rectangle(0, topV,leftV, background.height-topV-bottomV),new Point(0,0)); 
                matrix.tx=0;
                matrix.ty=-(topV-h%topV);
                bit.beginBitmapFill(tile4,matrix);
                bit.drawRect(0, topV, leftV, h-topV-bottomV);
                
                 //中右
                tile5.copyPixels(tile,new Rectangle(background.width-rightV, topV,rightV, background.height-topV-bottomV),new Point(0,0));
				matrix.tx=-(rightV-w%rightV);
				matrix.ty=-(topV-h%topV);
				bit.beginBitmapFill(tile5,matrix);
                bit.drawRect(w-rightV, topV, rightV, h-topV-bottomV);

                //下左
				tile6.copyPixels(tile,new Rectangle(0, background.height-bottomV, leftV, background.height),new Point(0,0));
				matrix.tx=0;
				matrix.ty=-(bottomV-h%bottomV);
				bit.beginBitmapFill(tile6,matrix);
                bit.drawRect(0, h-bottomV, leftV, bottomV);
                
                //下中
				tile7.copyPixels(tile,new Rectangle(leftV,background.height-bottomV,background.width-leftV-rightV, bottomV),new Point(0,0));
				bit.beginBitmapFill(tile7,matrix);
                bit.drawRect(leftV, h-bottomV, w-leftV-rightV, bottomV);
                
                //下右
                tile8.copyPixels(tile,new Rectangle(background.width-rightV, background.height-bottomV, rightV, bottomV),new Point(0,0));
				matrix.tx=-(rightV-w%rightV);
				matrix.ty=-(bottomV-h%bottomV);
				bit.beginBitmapFill(tile8,matrix);
                bit.drawRect(w-rightV, h-bottomV, rightV, bottomV);
                bit.endFill();
             
			}
        }
	}		

}
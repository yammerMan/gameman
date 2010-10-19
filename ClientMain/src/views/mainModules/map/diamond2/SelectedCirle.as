package views.mainModules.map.diamond2
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import roma.common.constants.FieldConstant;
	import roma.resource.ImgManager;
	import roma.util.FiltersUtil;
	import roma.util.MultiLang;
	
	public class SelectedCirle
	{
		private static const TEXT_HEIGHT:int = 20;
		private static const TEXT_WIDTH:int = 60;

		private static const sourceRect:Rectangle = new Rectangle(0,0,128,64);

		private var tf1:TextField;
		private var tf2:TextField;
		
		private var selectBitmapData:BitmapData ;
		private var useBitmapData:BitmapData;

		private var tileX:int = -999;
		private var tileY:int = -999;
		private var level:int = -999;
		
		private var matirx1:Matrix = new Matrix(1,0,0,1, 34,6);
		private var matirx2:Matrix = new Matrix(1,0,0,1, 34,28);

		public function SelectedCirle()	{
			var clazz:Class = ImgManager.clazz("map.selection");
			var bmp:Bitmap = new clazz as Bitmap;
			this.selectBitmapData = bmp.bitmapData;
			
/* 			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.size = 14;
			format.bold = true; 
			format.font = "Arial";
			
			this.tf1 = creatTextField(34,6,format);			
			this.tf2 = creatTextField(34,28,format);
 */		}

		public function setData(tileX:int, tileY:int , level:int):void {
			if (this.tileX != tileX || this.tileY != tileY || this.level!=level) {
				this.tileX = tileX;
				this.tileY = tileY;
				this.level = level;

				this.useBitmapData = this.selectBitmapData.clone();

/* 				this.matirx2.ty =22;
				if (this.level>0) {
					this.tf1.text = Lang.msg('public.label.level')+" "+this.level;
					this.useBitmapData.draw(tf1,matirx1);
					this.matirx2.ty=28;
				} else {
					this.tf1.text = "";
				}

				this.tf2.text = TileHelper.tranTileXY2FieldXY(this.tileX) + "," + TileHelper.tranTileXY2FieldXY(this.tileY);

				this.useBitmapData.draw(tf2,matirx2);
 */			}
		}
		
		public function drawToScene(scene:BitmapData , mapUi:DisplayObject):void{
			var mapLocalX:int = (this.tileX - this.tileY) * DiamondWorldMap2.TILE_WIDTH  /2 + mapUi.x;
			var mapLocalY:int = (this.tileX + this.tileY) * DiamondWorldMap2.TILE_HEIGHT /2 + mapUi.y;

			var destPoint:Point = new Point(mapLocalX , mapLocalY);
			scene.copyPixels(this.useBitmapData,sourceRect, destPoint);
		}
		
		private function creatTextField($x:int,$y:int,$format:TextFormat):TextField{
			var tf:TextField = new TextField();
			tf.filters = [FiltersUtil.glowFilter];
			tf.textColor = 0xffffff;
			tf.height = TEXT_HEIGHT;
			tf.width = TEXT_WIDTH;
			tf.defaultTextFormat = $format;
			tf.x = $x;
			tf.y = $y;
			return tf;
		}
	}
}
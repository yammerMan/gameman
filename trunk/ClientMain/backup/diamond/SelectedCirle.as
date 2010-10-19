package views.mainModules.map
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import roma.resource.ImgManager;
	import roma.util.FiltersUtil;

	public class SelectedCirle extends Sprite
	{
		private var tf:TextField = new TextField() ;

		public function SelectedCirle(){
			var clazz:Class = ImgManager.clazz("map.selection");
			var bmp:Bitmap = new clazz as Bitmap;
			this.addChild(bmp);

			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.size = 14;
			format.bold = true; 
			format.font = "Arial";
			
			tf.filters = [FiltersUtil.glowFilter];
			tf.textColor = 0xffffff;
			tf.height = 20;
			tf.width = 60;
			tf.defaultTextFormat = format;
			tf.x = 34;
			tf.y = 22;
			
			this.addChild(tf);
		}
		
		public function setMapTile(tile:IMapTile):void {
			tf.text = tile.getFieldX() + "," + tile.getFieldY();
		}
	}
}
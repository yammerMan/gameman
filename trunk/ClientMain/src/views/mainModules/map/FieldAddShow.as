package views.mainModules.map
{
	import animation.AniPlayer;
	import animation.BaseAnimationData;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import roma.util.FiltersUtil;
	
	import views.mainModules.map.diamond2.DiamondMapTile2;

	public class FieldAddShow
	{ 
		private static var TEXT_WIDTH:int = 50;
		private static var TEXT_HEIGHT:int = 20;
		
		private static const Field_TEXT_X:int = 55;
		private static const Field_TEXT_Y:int = 15;
		
		private var addTextBitmapData:BitmapData;
		
		private var tf1:TextField;
		
		private var textRect:Rectangle = new Rectangle(0,0,TEXT_WIDTH,TEXT_HEIGHT);
		
		public function FieldAddShow()
		{

			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.size = 12;
			format.bold = true;
			format.font = "Tahoma";
			
			this.tf1 = this.creatTextField(0,0,format);
		}
		
		public function setLevel(level:int):void{
			this.tf1.text = "+"+level*3 +"%";
			
			if(addTextBitmapData !=null){
				this.addTextBitmapData.dispose();
			}
			
			this.addTextBitmapData = new BitmapData(TEXT_WIDTH,TEXT_HEIGHT,true,0);
			this.addTextBitmapData.draw(tf1);
		}
		
		public function drawToScene(sceneContain:BitmapData, px:int=0, py:int=0):void{
			if(addTextBitmapData !=null){
				sceneContain.copyPixels(addTextBitmapData,textRect,new Point(px+Field_TEXT_X,py+Field_TEXT_Y));
			}
		}

		private function creatTextField($x:int,$y:int,$format:TextFormat):TextField{
			var tf:TextField = new TextField();
			tf.filters = [FiltersUtil.glowFilter];
			tf.textColor = 0xc0ff3a;
			tf.height = TEXT_HEIGHT;
			tf.width = TEXT_WIDTH;
			tf.defaultTextFormat = $format;
			tf.x = $x;
			tf.y = $y;
			return tf;
		}
	}
}
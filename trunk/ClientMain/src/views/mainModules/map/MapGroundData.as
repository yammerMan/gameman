package views.mainModules.map
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import roma.resource.ImgManager;
	
	public class MapGroundData
	{
		public static var instance:MapGroundData = new MapGroundData();
		
		public var groundData:BitmapData;
		
		public static const GROUND_WIDTH :int = 640;
		
		public static const GROUND_HEIGHT:int = 640;
		
		public static const GROUND_RECT:Rectangle = new Rectangle(0,0,GROUND_WIDTH, GROUND_HEIGHT);
		
		public function MapGroundData()
		{
			
			var clazz:Class = ImgManager.clazz("map.ground");
			var bitmap:Bitmap = new clazz as Bitmap;
			this.groundData = bitmap.bitmapData;
		}

		public static function getGroundY(mapY:int):int {		
			var groundSourceY:int = mapY % GROUND_HEIGHT;
			if (groundSourceY <0) {
				groundSourceY += GROUND_HEIGHT;
			}
			return groundSourceY;
		}
		
		public static function getGroundX(mapX:int):int {		
			var groundSourceX:int = mapX % GROUND_WIDTH;
			if (groundSourceX <0) {
				groundSourceX += GROUND_WIDTH;
			}
			return groundSourceX;
		}
	}
}
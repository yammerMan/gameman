package views.mainModules.map.diamond2
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import roma.resource.ImgManager;
	
	public class CloudInMap
	{
		
		public static const CLOUD_SCENE_WIDTH:int = 1150;
		public static const CLOUD_SCENE_HEIGHT:int = 550;
		
		private static const PIC_WIDTH:int = 150;
		private static const PIC_HEIGHT:int = 150;

		public static const CLOUD_RECT:Rectangle = new Rectangle(0,0,PIC_WIDTH, PIC_HEIGHT);
		
		private var cloudX:Number = 0;
		private var cloudY:Number = 0;
		
		private var vx:Number;
		private var vy:Number
		
		private static var _cloudBitmapData:BitmapData; 
		private static function get cloudBitmapData():BitmapData {
			if (_cloudBitmapData == null) {
				var clazz:Class = ImgManager.clazz('city.cloud');
				var bmp:Bitmap = new clazz() as Bitmap;
				_cloudBitmapData = bmp.bitmapData;
			}
			return _cloudBitmapData;
		}
		
		public function CloudInMap(sx:Number=0 , sy:Number=0 , vx:Number = 0.5, vy:Number = 0.5)	{
			this.cloudX = sx;
			this.cloudY = sy;
			this.vx = vx;
			this.vy = vy;
			
		}

		public function drawToScene(scene:BitmapData,mapUiComp:DisplayObject):void{
			this.cloudX += this.vx ;
			if (this.cloudX > CLOUD_SCENE_WIDTH) {
				this.cloudX = 0;
			} 
			
			this.cloudY += this.vy;
			if (this.cloudY > CLOUD_SCENE_HEIGHT) {
				this.cloudY = 0;
			}
			
			var ix:int = mapUiComp.x % CLOUD_SCENE_WIDTH  + this.cloudX;
			if (ix < -PIC_WIDTH) {
				ix += CLOUD_SCENE_WIDTH;
			} else if (ix > DiamondWorldMap2.SCENE_WIDTH) {
				ix -= CLOUD_SCENE_WIDTH;
			}
			
			var iy:int = mapUiComp.y  % CLOUD_SCENE_HEIGHT + this.cloudY;
			if (iy < - PIC_HEIGHT) {
				iy += CLOUD_SCENE_HEIGHT;
			} else if (iy > DiamondWorldMap2.SCENE_HEIGHT) {
				iy -= CLOUD_SCENE_HEIGHT;
			}
						
			scene.copyPixels(cloudBitmapData, CLOUD_RECT ,new Point(ix, iy));	
		}
	}
}
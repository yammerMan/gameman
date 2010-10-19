package animation
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import mx.resources.ResourceManager;
	
	public class AniDataManager
	{
		public static var instance:AniDataManager = new AniDataManager();
		
		private var bitmapContainer:Dictionary = new Dictionary();
		private var mx:Matrix = new Matrix(); 

		public function getAniBitmapData(name:String, rect:Rectangle=null,point:Point = null):BitmapData {
			var key:String = name;
			if (rect!=null) {
				key +=rect.toString();
			}
			if(point != null){
				key += point.toString();
			}
			
			var res:BitmapData = this.bitmapContainer[key] as BitmapData;
			if (res ==null) {
				var clazz:Class = ResourceManager.getInstance().getClass("ani" , name);
				if (clazz!=null) {
					var soureceBitmap:Bitmap = new clazz as Bitmap;
					if(rect != null){
						if(point != null){
			                mx.tx = -point.x;
			                mx.ty = -point.y;
						} else {
							mx.tx = 0;
							mx.ty = 0;
						}
						res = new BitmapData(rect.width,rect.height,true,0x0);
						res.draw(soureceBitmap.bitmapData,mx,null,null,rect,true);  
					}
					else{
						res = soureceBitmap.bitmapData;
					}
					this.bitmapContainer[key] = res;
				}
			}
			return res;
		}

	}
}
package views.mainModules.map.diamond2
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	
	import roma.common.constants.FieldConstant;
	import roma.resource.ImgManager;
	
	public final class ZoneGenerator
	{  
		private static var instance:ZoneGenerator;
		
		private var zCMap:Dictionary = new Dictionary;
		private var zoneData:BitmapData
		
		private var mapWidth:Number;
		private var mapHeight:Number;
		
		public function ZoneGenerator()
		{
			setMap();
			zoneData = getZoneMap();
		}
		
		private function setMap():void{
			zCMap["0xff"]     = 0;
			zCMap["0x0"]      = 1;
			zCMap["0x666666"] = 2;
			zCMap["0xff00"]   = 3;
			zCMap["0xffff"]   = 4;
			zCMap["0xff0000"] = 5;
			zCMap["0xff00ff"] = 6;
			zCMap["0xffffff"] = 7;
			zCMap["0xffff00"] = 8;
			zCMap["0x660099"] = 9;
		}
		
		public static function getInstance():ZoneGenerator{
			if(instance == null){
				instance = new ZoneGenerator();
			}
			return instance;
		}
		
		private function getZoneMap():BitmapData{
			var cl:Class = ImgManager.clazz("map.zone");
			var map:Bitmap = new cl() as Bitmap;
			this.mapWidth = map.bitmapData.width;
			this.mapHeight = map.bitmapData.height;
			return map.bitmapData;
		}
		
		public function getZoneId(idField:int):int{
			var fx:int = idField/10000;
			var fy:int = idField%10000;
			
			var pointX:int = fx*mapWidth/FieldConstant.MAP_SIZE;
			var pointY:int = fy*mapHeight/FieldConstant.MAP_SIZE;
			
			var c:String ="0x"+this.zoneData.getPixel(pointX,pointY).toString(16);
	
			if(zCMap[c] !=null){
				return zCMap[c];
			}else{
				return 10;
			}
		}
	}
}
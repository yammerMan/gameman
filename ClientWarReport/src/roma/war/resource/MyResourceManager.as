package roma.war.resource
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import roma.common.constants.ResourceConstant;
	import roma.common.constants.TroopForConstants;
	
	public class MyResourceManager
	{
		public static var instance:MyResourceManager= new MyResourceManager();
		
		private var troopIcon:Object = {};
		private var resourceObj:Object = {};
		
		private var resourceDic:Dictionary = new Dictionary()
		
		public function MyResourceManager()
		{
			troopIcon[TroopForConstants.T_ARCHERS] = Bitmap(new TROOP_ARCHERS_ICON()).bitmapData;
			troopIcon[TroopForConstants.T_BALLISTAS] = Bitmap(new TROOP_BALLISTAS_ICON()).bitmapData;
			troopIcon[TroopForConstants.T_CAVALRY] = Bitmap(new TROOP_CAVALRY_ICON()).bitmapData;
			troopIcon[TroopForConstants.T_ONAGERS] = Bitmap(new TROOP_ONAGERS_ICON()).bitmapData;
			troopIcon[TroopForConstants.T_TRIARII] = Bitmap(new TROOP_TRIARII_ICON()).bitmapData;
			troopIcon[TroopForConstants.T_URBAN_COHORT] = Bitmap(new TROOP_COHORT_ICON()).bitmapData;
			
			resourceObj[ResourceConstant.TYPE_FOOD] = Bitmap(new FOOD_ICON()).bitmapData;
			resourceObj[ResourceConstant.TYPE_WOOD] = Bitmap(new WOOD_ICON()).bitmapData;
			resourceObj[ResourceConstant.RESOURCE_TYPE_STONES] = Bitmap(new STONE_ICON()).bitmapData;
			resourceObj[ResourceConstant.TYPE_IRON] = Bitmap(new IRON_ICON()).bitmapData;
			resourceObj[ResourceConstant.RESOURCE_TYPE_MONEY] = Bitmap(new GOLD_ICON()).bitmapData;
			
			resourceDic = new Dictionary();
		}
		
		/**
		 * 获得军队图标
		 */ 
		public function getTroopIcon(tId:int):BitmapData{
			return troopIcon[tId];
		}
		
		public function getResourceIcon(rId:int):BitmapData{
			return resourceObj[rId];
		}
		
		/**
		 * 资源图标
		 */ 
		[Embed(source="embeds/food.png",mimeType="image/png")]
		public var FOOD_ICON:Class;
		[Embed(source="embeds/wood.png",mimeType="image/png")]
		public var WOOD_ICON:Class;
		[Embed(source="embeds/stone.png",mimeType="image/png")]
		public var STONE_ICON:Class;
		[Embed(source="embeds/iron.png",mimeType="image/png")]
		public var IRON_ICON:Class;
		[Embed(source="embeds/gold.png",mimeType="image/png")]
		public var GOLD_ICON:Class;
		
		/**
		 * 兵种图标
		 */ 
		[Embed(source="embeds/archersSmall.png",mimeType="image/png")]
		public var TROOP_ARCHERS_ICON:Class;
		[Embed(source="embeds/ballistasSmall.png",mimeType="image/png")]
		public var TROOP_BALLISTAS_ICON:Class;
		[Embed(source="embeds/cavalrySmall.png",mimeType="image/png")]
		public var TROOP_CAVALRY_ICON:Class;
		[Embed(source="embeds/urban_cohortSmall.png",mimeType="image/png")]
		public var TROOP_COHORT_ICON:Class;
		[Embed(source="embeds/onagersSmall.png",mimeType="image/png")]
		public var TROOP_ONAGERS_ICON:Class;
		[Embed(source="embeds/triariiSmall.png",mimeType="image/png")]
		public var TROOP_TRIARII_ICON:Class;
		
	
		/**
		 * @返回所有图片的BitmapData
		 */ 
		public function getBitmapData(res:BitmapData, rect:Rectangle=null,point:Point = null,nameStr:String=""):BitmapData {
			var bit:BitmapData;
			if(resourceDic[nameStr] != null){
				bit = resourceDic[nameStr];
				return bit;
			}
			if (res ==null) {
				throw new Error("bitmapData can not be null");
				}
			else{
				if(rect != null){
					var mx:Matrix = new Matrix();
					mx.tx = - point.x;
					mx.ty = - point.y;
					bit = new BitmapData(rect.width,rect.height,true,0);
					bit.draw(res,mx,null,null,rect,true);  
				}
				else{
					bit = res;
				}
				resourceDic[nameStr+point.x+""+point.y] = bit;
			}
			return bit;
		}
	
	}
}
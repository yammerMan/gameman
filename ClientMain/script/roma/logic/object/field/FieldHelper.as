package roma.logic.object.field
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.resources.ResourceManager;
	
	import roma.common.constants.FieldConstant;
	import roma.resource.ImgManager;
	import roma.util.MultiLang;
	
	public class FieldHelper
	{
		private static const REC_WIDTH:int =128;
		private static const REC_HEIGHT:int =128;
		
		private static const REC_WIDTH_SMALL:int =102;
		private static const REC_HEIGHT_SMALL:int =47;
		
		public static function getFieldName(fType:int, fieldLevel:int=0):String {
			switch (fType) {
				case FieldConstant.DESERT_TYPE :
					if(fieldLevel>=1 && fieldLevel<=4){
						return MultiLang.msg("field.desert.1");
					}else if(fieldLevel>=5 && fieldLevel<=8){
						return MultiLang.msg("field.desert.2");
					}else if(fieldLevel >=9 && fieldLevel<=10){
						return MultiLang.msg("field.desert.3");
					}else {
						return MultiLang.msg("field.desert.name");
					}
				case FieldConstant.TYPE_TREES :
					if(fieldLevel>=1 && fieldLevel<=4){
						return MultiLang.msg("field.forest.1");
					}else if(fieldLevel>=5 && fieldLevel<=8){
						return MultiLang.msg("field.forest.2");
					}else if(fieldLevel >=9 && fieldLevel<=10){
						return MultiLang.msg("field.forest.3");
					}else {
						return MultiLang.msg("field.forest.name");
					}

				case FieldConstant.HILL_TYPE :
					if(fieldLevel>=1 && fieldLevel<=4){
						return MultiLang.msg("field.hill.1");
					}else if(fieldLevel>=5 && fieldLevel<=8){
						return MultiLang.msg("field.hill.2");
					}else if(fieldLevel >=9 && fieldLevel<=10){
						return MultiLang.msg("field.hill.3");
					}else {
						return MultiLang.msg("field.hill.name");
					}

				case FieldConstant.LAKE_TYPE :
					if(fieldLevel>=1 && fieldLevel<=4){
						return MultiLang.msg("field.lake.1");
					}else if(fieldLevel>=5 && fieldLevel<=8){
						return MultiLang.msg("field.lake.2");
					}else if(fieldLevel >=9 && fieldLevel<=10){
						return MultiLang.msg("field.lake.3");
					}else {
						return MultiLang.msg("field.lake.name");
					}
				case FieldConstant.FLAT_TYPE :
					return MultiLang.msg("field.flat.name");
				case FieldConstant.TYPE_NPC_FIELD :
					return MultiLang.msg("field.trainingRoom.name.shortening");
				case 14 :
					return MultiLang.msg("field.ratterNpc.name.shortening");
			}
			return String(fType);
		}
		
		public static function getFieldDesc(fType:int , level:int):String {
			var lv:int = level*3;
			switch (fType) {
				case FieldConstant.DESERT_TYPE :
					return MultiLang.msg("field.desert.desc{0}",lv);
				case FieldConstant.TYPE_TREES :
					return MultiLang.msg("field.forest.desc{0}",lv);
				case FieldConstant.HILL_TYPE :
					return MultiLang.msg("field.hill.desc{0}",lv);
				case FieldConstant.LAKE_TYPE :
					return MultiLang.msg("field.lake.desc{0}",lv);
				case FieldConstant.FLAT_TYPE :
					return MultiLang.msg("field.flat.desc");
				
			}
			return String(fType);
		}
		
		public static function getFieldMapIcon(fType:int, fLev:int=0,smallIcon:Boolean=false):Bitmap {
			var name:String="";
			switch (fType) {
				case FieldConstant.DESERT_TYPE :
					if(fLev>=1 && fLev<=4){
						name="field.desert1";
					}else if(fLev>=5 && fLev<=8){
						name="field.desert2";
					}else if(fLev >=9 && fLev<=10){
						name="field.desert3";
					}else {
						name="field.desert1";
					}
					break;
				case FieldConstant.TYPE_TREES :
					if(fLev>=1 && fLev<=4){
						name="field.forest1";
					}else if(fLev>=5 && fLev<=8){
						name="field.forest2";
					}else if(fLev >=9 && fLev<=10){
						name="field.forest3";
					}else {
						name="field.forest1";
					}
					break;

				case FieldConstant.HILL_TYPE :
					if(fLev>=1 && fLev<=4){
						name="field.hill1";
					}else if(fLev>=5 && fLev<=8){
						name="field.hill2";
					}else if(fLev >=9 && fLev<=10){
						name="field.hill3";
					}else {
						name="field.hill1";
					}
					break;

				case FieldConstant.LAKE_TYPE :
					if(fLev>=1 && fLev<=4){
						name="field.lake1";
					}else if(fLev>=5 && fLev<=8){
						name="field.lake2";
					}else if(fLev >=9 && fLev<=10){
						name="field.lake3";
					}else {
						name="field.lake1";
					}
					break;
				case FieldConstant.FLAT_TYPE :
					name="field.lake1";//暂没图片
					break;
					
				case FieldConstant.TYPE_CITY :
					if(fLev>=1 && fLev<=4){
						name="field.castle1";
					}else if(fLev>=5 && fLev<=8){
						name="field.castle2";
					}else if(fLev >=9 && fLev<10){
						name="field.castle3";
					}else if(fLev ==10){
						name="field.castle4";
					}else {
						name="field.castle1";
					}
					break;
					
				case FieldConstant.TYPE_NPC_FIELD :
					name="field.trainingRoom";
					break;
				case 14 :
					name="field.ratterNpc";
					break;
				default:
			}
//			return ResourceManager.getInstance().getClass("ani",name);
			var bgClass:Class=ImgManager.clazz("map.ground");
			var contentsClass:Class=ResourceManager.getInstance().getClass("ani",name);
			var dataBG:Bitmap = new bgClass() as Bitmap;
			var bitMap:Bitmap =  new contentsClass() as Bitmap;
			var data:BitmapData ;
			var rect:Rectangle ;
			var pt:Point ;
			var mult:uint = 0xffffff; // 100% 
			if(!smallIcon){
				data= new BitmapData(REC_WIDTH,REC_HEIGHT,true,0);
				rect= new Rectangle(0,0,REC_WIDTH,REC_HEIGHT);
				pt= new Point(0, 0);
				data.copyPixels(dataBG.bitmapData,rect,pt);
				data.copyPixels(bitMap.bitmapData,rect,pt,null,null,true);
				
			}else{
				data= new BitmapData(REC_WIDTH_SMALL,REC_HEIGHT_SMALL,true,0);
				rect= new Rectangle(0,0,REC_WIDTH_SMALL,REC_WIDTH_SMALL);
				pt= new Point(-REC_WIDTH_SMALL/6, -REC_HEIGHT_SMALL*3/4);
				data.copyPixels(dataBG.bitmapData,new Rectangle(0,0,REC_WIDTH_SMALL,REC_HEIGHT_SMALL),new Point(0, 0));
				data.copyPixels(bitMap.bitmapData,new Rectangle(0,0,144,85),new Point(-15, -30),null,null,true);
			}
			return new Bitmap(data);
			
		}
		
		public static function getBitMap(cl:Bitmap):Bitmap{
			var bgClass:Class=ImgManager.clazz("map.ground");
			var dataBG:Bitmap = new bgClass();
			var bitMap:Bitmap =  cl;
			var p:Point = new Point(0, 0);
			var data:BitmapData = new BitmapData(REC_WIDTH,REC_HEIGHT,true,0);
			var rect:Rectangle = new Rectangle(0,0,REC_WIDTH,REC_HEIGHT);
			var mult:uint = 0xffffff; // 100% 
			data.copyPixels(dataBG.bitmapData,rect,p);
			data.copyPixels(bitMap.bitmapData,rect,p,null,null,true);
			return new Bitmap(data);
		}
		
		public static function getFieldLuxItemDesc(lv:int):String{
			switch(lv){
				case 2:
					return MultiLang.msg("field.luxury.item.2");
				case 3:
					return MultiLang.msg("field.luxury.item.3");
				case 4:
					return MultiLang.msg("field.luxury.item.4");
				case 5:
					return MultiLang.msg("field.luxury.item.5");
				case 6:
					return MultiLang.msg("field.luxury.item.6");
				case 7:
					return MultiLang.msg("field.luxury.item.7");
				case 8:
					return MultiLang.msg("field.luxury.item.8");
				case 9:
					return MultiLang.msg("field.luxury.item.9");
				case 10:	
					return MultiLang.msg("field.luxury.item.10");
				default:
					return "";
			
			}
		}  
	}
}
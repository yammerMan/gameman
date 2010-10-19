package views.mainModules.map.diamond2
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import roma.common.valueObject.SimpleMapCastleBean;
	import roma.resource.ImgManager;
	
	public class WorldCupHelper
	{
		public static var instance:WorldCupHelper=new WorldCupHelper();

		private static const POSE:String = "post";
		private static var FLAG_TEXT_X_ADD:int = 64; 

		private var worldCupMastRect:Rectangle = new Rectangle(0,0,2,21);
		private var worldCupRect:Rectangle = new Rectangle(0,0,24,17);
		
		private var flagDic:Dictionary=new Dictionary();
		private var footballDic:Dictionary=new Dictionary();
		
		
		public function WorldCupHelper()
		{
			getFlag();
		}
		
		private function getFlag():void{
			var flagClass:Class=ImgManager.clazz("theWorldCup.mast")
			flagDic[POSE]=new flagClass as Bitmap;
			
			for(var i:int=101;i<133;i++){
				flagClass=ImgManager.clazz("theWorldCup."+i);
				flagDic[i]=new flagClass as Bitmap;
			}
			for(var j:int=133;j<143;j++){
				flagClass=ImgManager.clazz("bedge."+j);
//				if(flagClass==null)continue;
				flagDic[j]=new flagClass as Bitmap;
			}
		}

		public function getFlagData(flagType:*):BitmapData{
			if(flagDic[flagType]!=null)
				return Bitmap(flagDic[flagType]).bitmapData;

			return null;
		}

		public function drawBitmapdata(bean:SimpleMapCastleBean,scene:BitmapData,cx:int,cy:int):void{
			for(var flag:int=0;flag<bean.uiBuffsArray.length;flag++){
				if(bean.uiBuffsArray[flag]>=101&&bean.uiBuffsArray[flag]<=142){
					scene.copyPixels(WorldCupHelper.instance.getFlagData(POSE),worldCupMastRect,new Point(cx+FLAG_TEXT_X_ADD-2,cy-1));
					scene.copyPixels(WorldCupHelper.instance.getFlagData(bean.uiBuffsArray[flag]),worldCupRect,new Point(cx+FLAG_TEXT_X_ADD,cy-1));
				}
			}
		}
	}
}
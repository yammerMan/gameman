package views.windows.functionWins.mail.ReportUi.battleResult
{
	import animation.AniDataManager;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import roma.common.constants.BuildingConstant;
	
	public class TownShowObj
	{
		public static var instance:TownShowObj = new TownShowObj();
		
		private var positionDic:Dictionary = new Dictionary();
		private var positionArray:Array = new Array(
		//1行
			{x:672 ,y:80 , p:7, l:0},
			{x:736 ,y:112, p:8, l:0},
		//2行
			{x:320 ,y:0 , p:5, l:0},
			{x:384 ,y:32 , p:2, l:0},
			
			{x:640 ,y:160 , p:13, l:0},
			{x:704 ,y:192 , p:15, l:0},
			{x:768 ,y:224 , p:28, l:3},//3级			
		//3 行
			{x:256 ,y:32 , p:1, l:0},		
			{x:320 ,y:64 , p:3, l:0},
			
			{x:576 ,y:192 , p:14, l:0},
			{x:640 ,y:224 , p:16, l:0},
			{x:704 ,y:256 , p:29, l:3},//3级			
		//4行	
			{x:160 ,y:80 , p:4, l:0},
			{x:224 ,y:112, p:9, l:0},			
			{x:288 ,y:144, p:11, l:0},	
				
			{x:416 ,y:208 , p:17, l:0},
			{x:480 ,y:240 , p:19, l:0},
			{x:544 ,y:272 , p:26, l:2},//2级
			{x:608 ,y:304 , p:30, l:3},//3级			
		//5行	
			{x:96 ,y:112 , p:6, l:0},		
			{x:160 ,y:144, p:10, l:0},
			{x:224 ,y:176, p:12, l:0},
			
			{x:352 ,y:240 , p:18, l:0},
			{x:416 ,y:272 , p:0, l:0},
			{x:480 ,y:304 , p:27, l:2},//2级
			{x:544 ,y:336 , p:31, l:3}, //3级			
		//6行			
			{x:32  ,y:144, p:21, l:1},//1级						
			{x:96  ,y:176, p:22, l:1},//1级
			{x:160 ,y:208, p:23, l:1},//1级
			
			{x:288  ,y:272, p:20, l:1},//1级
			{x:352 ,y:304 , p:25, l:2},//2级
			{x:416 ,y:336 , p:24, l:2},//2级
			
			{x:0,y:270,p:10001,l:0},   //农场
			{x:600,y:25,p:10003,l:0},  // 采石场
			{x:810,y:51,p:10004,l:0},   // 矿场
			{x:860,y:180,p:10002,l:0},  // 伐木场
			
			{x:416,y:40,p:10000,l:0},   // 官府
			{x:0,y:145,p:20000,l:0}     // 城墙
		);
		
		
		public function TownShowObj()
		{
			setPositionDic();
		}

		public function getBuildPos(p:int):Point{
			return new Point(positionDic[p].x,positionDic[p].y);
		}
		
		public function getBuildBitData(bt:int):BitmapData{
 			var bitData:BitmapData;
 			switch(bt){
 				case BuildingConstant.TYPE_ACADEMY_BUILDING:
 					bitData = AniDataManager.instance.getAniBitmapData("building.academyNormal");
 				break;
 				case BuildingConstant.TYPE_AMPHITHEATRE:
 					bitData = AniDataManager.instance.getAniBitmapData("building.amphitheatreNormal");
 				break;
 				case BuildingConstant.TYPE_BARRACKS:
 					bitData = AniDataManager.instance.getAniBitmapData("building.barrackNormal");
 				break;
 				case BuildingConstant.TYPE_DAK:
 					bitData = AniDataManager.instance.getAniBitmapData("building.dakNormal");
 				break;
 				case BuildingConstant.TYPE_FARM:
 					bitData = AniDataManager.instance.getAniBitmapData("building.farm");
 				break;
 				case BuildingConstant.TYPE_HOUSE_BUILDING:
 					bitData = AniDataManager.instance.getAniBitmapData("building.houseNormal");
 				break;
 				case BuildingConstant.TYPE_MINE_IRON:
 					bitData = AniDataManager.instance.getAniBitmapData("building.ironMine");
 				break;
 				case BuildingConstant.TYPE_MARKET_BUILDING:
 					bitData = AniDataManager.instance.getAniBitmapData("building.marketNormal");
 				break;
 				case BuildingConstant.TYPE_MILITARY_INSTITUTE:
 					bitData = AniDataManager.instance.getAniBitmapData("building.militaryInstituteNormal");
 				break;
 				case BuildingConstant.TYPE_QUARRY:
 					bitData = AniDataManager.instance.getAniBitmapData("building.quarry");
 				break;
 				case BuildingConstant.TYPE_SAWMILL:
 					bitData = AniDataManager.instance.getAniBitmapData("building.sawmill");
 				break;
 				case BuildingConstant.TYPE_STABLES:
 					bitData = AniDataManager.instance.getAniBitmapData("building.stableNormal");
 				break;
 				case BuildingConstant.TYPE_TEMPLE:
 					bitData = AniDataManager.instance.getAniBitmapData("building.templeNormal");
 				break;
 				case BuildingConstant.TYPE_TOWN_HALLS:
 					bitData = AniDataManager.instance.getAniBitmapData("building.townHallNormal");
 				break;
 				case BuildingConstant.TYPE_TRAINNINGS:
 					bitData = AniDataManager.instance.getAniBitmapData("building.trainningFieldNormal");
 				break;
/*   				case BuildingConstant.TYPE_WALL_BUILDING:
// 					bitData = AniDataManager.instance.getAniBitmapData("");
 				break;  */
 				case BuildingConstant.TYPE_WAREHOUSES:
 					bitData = AniDataManager.instance.getAniBitmapData("building.wareHouseNormal");
 				break;
 				case BuildingConstant.TYPE_WORKSHOPS:
 					bitData = AniDataManager.instance.getAniBitmapData("building.workshopNormal");
 				break;
			} 
			return bitData;
		}
		
		private function setPositionDic():void{
			for each(var i:Object in positionArray){
				var p:int = i.p;
				positionDic[p] = i;
			}
		}
	}
}
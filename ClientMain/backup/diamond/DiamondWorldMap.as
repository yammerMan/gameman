package views.mainModules.map.diamond
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import mx.core.UIComponent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.FieldConstant;
	import roma.common.controller.common.MapInfo2Response;
	import roma.common.valueObject.SimpleMapCastleBean;
	import roma.data.MapTileData;
	import roma.logic.GameContext;
	import roma.message.MsgDispacther;
	import roma.message.events.MsgEvent;
	
	import views.mainModules.map.MapFieldInfoWin;
	import views.mainModules.map.MapGroundData;
	import views.mainModules.map.NewCastleWin;
	import views.mainModules.map.SelectedCirle;
	import views.spreadUI.tips.ToolTipContainer;
	import views.windows.functionWins.military.NewArmyWin;
	import views.windows.functionWins.military.NewScoutWin;

	public class DiamondWorldMap extends UIComponent
	{
		
		private static var log:ILogger = Log.getLogger("views.mainModules.map.DiamondWorldMap");


		public static var instance:DiamondWorldMap = new DiamondWorldMap();

		private var isShow:Boolean = false;
		
		// 半个单元格规格
		
		public static const SCENE_WIDTH:int = 994;
		public static const SCENE_HEIGHT:int = 400;
		
		private var startPoint:Point = new Point();
		private var stopPoint:Point = new Point();
		
		/** 按钮触发区，也是拖动区 */
		private var mapUIContainer:Sprite = new Sprite();
		                               
		/** 野地触发控件的数组 */
		private var tileFieldArr:Array = new Array(int(FieldConstant.CLIENT_VIEW_RADIUS * FieldConstant.CLIENT_VIEW_RADIUS /2 + 1));

		/** 屏幕缓冲区 */
		private var bitmapContainer:Bitmap = new Bitmap();
		
		private var isProcessingData:Boolean = true;
		
		private var curTile:DiamondMapTile;
		private var selectedCirle:SelectedCirle = new SelectedCirle();
		
		private var allTileMap:Dictionary = new Dictionary();
		
		private var debugText:TextField = new TextField();

		private var isStartDrag:Boolean = false;
		
		private var mapFieldInfoWin:MapFieldInfoWin = new MapFieldInfoWin();
		private var newCastleWin:NewCastleWin = new NewCastleWin();
		private var createArmyWin:NewArmyWin = new NewArmyWin();
		private var newScoutWin:NewScoutWin = new NewScoutWin();
		
		public function DiamondWorldMap()
		{
			super();
			this.width = SCENE_WIDTH;
			this.height = SCENE_HEIGHT;
			
			this.addChild(bitmapContainer);
			this.addChild(mapUIContainer);

			this.mapUIContainer.addChild(this.selectedCirle);
			this.selectedCirle.visible =false;

			this.createTile();
			
			this.mapUIContainer.addEventListener(MouseEvent.MOUSE_DOWN , onMapDown);
			this.mapUIContainer.addEventListener(Event.ENTER_FRAME,onMapEnterframe);
			
//			this.addChild(this.debugText);
			debugText.y = 100;
			debugText.textColor = 0xFF0000
			debugText.mouseEnabled = false;
			debugText.width = 300;
			
			this.closeAllFuncWin();
			
			this.addChild(this.mapFieldInfoWin);
			this.addChild(this.newCastleWin);
			this.addChild(this.createArmyWin);
			this.addChild(this.newScoutWin);
			
			this.createArmyWin.x = (this.width - this.createArmyWin.width)/2;
			this.createArmyWin.y = (this.height - this.createArmyWin.height)/2;
			
			this.newScoutWin.x = (this.width - this.newScoutWin.width)/2;
			this.newScoutWin.y = (this.height - this.newScoutWin.height)/2;
			
			
			var onCurCastleChange:Function = function(event:Event):void {
				setCenterToCurCastle();
			}
			MsgDispacther.instance.addEventListener(MsgDispacther.CUR_CASTLE_CHANGE_EVENT, onCurCastleChange);
			
			this.mapFieldInfoWin.addEventListener(MapFieldInfoWin.NEW_ARMY_EVENT , onNewArmy);
			this.mapFieldInfoWin.addEventListener(MapFieldInfoWin.NEW_SCOUT_EVENT , onNewScout);
			
			this.addMask();
		}

		private function addMask():void {
			var maskSpr:Sprite = new Sprite();
			maskSpr.graphics.beginFill(0,0);
			maskSpr.graphics.drawRect(0,0,SCENE_WIDTH,SCENE_HEIGHT);
			maskSpr.graphics.endFill();
			this.addChild(maskSpr);
			this.mask = maskSpr;
		}

		private function onNewScout(event:MsgEvent):void {
			this.closeAllFuncWin();
			this.newScoutWin.setMapTileData(MapTileData(event.data));
			this.newScoutWin.visible = true;
		}
		
		/**
		 * 军队出征时间
		 */
		private function onNewArmy(event:MsgEvent):void {
			this.closeAllFuncWin();
			this.createArmyWin.setMapTileData(MapTileData(event.data));
			this.createArmyWin.visible = true;
		}

		private function closeAllFuncWin() :void{
			this.createArmyWin.visible = false;
			this.mapFieldInfoWin.visible = false;
			this.newCastleWin.visible = false;
			this.newScoutWin.visible = false;
		}

		public function setCenterToCurCastle():void {
			if (this.isShow) {
				var idField:int = GameContext.instance.getPlayerObj().getCurCastleObj().idField;
				var curCastleX:int = idField / 10000;
				var curCastleY:int = idField % 10000;
				this.setCenterPoint(curCastleX,curCastleY);
				this.setOnShow(true);
			}
		}
	
		public function setOnShow(show:Boolean):void {
			this.isShow = show;
			this.closeAllFuncWin();
		}
	
		private function createTile():void {
			var mouseOverTile:Function = function(event:MouseEvent):void {
				var tile:DiamondMapTile = DiamondMapTile(event.target);
				ToolTipContainer.instance.worldMapTooltip.setTile(tile);
				ToolTipContainer.instance.worldMapTooltip.onMouseOver(event);

				selectedCirle.x = tile.x;
				selectedCirle.y = tile.y;
				selectedCirle.setMapTile(tile);
				selectedCirle.visible = true;

			}
			var mouseOutTile:Function = function(event:MouseEvent):void {
				ToolTipContainer.instance.worldMapTooltip.onMouseOut();
				selectedCirle.visible = false;				
			}
			var mouseMoveTile:Function = function(event:MouseEvent):void {
				ToolTipContainer.instance.worldMapTooltip.onMouseMove(event);
			}
			var mouseUpTile:Function = function(event:MouseEvent):void {
				curTile = event.target as DiamondMapTile;
			}
			
			for (var i:int=0; i<this.tileFieldArr.length; i++) {
				var tile:DiamondMapTile = new DiamondMapTile();
				tile.addEventListener(MouseEvent.MOUSE_OVER, mouseOverTile);
				tile.addEventListener(MouseEvent.MOUSE_OUT, mouseOutTile);
				tile.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveTile);
				tile.addEventListener(MouseEvent.MOUSE_UP, mouseUpTile);
				
				this.tileFieldArr[i] = tile;
				this.mapUIContainer.addChild(tile);
			}
		}
		
		private var skipFrame:Boolean = false;
		private function onMapEnterframe(event:Event):void{
			this.skipFrame = !this.skipFrame;
			if (skipFrame) {
				return;
			}
			
			if (!this.isShow || this.isProcessingData) {
				return;
			}

			var scene:BitmapData = new BitmapData(SCENE_WIDTH , SCENE_HEIGHT, false, 0);
			var i:int;

			this.drawGround(scene);
			
			for (i=0; i<this.tileFieldArr.length; i++) {
				DiamondMapTile(this.tileFieldArr[i]).drawToScene(scene, this.mapUIContainer);
			}

			var old:BitmapData = this.bitmapContainer.bitmapData;
			this.bitmapContainer.bitmapData = scene;			
			if (old!=null){
				old.dispose();
			}
		}

		private function drawGround(scene:BitmapData):void {
			var ix:int = this.mapUIContainer.x % MapGroundData.GROUND_WIDTH;
			if (ix>0) {
				ix = ix - MapGroundData.GROUND_WIDTH;
			}
			
			var groundX:int = this.mapUIContainer.x /  MapGroundData.GROUND_WIDTH; 
			var jo:int = groundX & 1 ;
			
			if (this.mapUIContainer.x>0) {
				jo = (jo + 1)&1;
			}
			
//			this.debugText.text = StringUtil.substitute("ix={0} ,groundX={1}  jo={2}" , ix, groundX, jo);
			
			for (var j:int= ix ; j< SCENE_WIDTH; j+= MapGroundData.GROUND_WIDTH) {
				
				var i:int;
				if (jo==0) {
					i= this.mapUIContainer.y  % MapGroundData.GROUND_HEIGHT;
					jo = 1;
				} else {
					i = (this.mapUIContainer.y - MapGroundData.GROUND_HEIGHT/2) % MapGroundData.GROUND_HEIGHT ;
					jo = 0;
				}
				if (i>0)  {
					i -= MapGroundData.GROUND_HEIGHT;
				}

				for ( ; i< SCENE_HEIGHT; i+= MapGroundData.GROUND_HEIGHT) {
					scene.copyPixels(MapGroundData.instance.groundData,	MapGroundData.GROUND_RECT,new Point(j,i));	
				}
			}
		}

		private function onMapDown(event:MouseEvent):void {
			log.debug("onMapDown");
			
			this.closeAllFuncWin();
			
			mapUIContainer.startDrag();
			this.startPoint.x = mapUIContainer.x;
			this.startPoint.y = mapUIContainer.y;
			this.isStartDrag = true;
			stage.addEventListener(MouseEvent.MOUSE_UP,onMapUp);
//			this.addEventListener(MouseEvent.MOUSE_UP , onMapUp);
		}
		
		private function onMapUp(event:MouseEvent):void {
			if (this.isStartDrag) {
				this.isStartDrag = false;
				mapUIContainer.stopDrag();
				stage.removeEventListener(MouseEvent.MOUSE_UP,onMapUp);
				var move:int = Math.abs(this.startPoint.x - mapUIContainer.x) + Math.abs(this.startPoint.y - mapUIContainer.y);
				
				if (move<20) {
					this.onMapClick(event);
				} else {
					this.sendCommandToServer();
				}
			}
		}
		
		private function onMapClick(event:MouseEvent):void {
			this.closeAllFuncWin();
			
			if (this.curTile!=null) {
				var tx:int = this.curTile.x + this.mapUIContainer.x;
				var ty:int = this.curTile.y + this.mapUIContainer.y
				
				log.debug("onMapClick at [{0},{1}], tileX={2} , tileY={3}" , curTile.getFieldX() , curTile.getFieldY() , tx , ty);
				
				var winX:int = tx + DiamondMapTile.TILE_WIDTH_HALF * 2 + 10;
				if (tx>500) {
					winX = tx - 290 - 10;
				}
				
				var winY:int = ty;
				if (ty > 170) {
					winY =  170;
				} else if (ty < 10) {
					winY = 10;
				}

				if (this.curTile.getFieldType() == FieldConstant.FLAT_TYPE ) {
					this.newCastleWin.x = winX;
					this.newCastleWin.y = winY;
					this.newCastleWin.setMapTile(this.curTile);
					this.newCastleWin.visible = true;
					
				} else {
					var bData:BitmapData = new BitmapData(100,100,false);
					bData.copyPixels(this.bitmapContainer.bitmapData,new Rectangle(tx+14,ty-18,100,100), new Point(0,0));
					
					this.mapFieldInfoWin.x = winX;
					this.mapFieldInfoWin.y = winY;
					this.mapFieldInfoWin.setMapTile(this.curTile);
					this.mapFieldInfoWin.visible = true;
				}
			}
		}
		
		/**
		 * 设置地图中心点，由中心点确定地图位置
		 */ 
		public function setCenterPoint(cx:int,cy:int):void{
			this.mapUIContainer.x = (cx -7 - cy) * - DiamondMapTile.TILE_WIDTH_HALF;
			this.mapUIContainer.y = (cx -7 + cy) * - DiamondMapTile.TILE_HEIGHT_HALF;
			this.sendCommandToServer();
		}
		
		public function sendCommandToServer():void {
			
			var ix:int = - this.mapUIContainer.x / DiamondMapTile.TILE_WIDTH_HALF;
			var iy:int = - this.mapUIContainer.y / DiamondMapTile.TILE_HEIGHT_HALF;
			
			var centerPointX:int = (ix+iy)/2 + 7;
			var centerPointY:int = (iy-ix)/2;
			log.debug("sendCommandToServer({0},{1})" , centerPointX , centerPointY);
			ControllerFactory.getInstance().getCommonController().mapDesc2(
				centerPointX , centerPointY,
				onServerResponse,
				false);
		}
		
		private function processRepeatTile(event:MapInfo2Response):Dictionary {
			var newAllTileMap:Dictionary = new Dictionary();
			//先把重复的都处理了
			var repeatCount:int = 0;
			var arrayIndex:int = 0;
			var index:int = 0;
			for (var ly:int = 0; ly < FieldConstant.CLIENT_VIEW_RADIUS; ly++) {
				var offset:int = ly;
				if (offset * 2 > FieldConstant.CLIENT_VIEW_RADIUS) {
					offset = FieldConstant.CLIENT_VIEW_RADIUS - ly - 1;
				}
				for (var lx:int = -offset; lx <= offset; lx++) {
					var mapX:int = event.x + lx;
					var mapY:int = event.y - FieldConstant.CLIENT_VIEW_RADIUS/2 + ly +1;
					
					var idField:int = GameContext.getFieldId(mapX, mapY);
					
					var tile:DiamondMapTile = DiamondMapTile(allTileMap[idField]);
					if (tile != null) {
						//如果是重复的
						var fieldType:int = event.mapStr.charCodeAt(index) - 48;
						var level:int = event.mapStr.charCodeAt(index +1) - 48;
						tile.setData(mapX, mapY, fieldType , level);//将数据设进去
						repeatCount++;
						newAllTileMap[tile.idField] = tile;
					}
					index +=2;
				}
			}
			log.debug("新的地图数据中有{0}个和原来的重复", repeatCount);
			return newAllTileMap;			
		}
		
		private function onServerResponse(event:MapInfo2Response):void {
			log.debug("mapUIContainer ({0},{1})" , this.mapUIContainer.x , this.mapUIContainer.y);
			this.isProcessingData = true;
			
			
			for each (tile in this.tileFieldArr) {
				tile.hasData = false;
			} 

			var newAllTileMap:Dictionary = processRepeatTile(event);

			var tile:DiamondMapTile;
			var index:int = 0;
			var arrayIndex:int=0;
			for (var ly:int = 0; ly < FieldConstant.CLIENT_VIEW_RADIUS; ly++) {
				var offset:int = ly;
				if (offset * 2 > FieldConstant.CLIENT_VIEW_RADIUS) {
					offset = FieldConstant.CLIENT_VIEW_RADIUS - ly - 1;
				}
				for (var lx:int = -offset; lx <= offset; lx++) {
					
					var mapX:int = event.x + lx;
					var mapY:int = event.y - FieldConstant.CLIENT_VIEW_RADIUS/2 + ly + 1;
					
					var idField:int = GameContext.getFieldId(mapX, mapY);
					
					if (newAllTileMap[idField]==null) {
						//如果是没有处理的
						for (;arrayIndex < this.tileFieldArr.length; arrayIndex++) {
							//寻找一个空闲的
							tile = DiamondMapTile(this.tileFieldArr[arrayIndex]);
							if (!tile.hasData) {
								//找到后就设新的数据进去
								var fieldType:int = event.mapStr.charCodeAt(index) - 48;
								var level:int = event.mapStr.charCodeAt(index +1) - 48;
								tile.setData(mapX, mapY, fieldType , level);//将数据设进去
								newAllTileMap[idField] = tile;
								
								arrayIndex++;
								break;
							}
						} 
					}
					index +=2;
				}
			}
			
			for each (var bean:SimpleMapCastleBean in event.mapCastlesArray) {
				//将城堡的数据设进去
				var t2:DiamondMapTile = DiamondMapTile(newAllTileMap[bean.idField]);
				if (t2!=null) { 
					t2.setMapCityBean(bean);
				} else {
					log.debug(bean.idField + "不应该为空");
				}
			}
			
			this.tileFieldArr.sort(sortOnMapId);
			this.allTileMap = newAllTileMap;
			
			this.isProcessingData = false;
		}

		private function sortOnMapId(a:DiamondMapTile , b:DiamondMapTile):Number {
			return a.mapId - b.mapId;
		}
	}
}
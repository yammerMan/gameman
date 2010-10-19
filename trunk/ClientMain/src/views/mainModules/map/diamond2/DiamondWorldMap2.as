package views.mainModules.map.diamond2
{
	import animation.AniPlayer;
	import animation.AnimationManager;
	import animation.IAniPlayer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.FieldConstant;
	import roma.common.controller.army.FreshBattleFieldResponse;
	import roma.common.controller.common.MapDataResponse;
	import roma.common.valueObject.FieldBattleInfoBean;
	import roma.common.valueObject.SimpleMapCastleBean;
	import roma.data.MapTileData;
	import roma.logic.GameContext;
	import roma.logic.object.field.BaseField;
	import roma.logic.object.player.ConquestObj;
	import roma.message.EvtDispacther;
	import roma.message.events.MsgEvent;
	import roma.message.events.PublicEvent;
	import roma.util.FiltersUtil;
	
	import views.BeginnerGuide;
	import views.MainContainer;
	import views.mainFrame.ToggleButton;
	import views.mainModules.map.CastleInfoWin;
	import views.mainModules.map.IMapTile;
	import views.mainModules.map.MapFieldInfoWin;
	import views.mainModules.map.MapGroundData;
	import views.mainModules.map.NewCastleWin;
	import views.mainModules.map.TrainingRoomWin;
	import views.mainModules.map.smallMap.NpcFieldConstant;
	import views.spreadUI.castleIcon.CastleIconPanel;
	import views.spreadUI.favorite.FieldSkip;
	import views.spreadUI.tips.CastleInfoTooltip;
	import views.spreadUI.tips.FieldInfoToolTip;
	import views.spreadUI.tips.ToolTipContainer;
	import views.windows.functionWins.diplomacy.VassalMesWin;
	import views.windows.functionWins.military.NewScoutWin;

	public class DiamondWorldMap2 extends Canvas
	{
		private static var log:ILogger = Log.getLogger("views.mainModules.map.DiamondWorldMap");

		public static const TILE_WIDTH:int = 128;
		public static const TILE_HEIGHT:int = 64;
		public static const SCENE_WIDTH:int = 994;
		public static const SCENE_HEIGHT:int = 400;
		public static const VIEW_RANGE:int = 19;
		public static const MAP_MOVE_SPEED:Number = 1.5;

		public static var instance:DiamondWorldMap2 = new DiamondWorldMap2();
		
		private var isShow:Boolean = false;

		private var startPoint:Point = new Point();
		private var stopPoint:Point = new Point();
		
		/** 按钮触发区，也是拖动区 */
		private var mapUIContainer:Sprite = new Sprite();
		
		/** 屏幕缓冲区 */
		private var bitmapContainer:Bitmap = new Bitmap();
		
		/** 是否正在拖拽中 */
		private var isStartDrag:Boolean = false;

		[Embed(source="DragCursor.png")] 
		private var cursorClazz:Class;
		private var cursorId:int = -1;

		public var targetField:int;

		private var fieldSkipUI:FieldSkip;
		
		/** 测试 */
		private var debugText:TextField = new TextField();
		
		/** 鼠标位置*/
		private var selectedCirle:SelectedCirle = new SelectedCirle();

		/** 拖动时，缓动的效果 */
		private var sin:Number = 0;
		private var cos:Number = 0;
		private var lastTime:int = getTimer();
		private var lastPoint:Point = new Point();
		private var moveSpeed:Number = 0;
		private var frame:int = 0;
		private var isMoving:Boolean = false;		
		private var moveingAcc:Number = 1.5;
		public var mapFieldInfoWin:MapFieldInfoWin = new MapFieldInfoWin();
		
		private var newCastleWin:NewCastleWin = new NewCastleWin();
		private var newScoutWin:NewScoutWin = new NewScoutWin();

		private var cloudArray:Array = new Array();

		private var curCastlePlayer:IAniPlayer = new AniPlayer(AnimationManager.curCastleAni , 55 , -32);
		
		private var castleInfoTooltip:CastleInfoTooltip = ToolTipContainer.instance.castleInfoTooltip;
		private var fieldInfoTooltip:FieldInfoToolTip = ToolTipContainer.instance.fieldInfoTooltip;

		public function DiamondWorldMap2()
		{
			super();

			this.width = SCENE_WIDTH;
			this.height = SCENE_HEIGHT;
			
			//this.addChild(mapUIContainer);

			this.bitmapContainer.bitmapData = new BitmapData(SCENE_WIDTH , SCENE_HEIGHT, false, 0)
			var uc:UIComponent = new UIComponent();
			uc.addChild(this.bitmapContainer);
			uc.addChild(this.mapUIContainer);
			this.addChild(uc);
			
			uc.addEventListener(MouseEvent.MOUSE_DOWN , onMapDown);
			uc.addEventListener(MouseEvent.MOUSE_UP , onMapUp);
			uc.addEventListener(Event.ENTER_FRAME,onMapEnterframe);
			
			uc.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			uc.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			uc.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
			
			this.closeAllFuncWin();
			this.initFieldSkipUI();
			
			this.mapFieldInfoWin.x = (SCENE_WIDTH-this.mapFieldInfoWin.width)/2;
			this.mapFieldInfoWin.y = (SCENE_HEIGHT-this.mapFieldInfoWin.height)/2;
			this.newCastleWin.x = (SCENE_WIDTH-this.newCastleWin.width)/2;
			this.newCastleWin.y = (SCENE_HEIGHT-this.newCastleWin.height)/2;
			
			this.addChild(this.mapFieldInfoWin);
			this.addChild(this.newCastleWin);
			this.addChild(this.newScoutWin);
			
			this.newScoutWin.x = (this.width - this.newScoutWin.width)/2;
			this.newScoutWin.y = (this.height - this.newScoutWin.height)/2;
			
			EvtDispacther.instance.addEventListener(MapFieldInfoWin.NEW_SCOUT_EVENT , onNewScout);
			
			this.initDebugText();
			this.initCloud();
			this.addMask();
			
			function onCurCastleChange(event:Event):void {
				setCenterToCurCastle();
			}
			EvtDispacther.instance.addEventListener(EvtDispacther.CUR_CASTLE_CHANGE_EVENT, onCurCastleChange);
			EvtDispacther.instance.addEventListener(BeginnerGuide.OPEN_MAPFIELD_WIN,onOpenMapFieldWin); 

		}

		private function initFieldSkipUI():void{
			this.fieldSkipUI = FieldSkip.instance;
			this.fieldSkipUI.x = 335;
			this.fieldSkipUI.y = 370;
			this.addChild(this.fieldSkipUI);
		}
		
		private function initCloud():void {
			this.cloudArray.push(new CloudInMap(0,0,0.5,0));
			this.cloudArray.push(new CloudInMap(300 , 150, 1,0));
			this.cloudArray.push(new CloudInMap(200 , 300, 0.7,0));
		}

		private function onNewScout(event:MsgEvent):void {
			this.closeAllFuncWin();
			this.newScoutWin.setMapTileData(MapTileData(event.data));
			this.newScoutWin.visible = true;
		}
		
		private function initDebugText():void {
//			this.addChild(this.debugText);
			debugText.y = 0;
			debugText.textColor = 0xFFffff
			debugText.mouseEnabled = false;
			debugText.width = 300;
			debugText.filters = [FiltersUtil.glowFilter];
		}
		
		private function addMask():void {
			var maskSpr:UIComponent = new UIComponent();
			maskSpr.graphics.beginFill(0,0);
			maskSpr.graphics.drawRect(0,0,SCENE_WIDTH,SCENE_HEIGHT);
			maskSpr.graphics.endFill();
			this.addChild(maskSpr);
			this.mask = maskSpr;
		}
		
		public function removeCursorId():void{
			if (this.cursorId>0) {
				this.cursorManager.removeCursor(this.cursorId);
				this.cursorId = -1;
			}
		}
		
		private function onMapDown(event:MouseEvent):void {
			if(ToggleButton.instance.isTown){
				return;
			}
			
			if (this.isStartDrag) {
				//在某些情况下，mouseUp事件会监听不到
				this.onMapUp(event);
				return;
			}
			
			if (this.cursorId<0) {
				this.cursorId = this.cursorManager.setCursor(this.cursorClazz,0);
			}
			
			this.closeAllFuncWin();
			
			mapUIContainer.startDrag();
			this.startPoint.x = mapUIContainer.x;
			this.startPoint.y = mapUIContainer.y;
			this.isStartDrag = true;
			this.setLastPoint();
			//this.setLastPoint();
		}
		
		private function onMapUp(event:MouseEvent):void {
			if(ToggleButton.instance.isTown){
				return;
			}
			
			this.removeCursorId();

			if (this.isStartDrag) {
				this.setLastPoint();
				this.isStartDrag = false;
				mapUIContainer.stopDrag();
				var move:int = Math.abs(this.startPoint.x - mapUIContainer.x) + Math.abs(this.startPoint.y - mapUIContainer.y);
				
				if (move<20) {
					this.onMapClick(event);
				} else {
					this.isMoving = true;
					this.moveingAcc = MAP_MOVE_SPEED; 
				}
			}
		}

		private function onMouseOver(event:MouseEvent):void{
			if(ToggleButton.instance.isTown){
				return;
			}

			if (!this.isMoving) {
				var th:TileHelper = TileHelper.calc(this.mapUIContainer,this.contentMouseX,this.contentMouseY);
				var tile:DiamondMapTile2 = MapDataByteArray.instance.getTileObj(th.fieldX,th.fieldY);
				var idField:int =GameContext.instance.getPlayerObj().getCurCastleObj().idField;
				if(tile !=null && tile.getFieldType() == FieldConstant.TYPE_CITY){
					this.castleInfoTooltip.setMapTile(tile);
					this.castleInfoTooltip.onMouseOver(event);
				}else{
					if(tile ==null){
						this.fieldInfoTooltip.setTile(th.fieldX,th.fieldY);
					}else{
						this.fieldInfoTooltip.setMapTile(tile);
					}
					this.fieldInfoTooltip.onMouseOver(event);
				}
			}
		}
		
		private function onMouseMove(event:MouseEvent):void{
			if(ToggleButton.instance.isTown){
				return;
			}
			
			if (!this.isMoving) {
				var th:TileHelper = TileHelper.calc(this.mapUIContainer,this.contentMouseX,this.contentMouseY);
				var tile:DiamondMapTile2 = MapDataByteArray.instance.getTileObj(th.fieldX,th.fieldY);
								
				if(tile !=null && tile.getFieldType() == FieldConstant.TYPE_CITY){
					this.castleInfoTooltip.setMapTile(tile);
					this.castleInfoTooltip.onMouseOver(event);
					this.castleInfoTooltip.onMouseMove(event);
					this.fieldInfoTooltip.onMouseOut();
				}else{
					if(tile ==null){
						this.fieldInfoTooltip.setTile(th.fieldX,th.fieldY);
					}else{
						this.fieldInfoTooltip.setMapTile(tile);
					}
					this.fieldInfoTooltip.onMouseOver(event);
					this.fieldInfoTooltip.onMouseMove(event);
					this.castleInfoTooltip.onMouseOut();
				}
			}
		}
		
		private function onMouseOut(event:MouseEvent):void{
			if(castleInfoTooltip.getVisible())this.castleInfoTooltip.onMouseOut();
			if(fieldInfoTooltip.getVisible())this.fieldInfoTooltip.onMouseOut();
		}
		
		/**
		 * 设置地图的中心点
		 */
		public function setCenterPoint(cx:int,cy:int):void{
			var x2:int = cx-7;
			this.mapUIContainer.x = (x2 - cy) * - TILE_WIDTH / 2 ;
			this.mapUIContainer.y = (x2 + cy) * - TILE_HEIGHT /2 - 50;
			this.sendCommandToServer();
		}
		
		public function sendCommandToServer():void {
			var th:TileHelper = TileHelper.calc(this.mapUIContainer,SCENE_WIDTH/2,SCENE_HEIGHT/2);
			var centerPointX:int = th.tileX ;
			var centerPointY:int = th.tileY;
			log.debug("中心点 ({0},{1})" , centerPointX , centerPointY);
			ControllerFactory.getInstance().getCommonController().mapDesc(
				centerPointX , centerPointY,
				onServerResponse,
				false);
		}

		private function setLastPoint():void {
			var speedTime:int = getTimer() - lastTime;
			if (speedTime >0) {
				var sx:Number = this.mapUIContainer.x - lastPoint.x;
				var sy:Number = this.mapUIContainer.y - lastPoint.y;
				var s1:Number = Math.sqrt(sx * sx + sy*sy);//计算对角线的长度
				this.moveSpeed = s1 * 500 / speedTime / this.stage.frameRate;
				if (this.moveSpeed> 120) {
					this.moveSpeed = 120;
				}
				
				var angle:Number = Math.atan2(sx,sy);
				this.sin = Math.sin(angle);
				this.cos = Math.cos(angle);
			} else {
				this.moveSpeed = 0;
			}
			
			lastPoint.x = this.mapUIContainer.x;
			lastPoint.y = this.mapUIContainer.y;
			this.frame = 0;
			this.lastTime = getTimer();
			
//			this.debugText.text = "v:" + this.moveSpeed;
		}
		
		private function onMapEnterframe(event:Event):void{
			if (!this.isShow ) {
				return;
			}
			
			var th:TileHelper;
			if((this.contentMouseX>=300 && this.contentMouseX<= 700 && this.contentMouseY>=368) 
			|| (this.contentMouseX>=750 && this.contentMouseX<= 970 && this.contentMouseY>=375) 
			||(this.contentMouseX>=920 && this.contentMouseY>=365-(CastleIconPanel.instance.height+35) && this.contentMouseY<=365) 
			||(this.contentMouseX>=0 && this.contentMouseX<= MainContainer.instance.buffStatusInfoWin.getAllBufWindth() && this.contentMouseY<=35)){
				th= TileHelper.calc(this.mapUIContainer,-100, -100);
			}else{
				th= TileHelper.calc(this.mapUIContainer,this.contentMouseX , this.contentMouseY);
			}
			
//			this.debugText.text = th.debugStr;
			
			frame ++;
			if(this.stage!=null){
				if (frame == this.stage.frameRate/2) {
					frame = 0;
				}
			}
			
			if (this.isStartDrag) {
				if (!th.mouseInContext) {
					this.onMapUp(null);
					return;
				}
				
				if (frame==0) {
					this.setLastPoint();
				}
			} else {
				if (this.isMoving) {
					if (this.moveSpeed>0) {
						this.mapUIContainer.x += this.moveSpeed * this.sin;
						this.mapUIContainer.y += this.moveSpeed * this.cos;
						this.moveSpeed -= this.moveingAcc;
						
						if(this.castleInfoTooltip.getVisible())this.castleInfoTooltip.onMouseOut();
						if(this.fieldInfoTooltip.getVisible())this.fieldInfoTooltip.onMouseOut();
					} else {
						this.isMoving = false;
						this.sendCommandToServer();
					}
				}
			}
			
			var scene:BitmapData = this.bitmapContainer.bitmapData;
			scene.lock();
			var i:int;

			this.drawGround(scene);
			this.drawField(scene);
			this.drawSelectedCirle(scene , th.tileX , th.tileY);

			for each (var cloud:CloudInMap in this.cloudArray) {
				cloud.drawToScene(scene , this.mapUIContainer);
			}
			
			scene.unlock();
			
//			var old:BitmapData = this.bitmapContainer.bitmapData;
//			this.bitmapContainer.bitmapData = scene;			
//			if (old!=null){
//				old.dispose();
//			}
		}

		/**
		 * 画选择框
		 */
		private function drawSelectedCirle(scene:BitmapData, tx:int , ty:int):void {
			if (!this.isMoving) {
				var tile:DiamondMapTile2 = MapDataByteArray.instance.getTileObj(tx,ty);
				var level:int = 0;
				if (tile != null) {
					level = tile.fieldLevel
				}
				this.selectedCirle.setData(tx,ty,level);
				this.selectedCirle.drawToScene(scene , this.mapUIContainer);
			}			
		}

		/**
		 * 画地形
		 */
		private function drawField(scene:BitmapData):void {
			var th:TileHelper = TileHelper.calc(this.mapUIContainer,0,0);
			
			for (var ly:int = 0; ly < VIEW_RANGE; ly++) {
				var offset:int = ly;
				if (offset > VIEW_RANGE/2) {
					offset = VIEW_RANGE - ly ;
				}
				var mapY:int = th.tileY - VIEW_RANGE/2 + ly ;

				for (var lx:int = -offset; lx <= offset; lx++) {

					var mapX:int = th.tileX + lx + VIEW_RANGE/2 -1;
					
					var idField:int = GameContext.getFieldId(mapX,mapY);
				
					var tile:DiamondMapTile2 = MapDataByteArray.instance.getTileObj(mapX,mapY);

					if (tile != null) {
						tile.drawToScene(scene, this.mapUIContainer,mapX , mapY);
					}
					
					//定位三角动画 
					if(this.targetField == idField){
						var ox:int = (mapX - mapY) * (DiamondWorldMap2.TILE_WIDTH/2)  + this.mapUIContainer.x ;
						var oy:int = (mapX + mapY) * (DiamondWorldMap2.TILE_HEIGHT/2)  + this.mapUIContainer.y ;
						curCastlePlayer.gotoAndPlay(scene,ox,oy);
					}
				}
			}
		}

		/**
		 * 画地板
		 */
		private function drawGround(scene:BitmapData):void {
			var ix:int = this.mapUIContainer.x % MapGroundData.GROUND_WIDTH;
			if (ix>0) {
				ix = ix - MapGroundData.GROUND_WIDTH;
			}
			if (ix==0&&this.mapUIContainer.x>0) {
				ix = ix - MapGroundData.GROUND_WIDTH;
			}
			
			var groundX:int = this.mapUIContainer.x /  MapGroundData.GROUND_WIDTH; 
			var jo:int = groundX & 1 ;
			
			if (this.mapUIContainer.x>0) {
				jo = (jo + 1)&1;
			}
			
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

		public function setOnShow(show:Boolean):void {
			this.isShow = show;
			this.closeAllFuncWin();
			this.isMoving = false;
		}

		/**
		 * 将中心点设置到当前城堡
		 */
		public function setCenterToCurCastle():void {
			if (this.isShow) {
				var idField:int = GameContext.instance.getPlayerObj().getCurCastleObj().idField;
				var curCastleX:int = idField / 10000;
				var curCastleY:int = idField % 10000;
				this.setCenterPoint(curCastleX,curCastleY);
				this.targetField = idField;
				this.setOnShow(true);
			}
		}

		/**
		 * 关闭所有的窗口
		 */
		private function closeAllFuncWin():void {
			this.mapFieldInfoWin.visible = false;
			this.newCastleWin.visible = false;
			this.newScoutWin.visible = false;
		}
		
		private function onOpenMapFieldWin(event:PublicEvent):void{
			var idField:int = FreshBattleFieldResponse(event.evtData).fieldId;
			var fx:int = idField/10000;
			var fy:int =idField%10000; 
			var tile:DiamondMapTile2 = MapDataByteArray.instance.getTileObj(fx,fy);
			this.mapFieldInfoWin.setMapTile(tile);
			this.mapFieldInfoWin.visible = true;	
		}	

		private function onMapClick(event:MouseEvent):void {
			this.closeAllFuncWin();

			var th:TileHelper = TileHelper.calc(this.mapUIContainer,this.contentMouseX,this.contentMouseY);
			
			var tile:DiamondMapTile2 = MapDataByteArray.instance.getTileObj(th.fieldX,th.fieldY);
			
			FieldSkip.instance.setCoordinate(th.fieldX,th.fieldY);

			if (tile ==null) {
				this.newCastleWin.setMapTile(th.fieldX,th.fieldY);
				this.newCastleWin.visible = true; 
				
			} else {
				if(isMyCastle(tile) || isMyField(tile)){
					EvtDispacther.instance.eventDispatch(CastleInfoWin.WINDOW_SHOW,tile);
				}else if(isMyConquestCity(tile)){
					EvtDispacther.instance.eventDispatch(VassalMesWin.WINDOW_SHOW,getConquestCityBean(tile));
				}else if(tile.fieldType==FieldConstant.TYPE_NPC_FIELD||tile.fieldType==NpcFieldConstant.TYPE_RATTER_NPC_FIELD){
					EvtDispacther.instance.eventDispatch(TrainingRoomWin.WINDOW_SHOW,tile);
				}else{
					this.mapFieldInfoWin.setMapTile(tile);
					this.mapFieldInfoWin.visible = true;	
				}
			}
		}
		
		/**
		*检查是否为自己的城堡
		*/
		private function isMyCastle(bean:IMapTile):Boolean{
			var yours:Boolean=false;
			var c:SimpleMapCastleBean = bean.getMapCityBean();
			if(bean.getFieldType()==FieldConstant.TYPE_CITY && c!=null){
				if(GameContext.instance.getPlayerObj().getPlayerInfo().playerName==c.playerName){
					yours=true;
				}
			}
			return yours;
		}
		
		/**
		*检查是否为自己的野地
		*/
		private function isMyField(bean:DiamondMapTile2):Boolean{
			var yours:Boolean=false;
			if(bean.getFieldType()!=FieldConstant.TYPE_CITY){
				var allField:ArrayCollection=GameContext.getAllField();
				if(allField.length>0){
					for each(var baseField:BaseField in allField){
						if(bean.idField==baseField.idField){
							yours=true;
						}
					}
				}
			}
			return yours;
		}
		
		/**
		*检查是否为自己的附庸城
		*/
		private function isMyConquestCity(bean:IMapTile):Boolean{
			var yours:Boolean=false;
			if(bean.getFieldType()==FieldConstant.TYPE_CITY){
				var allConquestCity:ArrayCollection=GameContext.getAllConquestCity();
				if(allConquestCity.length>0){
					for each(var relatedCastleTimeBean:ConquestObj in allConquestCity){
						if(bean.getMapCityBean().fieldId==relatedCastleTimeBean.relatedCityBean.castle.fieldId){
							yours=true;
						}
					}
				}
			}
			return yours;
		}
		/**
		*获取所选附庸城资料
		*/
		private function getConquestCityBean(bean:IMapTile):ConquestObj{
			var relatedCastle:ConquestObj;
			var allConquestCity:ArrayCollection=GameContext.getAllConquestCity();
			for each(var relatedCastleTimeBean:ConquestObj in allConquestCity){
				if(bean.getMapCityBean().fieldId==relatedCastleTimeBean.relatedCityBean.castle.fieldId){
					relatedCastle=relatedCastleTimeBean;
				}
			}
			return relatedCastle;

		}
		
		private function onServerResponse(event:MapDataResponse):void {
			var halfRadius:int = FieldConstant.CLIENT_VIEW_RADIUS /2 ;
			var repeatCount:int = 0;
			var index:int = 0;
			
			var castleBeanMap:Dictionary = new Dictionary();
			for each (var bean:SimpleMapCastleBean in event.mapCastlesArray) {
				//将城堡的数据设进去
				MapDataByteArray.instance.addCastle(bean);
				castleBeanMap[bean.fieldId] = "Y";
			}
				
			for (var ly:int = 0; ly < FieldConstant.CLIENT_VIEW_RADIUS; ly++) {
				var offset:int = ly;
				if (offset > halfRadius) {
					offset = FieldConstant.CLIENT_VIEW_RADIUS - ly - 1;
				}
				var mapY:int = event.y - halfRadius + ly ;

				for (var lx:int = -offset; lx <= offset; lx++) {

					var level:int = event.mapStr.charCodeAt(index) - 48;
					index ++;

					var mapX:int = event.x + lx;
					
					var tile:DiamondMapTile2 = MapDataByteArray.instance.getTileObj(mapX,mapY);

					if (tile != null) {
						tile.isInBattle = false;

						if (tile.fieldType == FieldConstant.TYPE_CITY && castleBeanMap[tile.idField]==null) {
							MapDataByteArray.instance.cleanCastle(tile.idField);
						} else {
							tile.setLevelData(level);
						}
					}
				}
			}
			
			for each(var b:FieldBattleInfoBean in event.fieldBattlesArray){
				MapDataByteArray.instance.addInBattle(b);
			}
		}

		public function goPoint(cx:int, cy:int):void {
			var th:TileHelper = TileHelper.calc(this.mapUIContainer , SCENE_WIDTH/2 , SCENE_HEIGHT/2);

			var dx:int = calcGoPoint(TileHelper.tranTileXY2FieldXY(cx) - th.fieldX );
			var dy:int = calcGoPoint(TileHelper.tranTileXY2FieldXY(cy) - th.fieldY );

			var tx:int = (dx - dy)* TILE_WIDTH  / 2;
			var ty:int = (dx + dy)* TILE_HEIGHT / 2;
			
			var dist:Number = Point.distance(new Point(0,0), new Point(tx,ty)); 
			
			var time:int = this.stage.frameRate * 3;
			
			this.moveSpeed = dist * 2 / time;
			this.moveingAcc = this.moveSpeed / time;
			
			if (this.moveingAcc < 0.8) {
				this.moveingAcc = 0.8;
				this.moveSpeed = Math.sqrt(2 * 0.8 * dist);
			}

			var angle:Number = Math.atan2(-tx , -ty);
			this.sin = Math.sin(angle);
			this.cos = Math.cos(angle);

			this.targetField = TileHelper.calcFieldID(cx,cy);

			this.isMoving = true;
			
			//this.debugText.text = StringUtil.substitute("dist:{0}\nspeed:{1}\nacc:{2}\n{3},{4}", dist , this.moveSpeed , this.moveingAcc,dx,dy);
		}
		
		private function calcGoPoint(value:int):int {
			if (Math.abs(value) > FieldConstant.MAP_SIZE/2) {
				if (value>0) {
					return - (FieldConstant.MAP_SIZE - value);
				} else {
					return FieldConstant.MAP_SIZE + value;
				}
			} else {
				return value;
			}
		}
	}
}
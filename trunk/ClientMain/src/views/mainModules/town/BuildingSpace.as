package views.mainModules.town
{
	import animation.AniPlayer;
	import animation.AnimationManager;
	import animation.IAniPlayer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	
	import views.PopupWindows;

	public class BuildingSpace extends UIComponent
	{
		
		private static var log:ILogger = Log.getLogger("views.mainModules.BuildingSpace");
		
		private static const SPACE_GAP:int = 2;
		
		private static const SPACE_WIDTH:int = 128;
		private static const SPACE_HEIGHT:int = 96;
		
		private var freeSpaceAniPlayer:IAniPlayer = new AniPlayer(AnimationManager.freeBuildingSpace, 0,32);
		
		protected var town:Town;
		protected var scene:Bitmap = new Bitmap();
		
		public var position:int;
		public var requestLevel:int = 0;
		
		public function BuildingSpace(town:Town)
		{
			super();
			this.town = town;
			this.width = 128;
			this.height = 96;
			
			//鼠标点击区
			var hitTestSprite:Sprite = this.getHitArea();
	    	this.hitArea = hitTestSprite;
	    	this.addChild(hitArea);
	    	
	    	this.addChild(this.scene);
	    	this.scene.y=-32;

			//监听鼠标事件
			this.addEventListener(MouseEvent.ROLL_OVER , onMouseOverHandler);
			this.addEventListener(MouseEvent.ROLL_OUT  , onMouseOutHandler);
			this.addEventListener(MouseEvent.MOUSE_MOVE , onMouseMoveHandler);
			this.addEventListener(MouseEvent.CLICK,      onMouseClickHandler);
		}

		protected function getHitArea():Sprite {
			var hitTestSprite:Sprite = new Sprite();
			hitTestSprite.graphics.beginFill(0x000000,0);
	    	hitTestSprite.graphics.moveTo(64,SPACE_GAP);
	    	hitTestSprite.graphics.lineTo(SPACE_GAP ,32);
	    	hitTestSprite.graphics.lineTo(64,64-SPACE_GAP);
			hitTestSprite.graphics.lineTo(128-SPACE_GAP,32);
	    	hitTestSprite.graphics.endFill();
	    	hitTestSprite.x = 0;
	    	hitTestSprite.y = 0;
	    	hitTestSprite.mouseEnabled = false;
	    	return hitTestSprite;
		}
		
		/**
		 * 鼠标点击
		 */
		private function onMouseClickHandler(event:MouseEvent):void {
			log.debug("onMouseClickHandler(), position=" + this.position);
			var buildingObj:BaseBuilding = this.getBuildingObject();
			if (buildingObj==null) {
				//如果这个位置没有建筑，就弹出新建建筑的窗口
				if (this.inCastleLevel()) {
					PopupWindows.openNewBuildingWinAtPosition(this.position);
				}
			} else {
				//如果这个地方有建筑，就交给建筑对象自己处理
				buildingObj.onClick();
			} 
		}
		
		
		private function inCastleLevel():Boolean {
			//var castleLevel:int = GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getTownHall().level / 10;
			var castleLevel:int = GameContext.instance.getPlayerObj().getCurCastleObj().level;
			return this.requestLevel <= castleLevel;
		}

		/**
		 * 鼠标移开建筑空间
		 */
		public function onMouseOutHandler(event:MouseEvent):void {
				//log.debug("onMouseOutHandler(), position=" + position);
			this.alpha = 1;
			town.onMouseOutSpace();
			var buildingObj:BaseBuilding = this.getBuildingObject();
			if (buildingObj!=null) {
				buildingObj.isMouseOver = false;
			}				
		}
		
		/**
		 * 鼠标移入建筑空间
		 */
		public function onMouseOverHandler(event:MouseEvent):void {
			//log.debug("onMouseOverHandler(), position=" + position);
			this.alpha = 0.7;
			var buildingObj:BaseBuilding = this.getBuildingObject();
			if (buildingObj!=null) {
				buildingObj.isMouseOver = true;
				town.onMouseOverSpace(this , event);
			} else if (this.inCastleLevel()) {
				town.onMouseOverSpace(this , event);
			}
		}

		public function onMouseMoveHandler(event:MouseEvent):void {
			if (this.getBuildingObject()!=null) {
				town.onMouseMoveOnSpace(event);
			}
		}
				
		public function getBuildingObject():BaseBuilding {
			return GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getBuildingObjAtPosition(this.position);
		}
		
		/**
		 * 将动画画在屏幕缓冲区上
		 */
		public function drawToBitmapData():void {
			
			var cache:BitmapData = new BitmapData(SPACE_WIDTH, SPACE_HEIGHT, true , 0);
			
			var buildingObj:BaseBuilding = this.getBuildingObject();
			if (buildingObj!=null) {
				buildingObj.drawToBitmapData(cache, 0, 0);
			} else {
				var castleLevel:int = GameContext.instance.getPlayerObj().getCurCastleObj().level;
				if (this.requestLevel <= castleLevel) {
					this.freeSpaceAniPlayer.gotoAndPlay(cache,0,0);
				}
			}
			
			var old:BitmapData = this.scene.bitmapData;
			this.scene.bitmapData = cache;
			if (old!=null) {
				old.dispose();
			}
		}
	}
}
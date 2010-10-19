package views.mainModules.town
{
	import animation.AniPlayer;
	import animation.AnimationManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import roma.common.constants.BuildingConstant;
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	import roma.resource.ImgManager;
	
	import views.mainFrame.CastleFrame;
	import views.spreadUI.tips.BaseTip;
	import views.spreadUI.tips.BuildingTip;
	import views.spreadUI.tips.NewWallTooltip;
	import views.spreadUI.tips.ToolTipContainer;

	public class WallBuilding extends BuildingSpace
	{
		private static const WALL_WIDTH:int = 450;
		private static const WALL_HEIGHT:int = 290;
		private static const RECT:Rectangle = new Rectangle(0,0, WALL_WIDTH,WALL_HEIGHT);

		private var _buildingTooltip:BuildingTip ;
		private var _newWallTooltip:NewWallTooltip ;
		private var curTooltop:BaseTip; 

		protected var noWallData:BitmapData;
		protected var backgroundDataArray:Array = new Array(4);
		
		private function get buildingTooltip():BuildingTip {
			if (this._buildingTooltip == null) {
				this._buildingTooltip = ToolTipContainer.instance.buildingToolTip;
			}
			return this._buildingTooltip;
		}

		private function get newWallTooltip():NewWallTooltip {
			if (this._newWallTooltip == null) {
				this._newWallTooltip = ToolTipContainer.instance.newWallTooltip; 
			}
			return this._newWallTooltip;
		}

		public function WallBuilding(town:Town)
		{	
			super(town);
			this.position = BuildingConstant.WALL_POSITION;
			this.x = 0;
			this.y = 110;
			this.scene.y =0;
			this.initBackgroundData();
		}

		private function initBackgroundData():void {
			var bgClass1:Class = ImgManager.clazz("background.noWall");
			var bgBitmap1:Bitmap = new bgClass1 as Bitmap;
			this.noWallData = bgBitmap1.bitmapData;

			for (var i:int=0; i<this.backgroundDataArray.length; i++) {
				var bgClass:Class = ImgManager.clazz("background.wall" + i);
				var bgBitmap:Bitmap = new bgClass as Bitmap;
				this.backgroundDataArray[i] = bgBitmap.bitmapData;
			}
		}

		override protected function getHitArea():Sprite {
			var hitTestSprite:Sprite = new Sprite();
			hitTestSprite.graphics.beginFill(0x000000,0);
	    	hitTestSprite.graphics.moveTo(0,90);
	    	hitTestSprite.graphics.lineTo(0,140);
	    	hitTestSprite.graphics.lineTo(172 , 228);
			hitTestSprite.graphics.lineTo(172,178);
	    	hitTestSprite.graphics.endFill();
	    	hitTestSprite.x = 0;
	    	hitTestSprite.y = 0;
	    	hitTestSprite.mouseEnabled = false;
	    	return hitTestSprite;
		}

		/**
		 * 鼠标移入建筑空间
		 */
		override public function onMouseOverHandler(event:MouseEvent):void {
			this.alpha = 0.7;
			var buildingObj:BaseBuilding = this.getBuildingObject();
			if (buildingObj!=null) {
				buildingObj.isMouseOver = true;
				this.curTooltop = this.buildingTooltip;
				this.buildingTooltip.setBuildingObj(buildingObj);
				this.buildingTooltip.onMouseOver(event);
			} else {
				this.curTooltop = this.newWallTooltip;
				this.newWallTooltip.onMouseOver(event);
			}
			
			CastleFrame.instance.getTownMod().getBottonWallingBuilding().alpha = 0.7;
		}

		override public function onMouseMoveHandler(event:MouseEvent):void {
			if (this.curTooltop!=null) {
				this.curTooltop.onMouseMove(event);
			}
		}

		override public function onMouseOutHandler(event:MouseEvent):void {
			this.alpha = 1;
			if (this.curTooltop!=null) {
				this.curTooltop.onMouseOut();
			}
			
			CastleFrame.instance.getTownMod().getBottonWallingBuilding().alpha = 1.0;
		}

		/**
		 * 将动画画在屏幕缓冲区上
		 */
		override public function drawToBitmapData():void {
			
			var cache:BitmapData = new BitmapData(WALL_WIDTH,WALL_HEIGHT,true,0);

			var buildingObj:BaseBuilding = this.getBuildingObject();
			if (buildingObj==null){
				cache.copyPixels(this.noWallData,new Rectangle(0,0,174,290),new Point(0,0));
				
			} else {
				var wallLevel:int;
				if(buildingObj.level>0 && buildingObj.level<4){
					wallLevel =0;
				}else if(buildingObj.level>=4 && buildingObj.level<8){
					wallLevel =1;
				}else if(buildingObj.level>=8 && buildingObj.level<10){
					wallLevel =2;
				}else if(buildingObj.level>=10){
					wallLevel =3;
				}
				
				if(wallLevel==2){
					cache.copyPixels(BitmapData(this.backgroundDataArray[wallLevel]).clone(),new Rectangle(0,0,185,290),new Point(0,0));
				}else{
					cache.copyPixels(BitmapData(this.backgroundDataArray[wallLevel]).clone(),new Rectangle(0,0,174,290),new Point(0,0));
				}
			}
			
			var old:BitmapData = this.scene.bitmapData;
			this.scene.bitmapData = cache;
			if (old!=null) {
				old.dispose();
			}
		}
		
		override public function getBuildingObject():BaseBuilding {
			return GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getWall();
		}
	}
}
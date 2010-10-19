package views.mainModules.town
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import roma.common.constants.BuildingConstant;
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;

	public class TownhalllBuilding extends BuildingSpace
	{
		public function TownhalllBuilding(town:Town)
		{
			super(town);
			this.position = BuildingConstant.TOWN_HALL_POSITION; 
			this.x = 416;
			this.y = 80;
			this.scene.y = -68
		}

		override protected function getHitArea():Sprite {
			var hitTestSprite:Sprite = new Sprite();
			hitTestSprite.graphics.beginFill(0x000000,0);
	    	hitTestSprite.graphics.moveTo(148,-27);
	    	hitTestSprite.graphics.lineTo(0 ,64);
	    	hitTestSprite.graphics.lineTo(128,128);
			hitTestSprite.graphics.lineTo(216,64);
	    	hitTestSprite.graphics.endFill();
	    	hitTestSprite.x = 20;
	    	hitTestSprite.y = -14;
	    	hitTestSprite.mouseEnabled = false;
	    	return hitTestSprite;
		}

		override public function getBuildingObject():BaseBuilding {
			return GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getTownHall();
		}

		/**
		 * 将动画画在屏幕缓冲区上
		 */
		override public function drawToBitmapData():void {
			
			var cache:BitmapData = new BitmapData(256, 256, true , 0);
			
			this.getBuildingObject().drawToBitmapData(cache, 0, 0);

			var old:BitmapData = this.scene.bitmapData;
			this.scene.bitmapData = cache;
			if (old!=null) {
				old.dispose();
			}
		}
	}
}
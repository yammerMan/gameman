package views.mainModules.town.resDomain
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import roma.common.constants.BuildingConstant;
	
	import views.mainModules.town.BuildingSpace;
	import views.mainModules.town.Town;
	
	public class QuarryDomain extends BuildingSpace
	{
		private static const SPACE_WIDTH:int = 128;
		private static const SPACE_HEIGHT:int = 96;
		private static const SPACE_GAP:int = 2;	
			
		public function QuarryDomain(town:Town)
		{
			super(town);

			this.position = BuildingConstant.POSITION_QUARRY; 
			this.x = 600;
			this.y = 25;
		}

		override protected function getHitArea():Sprite {
			var hitTestSprite:Sprite = new Sprite();
			hitTestSprite.graphics.beginFill(0x000000,0);
	    	hitTestSprite.graphics.moveTo(64,SPACE_GAP);
	    	hitTestSprite.graphics.lineTo(SPACE_GAP ,32);
	    	hitTestSprite.graphics.lineTo(64,64-SPACE_GAP);
			hitTestSprite.graphics.lineTo(128-SPACE_GAP,32);
	    	hitTestSprite.graphics.endFill();
	    	hitTestSprite.x = -5;
	    	hitTestSprite.y = -14;
	    	hitTestSprite.mouseEnabled = false;
	    	return hitTestSprite;
		}

		/**
		 * 将动画画在屏幕缓冲区上
		 */
		override public function drawToBitmapData():void {
			var cache:BitmapData = new BitmapData(SPACE_WIDTH, SPACE_HEIGHT, true , 0);
			
			this.getBuildingObject().drawToBitmapData(cache, 0, 0);

			var old:BitmapData = this.scene.bitmapData;
			this.scene.bitmapData = cache;
			if (old!=null) {
				old.dispose();
			}
		}
	}
}
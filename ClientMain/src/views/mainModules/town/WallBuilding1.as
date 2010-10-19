package views.mainModules.town
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import roma.logic.object.building.BaseBuilding;
	
	import views.mainFrame.CastleFrame;
	
	public class WallBuilding1 extends WallBuilding
	{
		private static const WALL_WIDTH:int = 450;
		private static const WALL_HEIGHT:int = 290;
		
		public function WallBuilding1(town:Town)
		{
			super(town);
		}
		
		override protected function getHitArea():Sprite{
			var hitTestSprite:Sprite = new Sprite();
			hitTestSprite.graphics.beginFill(0x000000,0);
	    	hitTestSprite.graphics.moveTo(172,178);
	    	hitTestSprite.graphics.lineTo(172,228);
	    	hitTestSprite.graphics.lineTo(290 , WALL_HEIGHT);
			hitTestSprite.graphics.lineTo(380,WALL_HEIGHT);
	    	hitTestSprite.graphics.endFill();
	    	hitTestSprite.x = 0;
	    	hitTestSprite.y = 0;
	    	hitTestSprite.mouseEnabled = false;
	    	return hitTestSprite;
		}
		
		override public function drawToBitmapData():void{
			var cache:BitmapData = new BitmapData(WALL_WIDTH,WALL_HEIGHT,true,0);

			var buildingObj:BaseBuilding = this.getBuildingObject();
			if (buildingObj==null){
				cache.copyPixels(this.noWallData.clone(),new Rectangle(174,0,276,290),new Point(170,0));
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
				
				if(wallLevel ==2){
					cache.copyPixels(BitmapData(this.backgroundDataArray[wallLevel]).clone(),new Rectangle(185,0,276,290),new Point(185,0));
				}else{
					cache.copyPixels(BitmapData(this.backgroundDataArray[wallLevel]).clone(),new Rectangle(174,0,276,290),new Point(174,0));
				}
				buildingObj.drawToBitmapData(cache , 0, 0);
			}

			var old:BitmapData = this.scene.bitmapData;
			this.scene.bitmapData = cache;
			if (old!=null) {
				old.dispose();
			}
		}
		
		override public function onMouseOverHandler(event:MouseEvent):void{
			super.onMouseOverHandler(event);
			CastleFrame.instance.getTownMod().getTopWallingBuilding().alpha = 0.7;
		}
		
		override public function onMouseOutHandler(event:MouseEvent):void{
			super.onMouseOutHandler(event);
			CastleFrame.instance.getTownMod().getTopWallingBuilding().alpha =1.0;
		}
	}
}
package views.mainModules.map.diamond
{
	import animation.AniPlayer;
	import animation.AnimationManager;
	import animation.IAniPlayer;
	import animation.aniSet.FieldAniSetManager;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.valueObject.SimpleMapCastleBean;
	import roma.logic.GameContext;
	import roma.logic.object.player.PlayerObj;
	
	import views.mainModules.map.FlagPlayer;
	import views.mainModules.map.IMapTile;
	import views.mainModules.map.MapGroundData;

	public class DiamondMapTile extends Sprite implements IMapTile
	{
		private static var log:ILogger = Log.getLogger("views.mainModules.map.DiamondMapTile");

		public static var TILE_WIDTH_HALF:int = 64;
		public static var TILE_HEIGHT_HALF:int = 32;
		
		public static var FLAG_TEXT_X:int = 30;
		public static var FLAG_TEXT_Y:int = -4;

		public var hasData:Boolean;

		public static var player:PlayerObj = GameContext.instance.getPlayerObj();
		
		private var fieldX:int;
		private var fieldY:int;

		private var mapX:int = -9999999;
		private var mapY:int = -9999999;
		
		private var fieldType:int = -9999;
		private var fieldLevel:int = -9999;
		
		public var mapId:Number;
		public var idField:Number;
		
		private var groundSourceX:int;
		private var groundSourceY:int;
		
		private var fieldPlayer:IAniPlayer ;
		private var flagPlayer:IAniPlayer ;
		
		private var mapCityBean:SimpleMapCastleBean;
		
		private var curCastlePlayer:IAniPlayer = new AniPlayer(AnimationManager.curCastleAni , 55 , -32);
		
		public function DiamondMapTile()
		{
			super();
			
			this.x = -99999;
			this.y = -99999;

			//鼠标点击区
			var hitTestSprite:Sprite = this.getHitArea();
	    	this.hitArea = hitTestSprite;
	    	this.addChild(hitArea);
			
			graphics.beginFill(0,0);
	    	graphics.moveTo(2,TILE_HEIGHT_HALF);
	    	graphics.lineTo(TILE_WIDTH_HALF  , 2);
	    	graphics.lineTo(TILE_WIDTH_HALF*2-2, TILE_HEIGHT_HALF);
			graphics.lineTo(TILE_WIDTH_HALF  , TILE_HEIGHT_HALF*2-2);
	    	graphics.endFill();
		}
		
		private function getHitArea():Sprite {
			var hitTestSprite:Sprite = new Sprite();
			hitTestSprite.graphics.beginFill(0x000000,0);
	    	hitTestSprite.graphics.moveTo(0,TILE_HEIGHT_HALF);
	    	hitTestSprite.graphics.lineTo(TILE_WIDTH_HALF  , 0);
	    	hitTestSprite.graphics.lineTo(TILE_WIDTH_HALF*2, TILE_HEIGHT_HALF);
			hitTestSprite.graphics.lineTo(TILE_WIDTH_HALF  , TILE_HEIGHT_HALF*2);
	    	hitTestSprite.graphics.endFill();
	    	hitTestSprite.x = 0;
	    	hitTestSprite.y = 0;
			
	    	hitTestSprite.mouseEnabled = false;
	    	return hitTestSprite;
		}
		
		public function setData(mapX:int , mapY:int , type:int , level:int):void {
			
			if (mapX != this.mapX || mapY != this.mapY ) {
				//如果和原来不是重复的，就需要改变坐标
				this.mapX = mapX;
				this.mapY = mapY;
				
				x = TILE_WIDTH_HALF  * (mapX - mapY);
				y = TILE_HEIGHT_HALF * (mapX + mapY);

				mapId =  mapX * 100000 + mapY;

				groundSourceX = MapGroundData.getGroundX(mapX);
				groundSourceY = MapGroundData.getGroundY(mapY);
				
				fieldX = GameContext.getFieldX(mapX);
				fieldY = GameContext.getFieldY(mapY);

				fieldType = type;
				fieldLevel = level;
				
				idField = GameContext.getFieldId(mapX,mapY);

				setFieldAni();
			} else {
				//否则，只需判断地形是否有变化
				if (fieldType != type || fieldLevel != level) {
					fieldType = type;
					fieldLevel = level;
	
					setFieldAni();
				}
			}
			hasData = true;
		}
		
		private function setFieldAni():void {
			mapCityBean = null;
			fieldPlayer = FieldAniSetManager.instance.getAniPlayer(fieldType,fieldLevel); 
			flagPlayer = null;
		}
		
		public function setMapCityBean(bean:SimpleMapCastleBean):void {
			mapCityBean = bean;
			
			var relation:int = bean.relation;
			if (player.getCastleObjById(bean.cityId)!=null) {
				relation = -9999; //用不存在的关系表示这个城堡是自己的
			}
			
			//根据关系获得旗帜的动画
			flagPlayer = new FlagPlayer(relation, bean.flag, FLAG_TEXT_X, FLAG_TEXT_Y,-1); 
		}
		
		public function drawToScene(scene:BitmapData,mapUiComp:Sprite):void{
			var ox:int = this.x + mapUiComp.x ;
			var oy:int = this.y + mapUiComp.y ;
			
			if (ox > -TILE_WIDTH_HALF*2 && ox < DiamondWorldMap.SCENE_WIDTH
				&& oy > -TILE_HEIGHT_HALF*2 && oy < DiamondWorldMap.SCENE_HEIGHT) {
					

				if (this.fieldPlayer!=null) {
					this.fieldPlayer.gotoAndPlay(scene,ox,oy-TILE_HEIGHT_HALF);
					if (this.flagPlayer!=null) {
						this.flagPlayer.gotoAndPlay(scene , ox,oy);
					}

					if (GameContext.instance.getPlayerObj().getCurCastleObj().idField == this.idField) {
						this.curCastlePlayer.gotoAndPlay(scene , ox, oy);
					}
				}
			}
		}
		
		public function getFieldX():int {
			return this.fieldX;
		}
		
		public function getFieldY():int {
			return this.fieldY;
		}
		
		public function getFieldType():int {
			return this.fieldType;
		}
		
		public function getFieldLevel():int {
			return this.fieldLevel;
		}
		
		public function getMapCityBean():SimpleMapCastleBean {
			return this.mapCityBean;
		}
	}
}
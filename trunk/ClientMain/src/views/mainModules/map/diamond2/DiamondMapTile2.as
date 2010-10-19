package views.mainModules.map.diamond2
{
	import animation.AniPlayer;
	import animation.AnimationManager;
	import animation.aniSet.BaseAniSetPlayer;
	import animation.aniSet.FieldAniSetManager;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.constants.FieldConstant;
	import roma.common.valueObject.FieldBattleInfoBean;
	import roma.common.valueObject.SimpleMapCastleBean;
	import roma.logic.GameContext;
	import roma.logic.object.castle.CastleObj;
	
	import views.mainModules.map.FieldAddShow;
	import views.mainModules.map.FlagPlayer;
	import views.mainModules.map.IMapTile;
	import views.mainModules.map.smallMap.NpcFieldConstant;

	public class DiamondMapTile2 implements IMapTile
	{
		private static var log:ILogger = Log.getLogger("views.mainModules.map.DiamondMapTile");
		
		public static var FLAG_TEXT_X:int = 30;
		public static var FLAG_TEXT_Y:int = -4;

		public var fieldLevel:int = 1;
		public var idField:int;
		
		private var fieldX:int = -999999;
		private var fieldY:int = -999999;

		public var fieldType:int = -1;
		
		private var fieldPlayer:BaseAniSetPlayer ;
		private var flagPlayer:FlagPlayer ;
		private var hostFlagPlayer:FlagPlayer;
		private var lakeAni:AniPlayer;
		
		private var mapCityBean:SimpleMapCastleBean;
		
		private var fieldAdd:FieldAddShow;
		
		public var isInBattle:Boolean = false;
		public var battleBean:FieldBattleInfoBean;

		public var mapGlobalX:int;
		public var mapGlobalY:int;
		
		public function DiamondMapTile2(fieldX:int, fieldY:int, type:int){
			super();
			this.fieldX = fieldX;
			this.fieldY = fieldY;
			this.idField = fieldX * 10000 + fieldY;
			this.fieldType = type;
			
			if (type == FieldConstant.FLAT_TYPE || type == FieldConstant.LAKE_TYPE || type==FieldConstant.TYPE_CITY|| type==FieldConstant.TYPE_NPC_FIELD|| type==14) {
				if (type == FieldConstant.TYPE_CITY) {
					if(MapDataByteArray.instance.isPersonNpcCastle(fieldX,fieldY)){
						this.fieldPlayer = FieldAniSetManager.instance.getRatterNpcAni();
					}else{
						this.fieldPlayer = FieldAniSetManager.instance.getCastleAniByLevel(0);
					}
				}else if(type == FieldConstant.TYPE_NPC_FIELD){
					this.fieldPlayer = FieldAniSetManager.instance.getTrainingRoomAni();
				}else if(type == NpcFieldConstant.TYPE_RATTER_NPC_FIELD){//叛军城
					this.fieldPlayer = FieldAniSetManager.instance.getRatterNpcAni();
				} else if(type == FieldConstant.LAKE_TYPE){
					if(fieldX%10 == 6 && fieldY%10 == 3){
						this.lakeAni = new AniPlayer(AnimationManager.fieldAni.lakeAni,45,20);
					}else if(fieldX%10 == 7 && fieldY%10 == 4){
						this.lakeAni = new AniPlayer(AnimationManager.fieldAni.lakeAni,35,0);
					}else if(fieldX%10 == 8 && fieldY%10 == 3){
						this.lakeAni = new AniPlayer(AnimationManager.fieldAni.lakeAni,47,21);
					}
				}else{
					this.fieldPlayer = null;
				}
			} else {
				if (type >= FieldConstant.HILL_TYPE) {
					this.fieldType = FieldConstant.HILL_TYPE;
				} else if (type >= FieldConstant.DESERT_TYPE) {
					this.fieldType = FieldConstant.DESERT_TYPE;
				} else {
					this.fieldType = FieldConstant.TYPE_TREES;
				}
				this.fieldPlayer = FieldAniSetManager.instance.getFieldAniPlayerByComplexType(this.fieldType,type);
			}
		}

		public static function tranTileXY2FieldXY(value:int):int {
			var x1:int = value % FieldConstant.MAP_SIZE;
			if (x1<0) {
				x1 += FieldConstant.MAP_SIZE;
			}
			return x1;
		}

		public function setMapCityBean(bean:SimpleMapCastleBean):void {
			this.fieldLevel = bean.level;
			if(MapDataByteArray.instance.isPersonNpcCastle(fieldX,fieldY)){
				this.fieldPlayer = FieldAniSetManager.instance.getRatterNpcAni();
			}else{
				this.fieldPlayer = FieldAniSetManager.instance.getCastleAniByLevel(bean.expandLevel);
			}

			var castle:CastleObj = GameContext.instance.getPlayerObj().getCastleByFieldId(bean.fieldId);
			if (castle==null) {
				if (this.mapCityBean ==null || this.mapCityBean.flag != bean.flag || this.mapCityBean.relation != bean.relation) {
					this.flagPlayer = new FlagPlayer(bean.relation, bean.flag, FLAG_TEXT_X, FLAG_TEXT_Y,-1);//根据关系获得旗帜的动画
				} 
			} else {
				this.flagPlayer = new FlagPlayer(-99999);
				this.flagPlayer.flagTextBitmapData = GameContext.instance.getPlayerObj().myFlagPlayerBitmapData;
			}
			
			if(bean.hostFlag !=null){
				this.hostFlagPlayer = new FlagPlayer(bean.hostRelation, bean.hostFlag, FLAG_TEXT_X, FLAG_TEXT_Y,-1);
			}else{
				this.hostFlagPlayer = null;
			}

			this.mapCityBean = bean;
			//显示特殊外观，足球场，王者之城
			if(this.mapCityBean!=null){
				if(this.mapCityBean.uiBuffsArray.length>0){
					for(var football:int=0;football<this.mapCityBean.uiBuffsArray.length;football++){
						if(this.mapCityBean.uiBuffsArray[football]>=201&&this.mapCityBean.uiBuffsArray[football]<=203){
							this.fieldPlayer = FieldAniSetManager.instance.getFootballFieldAni(this.mapCityBean.uiBuffsArray[football]);
						}else if(this.mapCityBean.uiBuffsArray[football]==204){
							this.fieldPlayer = FieldAniSetManager.instance.getKingsCastleAni();
						}
					}
				}
			}
		}
		
		public function setLevelData(level:int):void {
			this.fieldLevel = level;
			
			if(this.fieldType !=FieldConstant.TYPE_CITY && this.fieldType != FieldConstant.FLAT_TYPE){
				var isMyField:Boolean =GameContext.instance.getPlayerObj().isSelfResourceField(this.idField);
				if(isMyField){
					this.fieldAdd = new FieldAddShow();
					this.fieldAdd.setLevel(this.fieldLevel);
				}else{
					this.fieldAdd =null;
				}
			}else{
				this.fieldAdd =null;
			}
		}
		
		public function drawToScene(scene:BitmapData,mapUiComp:DisplayObject, tileX:int,tileY:int):void{
			
			var ox:int = (tileX - tileY) * (DiamondWorldMap2.TILE_WIDTH/2)  + mapUiComp.x ;
			var oy:int = (tileX + tileY) * (DiamondWorldMap2.TILE_HEIGHT/2)  + mapUiComp.y ;
			
			this.mapGlobalX = ox;
			this.mapGlobalY = oy;
			
			if (ox > -DiamondWorldMap2.TILE_WIDTH && ox < DiamondWorldMap2.SCENE_WIDTH
				&& oy > -DiamondWorldMap2.TILE_HEIGHT && oy < DiamondWorldMap2.SCENE_HEIGHT) {
				
				if (this.fieldPlayer!=null) {
					if(isBattling()){
						this.fieldPlayer.gotoAndPlay(scene,ox, oy- DiamondWorldMap2.TILE_HEIGHT/2);									
					}else{
						this.fieldPlayer.gotoAndPlay1(scene,ox, oy- DiamondWorldMap2.TILE_HEIGHT/2);
					}
					if(this.hostFlagPlayer !=null){
						this.hostFlagPlayer.gotoAndPlay(scene , ox,oy-14);
						this.flagPlayer.gotoAndPlay(scene , ox,oy);
					}else{
						if (this.flagPlayer!=null) {
							this.flagPlayer.gotoAndPlay(scene , ox,oy);
						}
					}
				}
				//湖的动画
				if(this.lakeAni!=null){
					this.lakeAni.gotoAndPlay(scene,ox, oy);
				}
				//显示自己野地加成
				if(this.fieldAdd !=null){
					this.fieldAdd.drawToScene(scene,ox-5, oy);
				}
				//显示旗帜
				if(this.mapCityBean!=null){
					WorldCupHelper.instance.drawBitmapdata(this.mapCityBean,scene,ox,oy);
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
		
		public function isCastle():Boolean{
			return (this.fieldType == FieldConstant.TYPE_CITY); 
		}

		/**
		 * 战局剩余时间
		 * @return 
		 */		
		private function isBattling():Boolean{
			if(battleBean != null){
				var diff:Number = GameContext.instance.getTimeDis();
				var now:Number = new Date().valueOf();
				return ((battleBean.endTime - now +diff)/1000>0 && this.isInBattle);
			}else{
				return false;
			}
		}
	}
}
package views.windows.functionWins.military
{
	import mx.collections.ArrayCollection;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.AllianceConstant;
	import roma.common.constants.BuildingConstant;
	import roma.common.constants.TechConstant;
	import roma.common.controller.common.MapFieldInfoResponse;
	import roma.common.valueObject.FieldCollectBean;
	import roma.common.valueObject.MapFieldInfoBean;
	import roma.data.MapTileData;
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.object.player.PlayerObj;
	
	import views.PopupWindows;
	import views.mainModules.map.diamond2.MapDataByteArray;
	import views.spreadUI.MyAlert;
	import views.windows.functionWins.hero.HeroHelper;
	import views.windows.functionWins.hero.HerosMansionWin;
	
	public class GoToWarFromFavorite
	{
		public var fun:Function;
		
		private var _bean:FieldCollectBean;
		
		private var _data:MapTileData = new MapTileData();
		
		private static var _instance:GoToWarFromFavorite;
				
		public function GoToWarFromFavorite()
		{
		}
		
		public static function getInstance():GoToWarFromFavorite{
			if(_instance ==null){
				_instance = new GoToWarFromFavorite();
			}
			return _instance;
		}
		
		/**
		 *出征到收藏夹的野地 
		 */		
		public function goToWar():void{
			getFieldFavoriteAry();
			if(_bean !=null){
				var fx:int = _bean.fieldId/10000;
				var fy:int = _bean.fieldId%10000;
				var cityId:int = GameContext.instance.getPlayerObj().getCurCastleObj().cityId
				ControllerFactory.getInstance().getCommonController().mapFieldInfo(cityId,fx,fy , onResponse,false);	
			}
		}
	
		private var castle:CastleObj;
		/**
		 *出征到自己的城市
		 */		
		public function goToWarToCity():void{
			var castleAry:Array = GameContext.instance.getPlayerObj().getAllCastle();
			var curCastleId:int = GameContext.instance.getPlayerObj().getCurCastleObj().cityId;
			
			for each(var obj:CastleObj in castleAry){
				if(obj.cityId != curCastleId){
					castle = obj;
					break;
				}
			}
			
			var fx:int = castle.idField/10000;
			var fy:int = castle.idField%10000;
			ControllerFactory.getInstance().getCommonController().mapFieldInfo(curCastleId,fx,fy , onResponse,false);	
		}
		
		private function onResponse(event:MapFieldInfoResponse):void{
			if(event.isSuccess()){
				setBean(event.mapFieldInfoBean);
				//ButtonSwitch.instance.switchHandler(true);
				//PopupWindows.openFuncWin(GoingToWarWin.WINDOW_SHOW,_data);
				HeroHelper.instance.targetMapTileData=_data;
				PopupWindows.openFuncWin(HerosMansionWin.WINDOW_SHOW_CAMPAIGN);
			}else{
				MyAlert.showError(event);
			}
		}	
		
		private function getFieldFavoriteAry():void{
			var favAry:ArrayCollection= GameContext.instance.getPlayerObj().favoriteManager.filterArray;
			if(favAry.length>0){
				_bean = favAry.getItemAt(0) as FieldCollectBean;
			}else{
				_bean = null;
			}
		}
		
		private function setBean(b:MapFieldInfoBean):void{
			var player:PlayerObj = GameContext.instance.getPlayerObj()
			var curScoutLev:int = player.techManager.getTechObjById(TechConstant.SCOUTING).getCurCastleTechLevel(player.getCurCastleObj());
			
			if(b !=null){
				_data.canAttack = b.canAttack;
				_data.scoutable = b.canAttack && (curScoutLev>0);
				_data.canReinforce =true;
				_data.canTransport = b.relation != AllianceConstant.ALLIANCE_RELATION_HOSTILE && this.getMarket()!=null;
				_data.relation = b.relation;
				_data.status = b.status;
				_data.hostPlayer = b.hostPlayer;
				_data.hostRelation =b.hostRelation;
			}
			
			if(_bean !=null){
				_data.fieldName = _bean.remark;
				_data.fieldX= _bean.fieldId/10000;
				_data.fieldY = _bean.fieldId%10000;
			}else{
				_data.fieldName = castle.name;
				_data.fieldX= castle.idField/10000;
				_data.fieldY = castle.idField%10000;
			}
			_data.isCastle  = MapDataByteArray.instance.getTileObj(_data.fieldX,_data.fieldY).isCastle();
		}
		
		private function getMarket():BaseBuilding {
			return GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getUniqueBuildingByType(BuildingConstant.TYPE_MARKET_BUILDING);	
		}
	}
}
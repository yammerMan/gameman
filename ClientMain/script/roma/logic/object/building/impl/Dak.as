package roma.logic.object.building.impl{
	import animation.IAniPlayer;
	import animation.aniSet.building.DakAniSet;
	
	import roma.common.action.ControllerFactory;
	import roma.common.controller.CommonResponse;
	import roma.common.valueObject.ArchitectureBean;
	import roma.common.valueObject.PostTransportBean;
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	import roma.util.MultiLang;
	
	import views.MainContainer;
	import views.PopupWindows;
	import views.spreadUI.MyAlert;
	import views.windows.buildings.dak.DakWin;

	public class Dak extends BaseBuilding {
		private var dakBean:PostTransportBean;
		private var curCastleId:int;
		public function Dak(bean:ArchitectureBean) {
			super(bean);
		}

		/**
		 * 驿站
		 * 重写父类的方法
		 * 点击弹出界面
		 **/
		override public function onClick():void {
			PopupWindows.openBuildingInfoWin(DakWin.WINDOW_SHOW,this);
		}

		/** 获得建筑的动画*/
		override protected function getNormalAniPLayer():IAniPlayer {
			return new DakAniSet();
		}

		/** 判断能否建立建筑线*/
		public function checkCanTransport(startId:int,targetId:int):Boolean {
			var canDo:Boolean=true;
			var inX:Boolean=true;
			var inY:Boolean=true;
			var transportRadio:int=Math.ceil(this.level/2)+5;
			var mapW:int=100;
			var mapH:int=100;
			var curCastleX:int=startId/mapW*mapH;
			var curCastleY:int=startId%mapW*mapH;
			var targetCastleX:int=targetId/mapW*mapH;
			var targetCastleY:int=targetId%mapW*mapH;
			if (curCastleX-transportRadio>=0&&curCastleX+transportRadio<mapW) {
				if (Math.abs(curCastleX-targetCastleX)>transportRadio) {
					inX=false;
				}
			} else {
				if (Math.abs(curCastleX-targetCastleX)<mapW-transportRadio) {
					inX=false;
				}
			}
			if (curCastleY-transportRadio>=0&&curCastleY+transportRadio<mapH) {
				if (Math.abs(curCastleY-targetCastleY)>transportRadio) {
					inY=false;
				}
			} else {
				if (Math.abs(curCastleY-targetCastleY)<mapH-transportRadio) {
					inY=false;
				}
			}
			//canDo=inX&&inY;//测试暂时不限制距离
			return canDo;
		}

		//更新运输线
		public function refreshTransport(dakBean:PostTransportBean,food:int,wood:int,stone:int,iron:int):void {
			this.dakBean=dakBean;
			this.curCastleId=GameContext.instance.getPlayerObj().getCurCastleObj().cityId;
			ControllerFactory.getInstance().getCityController().postTransport(dakBean.startCastleId,dakBean.targetCastleId,food,wood,stone,iron,0,refreshCallback);
			function refreshCallback(response:CommonResponse):void {
				if (response.isSuccess()) {
					MyAlert.show(MultiLang.msg("dak.builtLine.tip",food/10,wood/10,stone/10,iron/10));
				} else {
					MyAlert.showError(response);
				}
			}
		}

		//删除运输线
		public function deleteTransport(dakBean:PostTransportBean):void {
			this.dakBean=dakBean;
			this.curCastleId=GameContext.instance.getPlayerObj().getCurCastleObj().cityId;
			ControllerFactory.getInstance().getCityController().postTransport(dakBean.startCastleId,dakBean.targetCastleId,0,0,0,0,0,deleteCallback);
			function deleteCallback(response:CommonResponse):void {
				if (response.isSuccess()) {
				}else{
					MyAlert.showError(response);
				}

			}
		}
		//增加运输线
		public function addTransport(targetCityId:int,food:int,wood:int,stone:int,iron:int):void
		{
			this.curCastleId=GameContext.instance.getPlayerObj().getCurCastleObj().cityId;
			ControllerFactory.getInstance().getCityController().postTransport(this.curCastleId,targetCityId,
			food,wood,stone,iron,0,callback);
		    function callback(response:CommonResponse):void
			{
				if(response.isSuccess()){
					MyAlert.show(MultiLang.msg("dak.builtLine.tip",food/10,wood/10,stone/10,iron/10));
				}else{
					MyAlert.showError(response);
				}	
			}
		}
//		override public function getFuncDesc(level:int):String {
//			if (level>0 && level < BuildingConstant.HIGHEST_LEVEL) {
//				var rule:BuildingRule = GameRuleHelper.instance.getBuildingRule(this.typeId , level);
//				if(rule.buff3!=0){
//					return BuildingHelper.instance.getFuncDesc(this.typeId, rule.buff1 , rule.buff2, rule.buff3);
//				}else if(rule.buff2!=0){
//					return BuildingHelper.instance.getFuncDesc(this.typeId, rule.buff1 , rule.buff2);
//				}else{
//					return BuildingHelper.instance.getFuncDesc(this.typeId, rule.buff1);
//				}
//				
//			} else {
//				return "";
//			}
//		}
	}
}
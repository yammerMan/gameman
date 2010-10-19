package roma.logic.object.player
{
	import roma.common.action.ControllerFactory;
	import roma.common.controller.CommonResponse;
	import roma.common.events.CastleMilitaryUpdate;
	import roma.common.valueObject.CastleMilitaryBean;
	import roma.logic.GameContext;
	
	import views.spreadUI.MyAlert;
	
	public class CastleMilitaryManager
	{
		private var castle_id:int;
		[Bindable]
		public var militaryBean:CastleMilitaryBean;
		public function CastleMilitaryManager(castle_id:int,militaryBean:CastleMilitaryBean)
		{
			this.castle_id=castle_id;
			this.militaryBean=militaryBean;
		}
		
		public function setAllowLeagueArmy(allow:Boolean):void {
			ControllerFactory.getInstance().getArmyController().setAllowLeagueArmy(this.castle_id,allow,callback);
			
			function callback(event:CommonResponse):void{
			if(event.isSuccess()){
	           	GameContext.instance.getPlayerObj().getCurCastleObj().castleMilitaryManager.militaryBean.allow=allow;
				}else{
					MyAlert.showError(event);
				}
			}
		}
		
		public function setAntiLoot(allow:Boolean):void {
			ControllerFactory.getInstance().getArmyController().setAntiLoot(this.castle_id,allow,callback);
			function callback(event:CommonResponse):void{
				if(event.isSuccess()){
		           	GameContext.instance.getPlayerObj().getCurCastleObj().castleMilitaryManager.militaryBean.antiLoot=allow;
					}else{
						MyAlert.showError(event);
					}
				}
		}
		
		private function callback(event:CommonResponse):void{
			if(event.isSuccess()){
//				MsgDispacther.instance.dispatchEvent(new InjuredTroopChangeEvent(InjuredTroopChangeEvent.INJUREDTROOP_CHANGE,castle_id));
			}else{
				MyAlert.showError(event);
			}
		}
		
		
		//更新信息
		public function updateCastleMilitary(event:CastleMilitaryUpdate):void {
			if(this.castle_id==event.cityId){
				this.militaryBean=event.militaryBean;
			}
		}

	}
}
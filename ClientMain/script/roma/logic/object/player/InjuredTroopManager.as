package roma.logic.object.player
{
	import mx.collections.ArrayCollection;
	
	import roma.common.action.ControllerFactory;
	import roma.common.controller.CommonResponse;
	import roma.common.events.CuredTroopUpdate;
	import roma.common.valueObject.PairValueBean;
	import roma.message.EvtDispacther;
	import roma.message.events.InjuredTroopChangeEvent;
	
	import views.spreadUI.MyAlert;
	import views.windows.buildings.trainningField.BruiseTroopData;
	
	public class InjuredTroopManager
	{
		public var goldsForCureInjuredTroopArray:ArrayCollection;
		public var injuredTroopArray:ArrayCollection = new ArrayCollection();
		private var castle_id:int;
		public function InjuredTroopManager(cId:int,goldsForCureInjuredTroopArray:ArrayCollection,injuredTroopArray:ArrayCollection)
		{
			this.castle_id=cId;
			this.goldsForCureInjuredTroopArray=goldsForCureInjuredTroopArray;
			this.transitionInjuredTroop(injuredTroopArray);
		}
		//复原选择状态
		public function troopSelected(boo:Boolean):void{
			for each(var troop:BruiseTroopData in this.injuredTroopArray){
				troop.selected=boo;
			}
		}
		
		//转换成需要的数据类型
		private function transitionInjuredTroop(troopArray:ArrayCollection):void{
			this.injuredTroopArray.removeAll();
			for each(var troop:PairValueBean in troopArray){
				var b:BruiseTroopData=new BruiseTroopData();
				b.copyToMe(troop);
				this.injuredTroopArray.addItem(b);
			}
		}
		//治疗伤兵
		public function cureInjureds(castle_id:int,troop:String):void {
			ControllerFactory.getInstance().getArmyController().cureInjureds(this.castle_id,troop,callback);
		}
		//遣散伤兵
		public function destructDownBuilding(castle_id:int,troop:String):void {
			ControllerFactory.getInstance().getArmyController().disbandInjureds(this.castle_id,troop,callback);
		}
		
		private function callback(event:CommonResponse):void{
			if(event.isSuccess()){
				EvtDispacther.instance.dispatchEvent(new InjuredTroopChangeEvent(InjuredTroopChangeEvent.INJUREDTROOP_CHANGE,castle_id));
			}else{
				MyAlert.showError(event);
			}
		}
		
		//更新伤兵信息
		public function updateInjuredTroop(event:CuredTroopUpdate):void {
			if(this.castle_id==event.cityId){
				this.goldsForCureInjuredTroopArray=event.goldForCureInjuredTroopArray;
				this.transitionInjuredTroop(event.injuredTroopsArray);
			}
		}
		
		//获取需要治疗伤兵的费用
		public function getGoldsForCureTroop():int{
			var count:int=0;
			for each(var troop:BruiseTroopData in this.injuredTroopArray){
				if(troop.selected){
					for(var i:int=0;i<this.goldsForCureInjuredTroopArray.length;i++){
						var p:PairValueBean=this.goldsForCureInjuredTroopArray[i];
						if(p.typeId==troop.typeId){
							count+=p.value;
							break;
						}
					}
				}
			}
			return count;
		}
		//获取伤兵类型字符
		public function cureTroopString():String{
			var str:String="";
			for(var i:int=0;i<this.injuredTroopArray.length;i++){
				var troop:BruiseTroopData=this.injuredTroopArray[i];
				if(troop.selected){
					str+=troop.typeId+",";
				}
			}
			return str.substr(0,str.length-1);
		}
	}
}
package roma.logic.object.player
{
	import mx.collections.ArrayCollection;
	
	import roma.common.action.ControllerFactory;
	import roma.common.controller.army.BattleInfoResponse;
	import roma.message.EvtDispacther;
	import roma.message.events.IntelligenceEvent;
	
	import sound.MsgSound;
	
	public class BattleFieldManager
	{
		public var attackBattlesArray:ArrayCollection = new ArrayCollection();
		public var defendBattlesArray:ArrayCollection = new ArrayCollection();
		public var otherBattlesArray:ArrayCollection = new ArrayCollection();
		
		private var countOld:int = 0;
		
		public function BattleFieldManager()
		{
			ControllerFactory.getInstance().getArmyController().getPlayerBattleInfo(onGetPlayerBattles,false);
		}

		public function hasModify(isChange:Boolean = false):void{
			if(isChange){
				// 战局有变化
				ControllerFactory.getInstance().getArmyController().getPlayerBattleInfo(onGetPlayerBattles,false);
			}
		}
		
		/**
		 * 删除item
		 */ 
		public function removeItem(arr:ArrayCollection,i:int):void{
			arr.removeItemAt(i);
			EvtDispacther.instance.dispatchEvent(new IntelligenceEvent(IntelligenceEvent.HAS_BATTLE_CHANGE,true));
		}
		
		private function onGetPlayerBattles(event:BattleInfoResponse):void{
			if(event.isSuccess()){
				attackBattlesArray.removeAll();
				defendBattlesArray.removeAll();
				otherBattlesArray.removeAll();
				var count:int = event.attackBattlesArray.length+event.defendBattlesArray.length+event.otherBattlesArray.length;
				attackBattlesArray = event.attackBattlesArray;
				defendBattlesArray = event.defendBattlesArray;
				otherBattlesArray = event.otherBattlesArray;
				// 更新战局数
				if(countOld <count){
					MsgSound.instance.playWarSound();
				}
				countOld = count;
				EvtDispacther.instance.dispatchEvent(new IntelligenceEvent(IntelligenceEvent.HAS_BATTLECOUNT_CHANGE,count));
				EvtDispacther.instance.dispatchEvent(new IntelligenceEvent(IntelligenceEvent.HAS_BATTLE_CHANGE,true));
			}
		}
		
	}
}
package roma.logic.object.player
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.GeneralConstants;
	import roma.common.controller.CommonResponse;
	import roma.common.controller.player.PlayerCastleResponse;
	import roma.common.events.ScoutPlayerUpdate;
	import roma.common.valueObject.PlayerInfoDataBean;
	import roma.common.valueObject.ScoutPlayerBean;
	import roma.message.EvtDispacther;
	import roma.message.events.ScoutPlayerChangeEvent;
	import roma.util.PopupWinManager;
	
	import views.spreadUI.MyAlert;
	import views.windows.functionWins.friendly.PlayerInfoView;
	
	public class ScoutPlayerManager
	{
		public var scoutPlayersList:ArrayCollection=new ArrayCollection();;
		public var scoutPlayerMap:Dictionary=new Dictionary();
		public var getPlayerCastlesHandleFunction:Function;
		
		public function ScoutPlayerManager(scoutPlayersArray:ArrayCollection)
		{
			for each(var scoutPlayerDataBean:ScoutPlayerBean in scoutPlayersArray) {
				this.addScoutPlayer(scoutPlayerDataBean);
			}
		}
		

		private function addScoutPlayer(bean:ScoutPlayerBean):void {
			this.scoutPlayerMap[bean.playerId] = bean;
		}
		
		public function getScoutPlayer(playerId:int):ScoutPlayerBean {
			return this.scoutPlayerMap[playerId] as ScoutPlayerBean;
		}
		
		
		//获取列 表
		 public function getScoutPlayersList():ArrayCollection{
        	scoutPlayersList.removeAll();
        	 for each(var key:* in scoutPlayerMap)
            {
            	if(key != null){
                scoutPlayersList.addItem(key);
                }
            }
            return scoutPlayersList;
        }
        
        
        //获取列表长度
        public function size():int{
            var length:int = 0;
            for each(var key:* in scoutPlayerMap)
            {
            	if(key != null){
                length++;}
            }
            return length;
        }

		//列表更新
		public function updateScoutPlayer(event:ScoutPlayerUpdate):void{
			if(event.updateType==GeneralConstants.UPDATE_ADD_TYPE){
				this.addScoutPlayer(event.bean);
			}else if(event.updateType==GeneralConstants.UPDATE_UPDATE_TYPE){
				this.scoutPlayerMap[event.bean.playerId]=event.bean;
			}else if(event.updateType==GeneralConstants.UPDATE_DELETE_TYPE){
				this.scoutPlayerMap[event.bean.playerId]=null;
			}
			EvtDispacther.instance.dispatchEvent(new ScoutPlayerChangeEvent(ScoutPlayerChangeEvent.SCOUTPLAYER_CHANGE,event.bean));
		}
		
		
		//使用间谍功能
		public function sendSpy(playerInfo:PlayerInfoDataBean):void{
			ControllerFactory.getInstance().getPlayerController().sendSpy(playerInfo.playerName,callback,false);
			function callback(event:CommonResponse):void{
				if(event.isSuccess()){
					PlayerInfoView.show(playerInfo,true);
				}else{
					MyAlert.showError(event);
				}
			}
		}
		
		//获取玩家城堡信息
		public function getPlayerCastles(playerId:int):void{
			ControllerFactory.getInstance().getPlayerController().getPlayerCastles(playerId,getPlayerCastlesCallback);
			function getPlayerCastlesCallback(event:PlayerCastleResponse):void{
				if(event.isSuccess()){
					if(getPlayerCastlesHandleFunction!=null){
						getPlayerCastlesHandleFunction.apply(this,[event.citysArray]);
						getPlayerCastlesHandleFunction=null;
					}
				}else{
					MyAlert.showError(event);
				}
			}
		}

	}
}
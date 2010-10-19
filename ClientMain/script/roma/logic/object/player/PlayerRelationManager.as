package roma.logic.object.player
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.GeneralConstants;
	import roma.common.constants.PlayerConstant;
	import roma.common.controller.CommonResponse;
	import roma.common.events.FriendRelationUpdate;
	import roma.common.valueObject.FriendRelationBean;
	import roma.logic.GameContext;
	import roma.message.EvtDispacther;
	import roma.message.events.PlayerRelationChangeEvent;
	import roma.util.MultiLang;
	
	import views.MainContainer;
	import views.spreadUI.MyAlert;
	
	public class PlayerRelationManager
	{
		//黑名单
		private var blocksArray:ArrayCollection = new ArrayCollection();
		//好友
		private var friendsArray:ArrayCollection = new ArrayCollection();
		
		public var friendsMap:Dictionary=new Dictionary();
		public var blocksMap:Dictionary=new Dictionary();
		public var blocksMapByName:Dictionary=new Dictionary();
		public function PlayerRelationManager(blocksArray:ArrayCollection,friendsArray:ArrayCollection)
		{
			if(blocksArray.length>0){
				for each(var blocksBean:FriendRelationBean in blocksArray) {
					this.addBlocks(blocksBean);
				}
			}
			if(friendsArray.length>0){
				for each(var friendsBean:FriendRelationBean in friendsArray) {
					this.addFriends(friendsBean);
				}
			}
		}
		//增加好友
		private function addFriends(bean:FriendRelationBean):void {
			this.friendsMap[bean.playerId] = bean;
		}
		
		//增加黑名单
		private function addBlocks(bean:FriendRelationBean):void {
			this.blocksMap[bean.playerId] = bean;
			this.blocksMapByName[bean.playerName] = bean;
		}
		
		//更新好友列表
		public function updatePlayerRelation(event:FriendRelationUpdate):void {
			if(event.updateType==GeneralConstants.UPDATE_UPDATE_TYPE){
				if(event.relationType==PlayerConstant.RELATION_FRIENDS){
					this.friendsMap[event.bean.playerId]=event.bean;
				}else if(event.relationType==PlayerConstant.RELATION_BLOCKS){
					this.blocksMap[event.bean.playerId]=event.bean;
					this.blocksMapByName[event.bean.playerName] = event.bean;
				}
			}else if(event.updateType==GeneralConstants.UPDATE_ADD_TYPE){
				if(event.relationType==PlayerConstant.RELATION_FRIENDS){
					this.addFriends(event.bean);
				}else if(event.relationType==PlayerConstant.RELATION_BLOCKS){
					this.addBlocks(event.bean);
				}
			}else if(event.updateType==GeneralConstants.UPDATE_DELETE_TYPE){
				if(event.relationType==PlayerConstant.RELATION_FRIENDS){
					this.friendsMap[event.bean.playerId]=null;
				}else if(event.relationType==PlayerConstant.RELATION_BLOCKS){
					if(this.blocksMap[event.bean.playerId]!=null){
						this.blocksMapByName[FriendRelationBean(this.blocksMap[event.bean.playerId]).playerName] = null;
					}
					this.blocksMap[event.bean.playerId]=null;
				}
			}
			EvtDispacther.instance.dispatchEvent(new PlayerRelationChangeEvent(PlayerRelationChangeEvent.PLAYERRELATION_CHANGE,event.bean));
		}
		
		public function getFriendsById(playId:int):FriendRelationBean {
			return this.friendsMap[playId];
		}
		
		public function getBlocksById(playId:int):FriendRelationBean {
			return this.blocksMap[playId];
		}
		
		//解除关系
		public function deletePlayer(playerId:int):void{
			ControllerFactory.getInstance().getFriendsController().deletePlayer(playerId,callback);
		}
		
		//增加名单
		public function addOrUpdatePlayerRelation(name:String,relationType:int):void{
			if(name!=GameContext.instance.getPlayerObj().getPlayerInfo().accountName){
				if(relationType==PlayerConstant.RELATION_FRIENDS){
					if(GameContext.instance.getPlayerObj().playerRelationManager.friendsArray.length<PlayerConstant.FRIENDS_LIMIT){
							ControllerFactory.getInstance().getFriendsController().addOrUpdatePlayerRelation(name,PlayerConstant.RELATION_FRIENDS,"",friendsCallback);
						}else{
							MyAlert.show(MultiLang.msg("friendly.error.freindsLimit"));
						}
						
					}
					if(relationType==PlayerConstant.RELATION_BLOCKS){
						if(GameContext.instance.getPlayerObj().playerRelationManager.friendsArray.length<PlayerConstant.BLOCKS_LIMIT){
							ControllerFactory.getInstance().getFriendsController().addOrUpdatePlayerRelation(name,PlayerConstant.RELATION_BLOCKS,"",blocksCallback);
						}else{
							MyAlert.show(MultiLang.msg("friendly.error.blocksLimit"));
						}
					}
				}else{
					MyAlert.show(MultiLang.msg("friends.isYourself"));
			}
			
			function friendsCallback(event:CommonResponse):void{
				if(event.isSuccess()){
					MainContainer.instance.risePlay(MultiLang.msg("friends.addFriendsSucess"));
				}else{
					MyAlert.showError(event);
				}
			}
			function blocksCallback(event:CommonResponse):void{
				if(event.isSuccess()){
					MainContainer.instance.risePlay(MultiLang.msg("friends.addBlocksSucess"));
				}else{
					MyAlert.showError(event);
				}
			}
		}
		
		public function blocksSize():int{
            var length:int = 0;
            for each(var key:* in this.blocksMap)
            {
            	if(key != null){
                length++;}
            }
            return length;
        }
        
        public function getBlocksList():ArrayCollection{
        	this.blocksArray.removeAll();
        	 for each(var key:* in this.blocksMap)
            {
            	if(key != null){
                this.blocksArray.addItem(key);
                }
            }
            return this.blocksArray;
        }
        
        public function friendsSize():int{
            var length:int = 0;
            for each(var key:* in this.friendsMap)
            {
            	if(key != null){
                length++;}
            }
            return length;
        }
        
        public function getFriendsList():ArrayCollection{
        	this.friendsArray.removeAll();
        	 for each(var key:* in this.friendsMap)
            {
            	if(key != null){
                this.friendsArray.addItem(key);
                }
            }
            return this.friendsArray;
        }
		
		private function callback(event:CommonResponse):void{
			if(event.isSuccess()){
				
			}else{
				MyAlert.showError(event);
			}
		}
		
		public function getBlocksByName(playName:String):FriendRelationBean {
			return this.blocksMapByName[playName];
		}
	}
}
			import flash.events.MouseEvent;
			import flash.events.TimerEvent;
			import flash.geom.Point;
			import flash.utils.Timer;
			
			import mx.collections.ArrayCollection;
			import mx.core.Application;
			import mx.events.ItemClickEvent;
			import mx.events.ListEvent;
			import mx.logging.ILogger;
			import mx.logging.Log;
			
			import roma.common.action.ControllerFactory;
			import roma.common.constants.PlayerConstant;
			import roma.common.controller.friends.RelationPlayerInfoResponse;
			import roma.common.valueObject.FriendRelationBean;
			import roma.logic.GameContext;
			import roma.message.EvtDispacther;
			import roma.message.events.PlayerRelationChangeEvent;
			
			import views.spreadUI.MyAlert;
			import views.spreadUI.popups.PopupContainer;
			import views.spreadUI.tips.PlayerInfoTip;
			import views.spreadUI.tips.ToolTipContainer;
			import views.windows.functionWins.friendly.FriendsPopupBox;
			public static const WINDOW_SHOW:String = "friendlyWin.show";
			[Bindable]
			private var cur_page:int=0;
			[Bindable]
			private var total_page:int=0;
			
			private var pageSize:int = 10;
			[Bindable]
			private var enemyArray:ArrayCollection=new ArrayCollection();
			[Bindable]
			private var friendsArray:ArrayCollection=new ArrayCollection();
			[Bindable]
			private var curMemberArr:ArrayCollection=new ArrayCollection();
			[Bindable]
			private var curShowIndex:int;
			
            private var point1:Point = new Point();
            private var playerInfo:FriendRelationBean;
            
            private var time:Timer=new Timer(1000);
            private var timeCount:int=0;
            private var curFriend:FriendRelationBean;
            
            private var friendsPopupBox:FriendsPopupBox;

			private var playerInfoTip:PlayerInfoTip = ToolTipContainer.instance.playerInfoTip;
			
			private var isClose:Boolean=true;
			
			
			private static var log:ILogger = Log.getLogger("views.windows.functionWins.friendly.FriendlyWin");
			/**
			 *每次界面弹出调用，刷新数据
			 */ 
			override public function refresh():void{
				this.mouseChildren=true;
				this.mouseEnabled=true;
				this.isClose=false;
				if(this.initialized)
				{
					memberViewstack.selectedIndex=buttonBar.selectedIndex=0;
					this.addPeopleWin.visible=false;
				}
				this.curShowIndex=0;
				this.getDataArr();
				this.countPage();
//				this.showData(1);
			}
			
			private function getDataArr():void{
				this.enemyArray.removeAll();
				this.friendsArray.removeAll();
				this.friendsArray=GameContext.instance.getPlayerObj().playerRelationManager.getFriendsList();
				this.enemyArray=GameContext.instance.getPlayerObj().playerRelationManager.getBlocksList();
			}
			
			/**
			 * 界面隐藏调用，停止当前窗体一切相关动画等
			 */ 
			override public function destroy():void{
				if(this.time.running){
					this.time.stop();
				}
				this.isClose=true;
				this.playerInfoTip.visible=false;
				this.playerInfoTip.includeInLayout=false;
				this.mouseChildren=false;
				this.mouseEnabled=false;
			}
			
			private function init():void
			{
				memberViewstack.selectedIndex=buttonBar.selectedIndex=0;
				this.curShowIndex=0;
				EvtDispacther.instance.addEventListener(PlayerRelationChangeEvent.PLAYERRELATION_CHANGE,updateWin);
				this.time.addEventListener(TimerEvent.TIMER,timerHandle);
				this.friendsPopupBox = PopupContainer.instance.friendsPopupBox;
			}
			
			
			private function updateWin(event:PlayerRelationChangeEvent):void{
				this.getDataArr();
				this.countPage();
//				this.showData(1);
			}
			
			//计算页数
			private function countPage():void{
				if(this.curShowIndex==0){
					if(friendsArray.length>0){
						cur_page=1;
						total_page=Math.ceil(friendsArray.length/pageSize);
						showData(cur_page);
					}else{
						cur_page=0;
						total_page=0;
						this.curMemberArr.removeAll();
					}
				}
				if(this.curShowIndex==1){
					if(enemyArray.length>0){
						cur_page=1;
						total_page=Math.ceil(enemyArray.length/pageSize);
						showData(cur_page);
					}else{
						cur_page=0;
						total_page=0;
						this.curMemberArr.removeAll();
					}
				}
				
			}
			
			
			private function showData(page:int):void{
				this.curMemberArr.removeAll();
				if(this.curShowIndex==0){
					if(this.friendsArray.length>0){
						var end:int=page*this.pageSize>this.friendsArray.length?this.friendsArray.length:page*this.pageSize;
						for(var i:int=(page-1)*this.pageSize;i<end;i++){
							this.curMemberArr.addItem(this.friendsArray[i]);
						}	
					}
				}else{
					if(this.enemyArray.length>0){
					var endApply:int=page*this.pageSize>this.enemyArray.length?this.enemyArray.length:page*this.pageSize;
						for(var j:int=(page-1)*this.pageSize;j<enemyArray.length;j++){
							this.curMemberArr.addItem(this.enemyArray[j]);
						}		
					}	
				}
			}
			
			private function tbClick(event:ItemClickEvent):void {
				this.memberViewstack.selectedIndex=event.index;
				this.curShowIndex=event.index;
				this.countPage();
				
			}
			
			//显示玩家信息
			private function showPlayerInfoTip(event:ListEvent):void{
				if(event.itemRenderer.data==null){
					this.playerInfoTip.visible=false;
					this.playerInfoTip.includeInLayout=false;
					return;
				}

				if(curFriend!=null){
					if(this.curFriend.playerId!=FriendRelationBean(event.itemRenderer.data).playerId){
						this.curFriend=FriendRelationBean(event.itemRenderer.data);
						if(this.time.running){
							this.timeCount=0;
						}else{
							this.time.start();						
						}
					}else{
						this.playerInfoTip.x=705;
						this.playerInfoTip.y = Application.application.mouseY;
						this.playerInfoTip.visible=true;
						this.playerInfoTip.includeInLayout=true;
					}
				}else{
					this.curFriend=FriendRelationBean(event.itemRenderer.data);
					if(this.time.running){
						this.timeCount=0;
					}else{
						this.time.start();						
					}
				}
			}
			
			private function timerHandle(event:TimerEvent):void{
				timeCount++;
				if(timeCount==1&&this.visible==true){
					timeCount=0;
					ControllerFactory.getInstance().getFriendsController().getRelationPlayerInfo(this.curFriend.playerId,playerInfoCallback,false);
					this.time.stop();
				}
				function playerInfoCallback(evt:RelationPlayerInfoResponse):void{
					if(evt.isSuccess()){
						if(isClose){
							playerInfoTip.visible=false;
							playerInfoTip.includeInLayout=false;
						}else{
							playerInfoTip.x=705;
							playerInfoTip.y = Application.application.mouseY;
							playerInfoTip.show(evt.bean);
							playerInfoTip.visible=true;
							playerInfoTip.includeInLayout=true;
						}
					}else{
						MyAlert.showError(evt);
					}
				}
			}
			
			
			
			
			//隐藏玩家信息
			private function itemRollOutHandle():void{
		   		this.playerInfoTip.visible=false;
		   		this.playerInfoTip.includeInLayout=false;
		    }
			

			
			//显示选中的页数
			private function turnPage(p:int):void{
				var n:int = cur_page;
				cur_page += p;
				if (cur_page >=1 && cur_page <= total_page) {
					showData(cur_page);
				} else {
					cur_page = n;
				}
			}
			
			
			
			//显示添加名单界面
			private function showAddPeopleWin():void{
				if(this.curShowIndex==0){
					this.addPeopleWin.relationType=PlayerConstant.RELATION_FRIENDS;
				}
				if(this.curShowIndex==1){
					this.addPeopleWin.relationType=PlayerConstant.RELATION_BLOCKS;
				}
				this.addPeopleWin.refresh();
				this.addPeopleWin.visible=true;
			}
			
			
			//增加名单
			private function addHandle(name:String,relationType:int):void{
				GameContext.instance.getPlayerObj().playerRelationManager.addOrUpdatePlayerRelation(name,relationType);
			}
			
			//解除关系
			private function deleteHandle(playerId:int):void{
				GameContext.instance.getPlayerObj().playerRelationManager.deletePlayer(playerId);
			}
			

			public function showMenu(event:MouseEvent,data:Object):void {
				this.playerInfo=FriendRelationBean(data);
				this.friendsPopupBox.show(this.playerInfo,this.curShowIndex);
				point1.x=event.currentTarget.mouseX;
                point1.y=event.currentTarget.mouseY;                
                point1=event.currentTarget.localToGlobal(point1);
		        this.friendsPopupBox.setPos(point1.x - this.friendsPopupBox.width,point1.y);
		        stage.addEventListener(MouseEvent.MOUSE_DOWN,onStageClick);
            }

         	private function onStageClick(event:MouseEvent):void{
				if(friendsPopupBox.hitTestPoint(event.stageX,event.stageY)){
					return;
				}
				else{
					friendsPopupBox.remove();
				}
				stage.removeEventListener(MouseEvent.MOUSE_DOWN,onStageClick);
			}

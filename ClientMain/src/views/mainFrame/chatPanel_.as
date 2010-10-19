	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.xml.XMLDocument;
	
	import mx.collections.ArrayCollection;
	import mx.controls.TextArea;
	import mx.events.FlexEvent;
	import mx.events.ScrollEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.managers.IFocusManagerComponent;
	import mx.utils.StringUtil;
	import mx.utils.XMLUtil;
	
	import roma.common.ResponseEvtDispatcher;
	import roma.common.action.ControllerFactory;
	import roma.common.constants.ChatConstant;
	import roma.common.constants.FieldConstant;
	import roma.common.constants.PlayerConstant;
	import roma.common.controller.CommonResponse;
	import roma.common.controller.army.ScoutNpcFieldResponse;
	import roma.common.events.AllianceRelationEvent;
	import roma.common.events.ChatMsg;
	import roma.common.events.FreeSentenceTimeUpdate;
	import roma.common.valueObject.FriendRelationBean;
	import roma.common.valueObject.TypeNpcIdsBean;
	import roma.data.MapTileData;
	import roma.logic.GameContext;
	import roma.logic.object.chat.ChatError;
	import roma.logic.object.chat.ExpressionBean;
	import roma.logic.object.chat.WordFilters;
	import roma.logic.object.player.ItemResManager;
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.ItemRule;
	import roma.message.EvtDispacther;
	import roma.message.events.ChatCallEvent;
	import roma.message.events.MsgEvent;
	import roma.message.events.PrivateChatEvent;
	import roma.message.events.PublicEvent;
	import roma.message.events.TroopCampaignEvent;
	import roma.util.InputTextHelper;
	import roma.util.MultiLang;
	
	import views.MainContainer;
	import views.PopupWindows;
	import views.mainFrame.ToggleButton;
	import views.mainModules.map.diamond2.DiamondWorldMap2;
	import views.spreadUI.MyAlert;
	import views.spreadUI.chat.ChatPopupBox;
	import views.spreadUI.popups.PopupContainer;
	import views.windows.functionWins.alliance.AllianceEventResolveLabel;
	import views.windows.functionWins.hero.HeroHelper;
	import views.windows.functionWins.hero.HerosMansionWin;
	import views.windows.functionWins.shop.Shop;
	
	private static const TYPE_WORLD_CHAT:String = "typeWorldChat";
	private static const TYPE_ALLIANCE_CHAT:String = "typeAllianceChat";
	private static const TYPE_BEGINNER_CHAT:String = "typeBeginnerChat";
	private static const TYPE_DEAL_CHAT:String = "typeDealChat";
	public static const MAX_CHAT_length:int = 100;                       // 聊天记录最大
	
	private var log:ILogger = Log.getLogger("views.mainFrame.ChatPanel");
	
	private var replyStr:String=MultiLang.msg("public.label.reply");

    private var channelType:int = 1;
    [Bindable]
    private var chat_type:String = "typeWorldChat";
    
   	[Bindable]
    private var tallRecordArray:ArrayCollection = new ArrayCollection();
    [Bindable]
    private var chatHtmlMsg:String = "";                //聊天的显示
    private var lastestWord:String = "";                   // 最后一句话，便于比较

    private var publicChatList:ArrayCollection = new ArrayCollection();
    private var allianceChatList:ArrayCollection = new ArrayCollection();
    private var secretChatList:ArrayCollection = new ArrayCollection(); 
    private var beginnerChatList:ArrayCollection = new ArrayCollection(); 
    private var dealChatList:ArrayCollection = new ArrayCollection(); 
    private var zoneChatList:ArrayCollection = new ArrayCollection(); 
    private var systemList:ArrayCollection = new ArrayCollection();
    
    private var curChannel:int = 0;
    [Bindable]
    private var curSelectBtn:String;
    
    private var chatPopupBox:ChatPopupBox;
    
    public static var instance:ChatPanel;
    
    private var freeTimer:Timer = new Timer(1000);
    private var canChatFree:Boolean = false;
    private var lastTime:Number = GameContext.instance.getPlayerObj().getPlayerInfo().lastFreeSentenceTime;
    [Bindable]
    private var remainTime:Number = 0;
    [Bindable]
    private var itemManager:ItemResManager = GameContext.instance.getPlayerObj().itemManager;
    [Bindable]
    private var speakerCount:int = 0;
    
    private var showTimer:Timer = new Timer(500);
    
    private var isShowFreeSpeakTips:Boolean = true;
    private static var LIMIT_TIME_NUM:int = 3;
    private var limitCount:int = 0;
	private var wordListLength:int = 0;
		    
    private function init():void{
    	this.systemManager.addEventListener(MouseEvent.MOUSE_WHEEL,onChatMouseWheel);
    	instance = this;
		ResponseEvtDispatcher.getInstance().addEventListener(ResponseEvtDispatcher.SERVER_CHAT_MSG , onCharMsg);
		EvtDispacther.instance.addEventListener(PrivateChatEvent.EVENT_NAME,privateChatHandle);
        EvtDispacther.instance.addEventListener(EvtDispacther.FREE_CENTENCE_TIME,onFreeCentenceTime);
        EvtDispacther.instance.addEventListener(TroopCampaignEvent.TROOP_CAMPAIGN,sendTroopMsg);
        EvtDispacther.instance.addEventListener(ChatCallEvent.CHAT_CALL,onOtherCallChat);
        EvtDispacther.instance.addEventListener(ChatCallEvent.TYPE_ALLIANCE,onOtherCallChat);
        EvtDispacther.instance.addEventListener(EvtDispacther.NEW_SYSTEM_MSG , onNewSystemMsg);
        EvtDispacther.instance.addEventListener(EvtDispacther.GM_FORBID_TALK,onGmForbidTalk);
        EvtDispacther.instance.addEventListener(EvtDispacther.TRAINROOM_REPORT,onTrainRoomReport);
        EvtDispacther.instance.addEventListener(EvtDispacther.NPC_ADD_CHANGE,npcRefreshNotice);
        EvtDispacther.instance.addEventListener(EvtDispacther.SYS_HOST_BEATTACK,onSysHostBeAttack);
        EvtDispacther.instance.addEventListener(EvtDispacther.SYS_ANNOUNCE_REPORT,announceReport);
        
		this.addEventListener(TextEvent.LINK, linkClickHandler);
        this.addEventListener(KeyboardEvent.KEY_DOWN,onKeyHandle);

        chatPopupBox = PopupContainer.instance.chatPopupBox;
        freeTimer.addEventListener(TimerEvent.TIMER,onFreeTime);
        freeTimer.start();
        showTimer.addEventListener(TimerEvent.TIMER,onShowText);
        showTimer.start();
        
        timePercentShape.graphics.beginFill(0xfff45c,.5);
        timePercentShape.graphics.drawRoundRect(0,0,timePercentShape.width,timePercentShape.height,1,1);
        timePercentShape.scaleX = 1-remainTime/(1000*60*5);
        
        publicChatList.addItem("<b><font color='#d60000'>"+MultiLang.msg('chat.system.lable') +" "+ MultiLang.msg('chat.privateChat.tips')+"</font></b>");
        allianceChatList.addItem("<b><font color='#d60000'>"+MultiLang.msg('chat.system.lable') +" "+ MultiLang.msg('chat.privateChat.tips')+"</font></b>");
        secretChatList.addItem("<b><font color='#d60000'>"+MultiLang.msg('chat.system.lable') +" "+ MultiLang.msg('chat.privateChat.tips')+"</font></b>");
        systemList.addItem("<b><font color='#d60000'>"+MultiLang.msg('chat.systemChannelTips')+"</font>");
        
        this.curChannel = ChatConstant.TYPE_WORLD_CHAT;
        curSelectBtn = "worldChat_btn";
        showChatMsg();
        speakerCount = itemManager.getMaterialBeanById(ChatConstant.WORLD_CHAT_ITEM)==null?0:itemManager.getMaterialBeanById(ChatConstant.WORLD_CHAT_ITEM).count;
        this.swapBtn.toolTip=MultiLang.msg("chat.resizeBtnTip.expand");
        
        limitCount = LIMIT_TIME_NUM*1000/500;
    }
    
    private function sendChatMsg():void {
		var chatStr:String = StringUtil.trim(chatTextInput.text);
		if (chatStr.length < 1) {
				if(chat_type == TYPE_WORLD_CHAT){
					publicChatList.addItem(ChatError.showErrorMes(ChatError.MSG_ISEMPTY_ERROR));
				}else if(chat_type == TYPE_ALLIANCE_CHAT){
					publicChatList.addItem(ChatError.showErrorMes(ChatError.MSG_ISEMPTY_ERROR));
					allianceChatList.addItem(ChatError.showErrorMes(ChatError.MSG_ISEMPTY_ERROR));
				}
			} else {
				var msgArr:Array = splitString(chatStr);
				if(msgArr.length>0){
					//这个时候是私聊
					var privateName:String=msgArr[0];
					if (privateName.toLocaleLowerCase() == GameContext.instance.getPlayerObj().getPlayerInfo().playerName.toLocaleLowerCase()) {
						publicChatList.addItem(ChatError.showErrorMes(ChatError.SAY_WITH_YOURSELF_ERROR));
						secretChatList.addItem(ChatError.showErrorMes(ChatError.SAY_WITH_YOURSELF_ERROR));
						allianceChatList.addItem(ChatError.showErrorMes(ChatError.SAY_WITH_YOURSELF_ERROR));
					}else{
						if(StringUtil.trim(msgArr[1]).length<1){
							publicChatList.addItem(ChatError.showErrorMes(ChatError.MSG_ISEMPTY_ERROR));
							secretChatList.addItem(ChatError.showErrorMes(ChatError.MSG_ISEMPTY_ERROR));
							allianceChatList.addItem(ChatError.showErrorMes(ChatError.MSG_ISEMPTY_ERROR));
						}
						ControllerFactory.getInstance().getChatController().chat(ChatConstant.TYPE_PRIVATE_CHAT,msgArr[1],privateName,onPrivateCallBack);
						repeatFilter("/"+privateName + " " +msgArr[1]);
					}
				}
				else{
						var msgW:String = "<b>["+GameContext.instance.getPlayerObj().getPlayerInfo().playerName+"]:</b>"+" "+chatStr;
						if (chat_type == TYPE_WORLD_CHAT) {
							if(canChatFree){
								ControllerFactory.getInstance().getChatController().chat(ChatConstant.TYPE_WORLD_CHAT,chatStr,null,onWorldCallBack);
								canChatFree = false;
							}
							else{
								var im:ItemResManager = GameContext.instance.getPlayerObj().itemManager;
								log.debug("getMaterialBeanById "+im.getMaterialBeanById(ChatConstant.WORLD_CHAT_ITEM) );
								if(limitCount<LIMIT_TIME_NUM*1000/500){
									publicChatList.addItem(ChatError.showErrorMes(ChatError.TIME_LIMIT_ERROR));
									return;
								}
								var strTemp:String = MultiLang.msg('chat.fontColor.forWorld')+"[<b>"+GameContext.instance.getPlayerObj().getPlayerInfo().playerName+"</b>]:"+" " +chatStr+"</font>";
								if(strTemp == publicChatList[publicChatList.length-1]){
									publicChatList.addItem(ChatError.showErrorMes(ChatError.MSG_REPEAT_ERROR));
									return;
								}
								if(im.getMaterialBeanById(ChatConstant.WORLD_CHAT_ITEM) != null && im.getItemCount(ChatConstant.WORLD_CHAT_ITEM)>0){
									ControllerFactory.getInstance().getChatController().chat(ChatConstant.TYPE_WORLD_CHAT,chatStr,null,onWorldCallBack);
								}
								else{
									publicChatList.addItem(ChatError.showErrorMes(ChatError.HASNOEnough_SPEAKER));
									return;
								}
							}
						} else if (chat_type == TYPE_ALLIANCE_CHAT) {
							if(GameContext.instance.getPlayerObj().hasAlliance()){
								ControllerFactory.getInstance().getChatController().chat(ChatConstant.TYPE_ALLIANCE_CHAT,chatStr,null,onAllianceCallBack);
							}
							else{
								publicChatList.addItem(ChatError.showErrorMes(ChatError.NOT_JOIN_ALLIANCE));
								allianceChatList.addItem(ChatError.showErrorMes(ChatError.NOT_JOIN_ALLIANCE));
							}
						} else{
							new Error("there is no chat_type");
						}
						repeatFilter(chatStr);
				}
				
			}
		chatTextInput.text="";
	}
	
	 private function sendTroopMsg(event:TroopCampaignEvent):void {
		var str:String="";
		var troopCampaignData:MapTileData = event.troopCampaignData;
		str=WordFilters.SIGN_BATTLE
				 +GameContext.instance.getPlayerObj().getPlayerInfo().playerName+"."
				 +troopCampaignData.fieldName+"."
				 +troopCampaignData.getFieldId()+"."
				 +troopCampaignData.canAttack+"."
				 +troopCampaignData.canTransport+"."
				 +troopCampaignData.canReinforce+"."
				 +troopCampaignData.missionType+"."
				 +troopCampaignData.arrivedTime+"."
				 +troopCampaignData.battleId+".";
					
		if (event.showType == ChatConstant.TYPE_ALLIANCE_CHAT) {
			if(GameContext.instance.getPlayerObj().hasAlliance()){
				ControllerFactory.getInstance().getChatController().chat(ChatConstant.TYPE_ALLIANCE_CHAT,str,null,onAllianceCallBack);
			}
			else{
				publicChatList.addItem(ChatError.showErrorMes(ChatError.NOT_JOIN_ALLIANCE));
				allianceChatList.addItem(ChatError.showErrorMes(ChatError.NOT_JOIN_ALLIANCE));
			}
		}
		else if(event.showType == ChatConstant.TYPE_PRIVATE_CHAT){
			// 私聊，即发给所有好友
			for each(var p:FriendRelationBean in GameContext.instance.getPlayerObj().playerRelationManager.getFriendsList()){
				ControllerFactory.getInstance().getChatController().chat(ChatConstant.TYPE_PRIVATE_CHAT,str,
					p.playerName,onPrivateCallBack,false);
			}
		}
	}
	
	private function onOtherCallChat(event:ChatCallEvent):void{
		var str:String = event.eventData;
		switch(event.showType){
			case ChatCallEvent.TYPE_ALLIANCE:
				ControllerFactory.getInstance().getChatController().chat(ChatConstant.TYPE_ALLIANCE_CHAT,str,null,onAllianceCallBack);
			break;
			case ChatCallEvent.TYPE_WORLD:
				ControllerFactory.getInstance().getChatController().chat(ChatConstant.TYPE_WORLD_CHAT,str,null,onWorldCallBack);
			break;
			case ChatCallEvent.TYPE_PRIVATE:
			break;
		}
	}
	
    /**
    * 聊天返回
    */ 
    private function onCharMsg(event:ChatMsg):void{
    	if(GameContext.instance.isScreenShield(event.fromPlayer)){
    		return;
    	}
    	if(GameContext.instance.getPlayerObj().playerRelationManager.getBlocksByName(event.fromPlayer)!=null){
    		return;
    	}
    	var str:String = "";
    	var msgStr:String = "";
		msgStr = WordFilters.instance.positionAnalyse(event.massage);
		msgStr = WordFilters.instance.apartArmyData(msgStr);
		msgStr = WordFilters.instance.itemsSign(msgStr);
    	switch(event.channel){
    		case ChatConstant.TYPE_FRESHMAN_CHAT:
    			beginnerChatList.addItem(MultiLang.msg('chat.fontColor.forWorld')+"[<u><b><a href=\""+"event:"+event.fromPlayer+"\">"+event.fromPlayer+"</a></b></u>]:" +" "+ event.massage+"</font>");
    		break;
    		case ChatConstant.TYPE_PRIVATE_CHAT:
    			if(event.fromPlayer == GameContext.instance.getPlayerObj().getPlayerInfo().playerName){
        			str = "<font color='#a3009d'>[<b>"+MultiLang.msg('chat.youSayTo{0}',"<u><a href=\""+"event:"+event.toPlayer+"\">"+event.toPlayer+"</a></u></b>]")+": " +" "+ msgStr+"</font>";
    			}else{
    				str = "<font color='#a3009d'>[<b>" + MultiLang.msg('chat.sayToYou{0}',"<u><a href=\""+"event:"+event.fromPlayer+"\">"+event.fromPlayer+"</a></u>]")+"</b>: " +" "+ msgStr+"</font>"+setReplyString(event.fromPlayer);
    			}
    			secretChatList.addItem(str);
        		publicChatList.addItem(str);
        		allianceChatList.addItem(str);	
    		break;
    		case ChatConstant.TYPE_WORLD_CHAT:
    			if(event.fromPlayer == GameContext.instance.getPlayerObj().getPlayerInfo().playerName){
    				str = MultiLang.msg('chat.fontColor.forWorld')+"[<b>"+event.fromPlayer+"</b>]:"+" " +msgStr+"</font>";
    			}else{
    				if(event.gm){
    					str = "<font color='#f65d00'><b>["+event.fromPlayer+"]:"+" " + msgStr+"</b></font>";
    				}
    				else{
    					str = MultiLang.msg('chat.fontColor.forWorld')+"[<u><b><a href=\""+"event:"+event.fromPlayer+"\">"+event.fromPlayer+"</a></b></u>]:"+" " + msgStr+"</font>";
    				}
    			}
    			publicChatList.addItem(str);
    		break;
    		case ChatConstant.TYPE_ALLIANCE_CHAT:
    			if(event.fromPlayer == GameContext.instance.getPlayerObj().getPlayerInfo().playerName){
    				str = "<font color='#007700'>[<b>"+event.fromPlayer+"</b>]:" +" "+ msgStr+"</font>";
    			}else{
        			str = "<font color='#007700'>[<u><b><a href=\""+"event:"+event.fromPlayer+"\">"+event.fromPlayer+"</a></b></u>]:" +" "+ msgStr+"</font>";
    			}
				publicChatList.addItem(str);
    			allianceChatList.addItem(str);
    		break;
    		case ChatConstant.TYPE_DEAL_CHAT:
    			dealChatList.addItem("<font color='#4e671f'>[<u><b><a href=\""+"event:"+event.fromPlayer+"\">"+event.fromPlayer+"</a></b></u>]:" +" "+ event.massage+"</font>");
    		break;
    		case ChatConstant.TYPE_ZONE_CHAT:
    			zoneChatList.addItem(MultiLang.msg('chat.fontColor.forWorld')+"[<u><b><a href=\""+"event:"+event.fromPlayer+"\">"+event.fromPlayer+"</a></b></u>]:" +" "+ event.massage+"</font>");
    		break;
    		case ChatConstant.TYPE_SYSTEM_CHAT:
    			publicChatList.addItem("<b><font color='#ff0000'>[<u><a href=\""+"event:"+event.fromPlayer+"\">"+event.fromPlayer+"</a></b></u>]:" +" "+ event.massage+"</font></b>");
    			allianceChatList.addItem("<b><font color='#ff0000'>[<u><a href=\""+"event:"+event.fromPlayer+"\">"+event.fromPlayer+"</a></b></u>]:" +" "+ event.massage+"</font></b>");
    			secretChatList.addItem("<b><font color='#ff0000'>[<u><a href=\""+"event:"+event.fromPlayer+"\">"+event.fromPlayer+"</a></u>]:" +" "+ event.massage+"</font></b>");
    			systemList.addItem("<b><font color='#ff0000'>[<u><a href=\""+"event:"+event.fromPlayer+"\">"+event.fromPlayer+"</a></u>]:" +" "+ event.massage+"</font></b>");
    		break;
    	}
    }
    
    
    //增加回复后缀
    private function setReplyString(player:String):String{
    	return "<font color='#0063bf'><i><a href=\""+"event:"+"reply."+player+"\">"+" ("+replyStr+")"+"</a></i>"+"</font>";
    }
    
     /**
     *添加gm禁止公告
     */    
    public function onGmForbidTalk(event:MsgEvent):void{
    	var targetXml:XMLDocument = XMLUtil.createXMLDocument(String(event.data));
		var raffleStr:String = "<font color='#ff0000'>" + MultiLang.msg("chat.GmForbidTalk.tip",targetXml.firstChild.attributes.playerName,targetXml.firstChild.attributes.secs)+"</font>";
		publicChatList.addItem(raffleStr);
    }
    
    
     /**
     *添加训练场战斗公告
     */    
    public function onTrainRoomReport(event:MsgEvent):void{
    	var targetXml:XMLDocument = XMLUtil.createXMLDocument(String(event.data));
		var raffleStr:String = ChatNotice.instance.parseTrainRoomReport(XMLList(targetXml.firstChild.firstChild));
		publicChatList.addItem(raffleStr);
    }
    
    /**
    * 报告的通告
    */ 
    private function announceReport(event:MsgEvent):void{
		var targetXml:XMLDocument = XMLUtil.createXMLDocument(String(event.data));
		var amStr:String = ChatNotice.instance.parseArmyMoveReport(String(targetXml.firstChild.firstChild));
		publicChatList.addItem("<font color='#ff0000'>"+amStr+"</font>");
    }
    
    /**
    * 宗主城被打报告
    */
    private function onSysHostBeAttack(event:MsgEvent):void{
	    var str:String = ChatNotice.instance.parseSysHostBeAttack(String(event.data));
		publicChatList.addItem(str);
	}
    
    /**
    *添加npc刷新公告
    */  
    
    private var npcRreshTimer:Timer=new Timer(1000);
    private var npcRreshCount:int=0;
    private var npcRreshArr:ArrayCollection=new ArrayCollection();
    private var npcSendingEvent:Boolean=false;
    private function npcRefreshNotice(event:MsgEvent):void{
    	npcRreshCount++;
    	npcRreshArr.addItem(event.data);
    	if(npcRreshCount>0){
    		if(npcRreshTimer.running){
    			
    		}else{
	    		npcRreshTimer.addEventListener(TimerEvent.TIMER,npcRreshTimerHandle);
	    		npcRreshTimer.start();
    		}
    	}
    	
    	
    	
    }
    
    private function npcRreshTimerHandle(event:TimerEvent):void{
    	if(npcSendingEvent)return;
    	if(npcRreshArr.length>0){
    		var bean:TypeNpcIdsBean=TypeNpcIdsBean(npcRreshArr.getItemAt(0));
	    	if(bean.type==FieldConstant.TYPE_NPC_FIELD){
	    		npcSendingEvent=true;
				ControllerFactory.getInstance().getArmyController().scoutNpcField(int(bean.npcFieldIdsArray.getItemAt(0)),onMapResponse,false);	
	    	}else if(bean.type==14){
		    	npcSendingEvent=true;
		    	ControllerFactory.getInstance().getArmyController().scoutNpcField(int(bean.npcFieldIdsArray.getItemAt(0)),onRatterMapResponse,false);	
    		}
    	}else{
    		this.npcRreshTimer.stop();
    		npcRreshTimer.removeEventListener(TimerEvent.TIMER,npcRreshTimerHandle);
    	}
    	
	 	function onMapResponse(event:ScoutNpcFieldResponse):void {
			npcSendingEvent=false;
			if(event.isSuccess()){	
				publicChatList.addItem("<font color='#ff0000'>" +MultiLang.msg("chat.trainRoomRefreshNotice",event.bean.total)+"</font>");
				npcRreshArr.removeItemAt(0);
				npcRreshCount--;
			}
	 	}
	 	function onRatterMapResponse(event:ScoutNpcFieldResponse):void {
			npcSendingEvent=false;
			if(event.isSuccess()){	
				publicChatList.addItem("<font color='#ff0000'>" +MultiLang.msg("chat.ratterNpcRefreshNotice",event.bean.total)+"</font>");
				npcRreshArr.removeItemAt(0);
				npcRreshCount--;
			}
	 	}
    	
    }

    
    /**
     *添加玩家中奖信息到系统框、世界聊天框 
     */    
    public function addotherRaffleAnnounce(str:String):void{
    	var msgStr:String = "";
    	msgStr = WordFilters.instance.itemsSign(str);
    	var raffleStr:String = "<font color='#8c4600'>" + msgStr+"</font>";
		systemList.addItem(raffleStr);
		publicChatList.addItem(raffleStr);
    }
    
    /**
     *添加自己转到的物品信息到系统框
     */    
    public function addOwnRaffleAnnounce(str:String):void{
    	var msgStr:String = "";
    	msgStr = WordFilters.instance.itemsSign(str);
    	var raffleStr:String = "<font color='#d60000'>" + msgStr+"</font>";
		systemList.addItem(raffleStr);
		publicChatList.addItem(raffleStr);
    }
    
    //在世界和联盟频道显示信息
    public function showNoitceToWorldAndAlliance(event:AllianceRelationEvent):void{
		var str:String=MultiLang.msg("alliance.relationChange",event.fromAlliance,event.toAlliance,AllianceEventResolveLabel.getLeagueRelation(event.relation));
		var worldStr:String= MultiLang.msg('chat.fontColor.forWorld')+str+"</font>";
		publicChatList.addItem(worldStr);
		var myAllianceName:String=GameContext.instance.getPlayerObj().getPlayerInfo().leagueName;
		if(myAllianceName==event.fromAlliance||myAllianceName==event.toAlliance){
			var allianceStr:String="<font color='#007700'>"+ str+"</font>";
			allianceChatList.addItem(allianceStr);
		}
    }
    
    /**
    * 私聊发送返回信息 
    */ 
    private function onPrivateCallBack(event:CommonResponse):void{
    	if(event.isSuccess()){
		}else{
			MyAlert.showError(event);
		}
    }
    /**
    * 世界聊天发送返回信息
    */ 
    private function onWorldCallBack(event:CommonResponse):void{
    	if(event.isSuccess()){
    		speakerCount = itemManager.getMaterialBeanById(ChatConstant.WORLD_CHAT_ITEM)==null?0:itemManager.getMaterialBeanById(ChatConstant.WORLD_CHAT_ITEM).count;
    		limitCount = 0;
    	}
    	else{
			MyAlert.showError(event);
		}
    }
    
    /**
    * 联盟聊天发送返回信息
    */ 
    private function onAllianceCallBack(event:CommonResponse):void{
    	if(event.isSuccess()){
		}else{
			MyAlert.showError(event);
		}
    }
    
    /**
    * 新手聊天发送返回信息
    */ 
    private function onBeginnerCallBack(event:CommonResponse):void{
    	if(event.isSuccess()){
		}else{
			MyAlert.showError(event);
		}
    }
    
    /**
    * 交易聊天发送返回信息
    */ 
    private function onDealCallBack(event:CommonResponse):void{
    	if(event.isSuccess()){
		}else{
			MyAlert.showError(event);
		}
    }
 
    /**
    * 区域聊天发送返回信息
    */ 
    private function onZoneCallBack(event:CommonResponse):void{
    	if(event.isSuccess()){
		}else{
			MyAlert.showError(event);
		}
    }
    
    /**
    * 聊天框的玩家文字的链接
    */ 
    private var linkText:String = "";
    private function linkClickHandler(linkEvent:TextEvent):void{
    	if(linkEvent.text.indexOf(WordFilters.SIGN_BATTLE_LINK)>-1){
    		if(WordFilters.instance.armyTroopDictionary[linkEvent.text]!=null){
				var mapTileData:MapTileData = MapTileData(WordFilters.instance.armyTroopDictionary[linkEvent.text]);
				mapTileData.isJoin = true;
				HeroHelper.instance.targetMapTileData=mapTileData;
				PopupWindows.openFuncWin(HerosMansionWin.WINDOW_SHOW_CAMPAIGN);
				/* PopupWindows.openFuncWin(GoingToWarWin.WINDOW_SHOW,mapTileData); */
    		}
    	}else if(linkEvent.text.search(/\[[0-9]*[,][0-9]*\]/)>-1){
    		var arr:Array = linkEvent.text.match(/[0-9]{1,4}/g);
    		if(ToggleButton.instance.isTown){
				ToggleButton.instance.switchHandler(true);
			}
    		DiamondWorldMap2.instance.setOnShow(true);
    		DiamondWorldMap2.instance.goPoint(arr[0],arr[1]);
    	}else if(String(linkEvent.text).indexOf("items")!=-1){
    		// 此时链接到商场
			var str:String = String(linkEvent.text).substr(5);
			var rule:ItemRule = WordFilters.instance.getItemRule(str);
			EvtDispacther.instance.eventDispatch(Shop.WINDOW_SHOW,rule);
    	}
    	else if(String(linkEvent.text).indexOf("reply.")!=-1){
    		// 此时链接到私聊
			var playerName:String = String(linkEvent.text).substr(6);
			callBackChatPopupBox(playerName);
    	}
    	else{
    		// 这是对玩家的操作
	 			chatPopupBox.show(linkEvent.text,callBackChatPopupBox);
	        	if(mouseY+y-chatPopupBox.height<0){
					chatPopupBox.setPos(mouseX+x+5,mouseY+y);
	        	}else{
	        		chatPopupBox.setPos(mouseX+x+5,mouseY+y-chatPopupBox.height);
	        	}
	        	stage.addEventListener(MouseEvent.MOUSE_DOWN,onStageClick);
    	 }
    }
    
    private function splitStr(str:String):String{
    	var s:String=str.slice(1,str.length-1);
    	return s;
    }

    /**
    * 响应键盘
    */ 
    private function onKeyHandle(event:KeyboardEvent):void{
    	switch(event.keyCode)
        {
        	case 13:
        	sendChatMsg();
        	break;
        }
    }
    
    /**
    * 切换聊天频道
    */ 
    private function onChangeChannel(event:MouseEvent):void{
		switch(event.target){
    		case this.allianceChat_btn:
    			curSelectBtn = "allianceChat_btn";
    			curChannel = ChatConstant.TYPE_ALLIANCE_CHAT;
    			break;
    		case this.worldChat_btn:
    			curSelectBtn = "worldChat_btn";
    			curChannel = ChatConstant.TYPE_WORLD_CHAT;
    			
    			break;
    		case this.privateChat_btn:
    			curSelectBtn = "privateChat_btn";
    			curChannel = ChatConstant.TYPE_PRIVATE_CHAT;
    			
	    		break;
    		case this.system_btn:
    			curSelectBtn = "system_btn";
    			curChannel = ChatConstant.TYPE_SYSTEM_CHAT;
    			
    			break;
    	}
    	this.showChatMsg();
    }
    
    
    private function clickToChangeChanle():void{
	    chat_type = (chat_type == TYPE_WORLD_CHAT?TYPE_ALLIANCE_CHAT:TYPE_WORLD_CHAT);
    	if(chat_type==TYPE_WORLD_CHAT){
    		curSelectBtn = "worldChat_btn";
			curChannel = ChatConstant.TYPE_WORLD_CHAT;
    	}else if(chat_type==TYPE_ALLIANCE_CHAT){
    		curSelectBtn = "allianceChat_btn";
			curChannel = ChatConstant.TYPE_ALLIANCE_CHAT;
    	}
    	this.showChatMsg();
    }
    
    /**
    * 显示各频道的聊天内容
    */ 
    private function showChatMsg():void{
    	switch(curChannel){
    		case ChatConstant.TYPE_ALLIANCE_CHAT:
    			chatHtmlMsg = this.allianceChatList.toArray().join("\n");
    			WordFilters.instance.removeChatList(allianceChatList);
    			lastestWord = allianceChatList.getItemAt(allianceChatList.length-1).toString();
    			wordListLength = allianceChatList.length;
    			break;
    		case ChatConstant.TYPE_FRESHMAN_CHAT:
    			chatHtmlMsg = this.beginnerChatList.toArray().join("\n");
    			WordFilters.instance.removeChatList(beginnerChatList);
    			lastestWord = beginnerChatList.getItemAt(beginnerChatList.length-1).toString();
    			break;
    		case ChatConstant.TYPE_PRIVATE_CHAT:
    			chatHtmlMsg = this.secretChatList.toArray().join("\n");
    			WordFilters.instance.removeChatList(secretChatList);
    			lastestWord = secretChatList.getItemAt(secretChatList.length-1).toString();
    			wordListLength = secretChatList.length;
    			break;
    		case ChatConstant.TYPE_WORLD_CHAT:
    			chatHtmlMsg = this.publicChatList.toArray().join("\n");
    			WordFilters.instance.removeChatList(publicChatList);
				lastestWord = publicChatList.getItemAt(publicChatList.length-1).toString();
				wordListLength = publicChatList.length;
    			break;
    		case ChatConstant.TYPE_DEAL_CHAT:
    			chatHtmlMsg = this.dealChatList.toArray().join("\n");
    			WordFilters.instance.removeChatList(dealChatList);
    			lastestWord = dealChatList.getItemAt(dealChatList.length-1).toString();
    			break;
    		case ChatConstant.TYPE_ZONE_CHAT:
    			chatHtmlMsg = this.zoneChatList.toArray().join("\n");
    			WordFilters.instance.removeChatList(zoneChatList);
    			lastestWord = zoneChatList.getItemAt(zoneChatList.length-1).toString();
	    		break;
    		case ChatConstant.TYPE_SYSTEM_CHAT:
    			chatHtmlMsg = this.systemList.toArray().join("\n");
    			WordFilters.instance.removeChatList(systemList);
    			lastestWord = systemList.getItemAt(systemList.length-1).toString();
    			wordListLength = systemList.length;
    			break;
    	}
    }
    
    private function splitString(s:String):Array{
		var arr:Array = new Array();
		if(s.substr(0,1) == "/"){
			var indexNum:int = s.indexOf(" ",1);
			if(indexNum > -1){
				arr.push(s.slice(1,indexNum));
				arr.push(s.slice(indexNum+1,s.length));	
			}
			else{
				arr= [];
			}
		}
		else{
			arr = [];
		}
		return arr;
	}
    
    private function repeatFilter(str:String):void{
		if(tallRecordArray.length>=1){
			var l:int = tallRecordArray.length - 1;
			if(str != tallRecordArray[l]){
				tallRecordArray.addItem(str);
			}
		}else{
			tallRecordArray.addItem(str);
		}
	}
    
    
	/**
	 * 改变缩放的状态
	 */ 
	private function reSizeBG():void{
		channelType ++;
		var reSizeHeight:int = 0;
		if(channelType >3){
			channelType = 1;
		}
		switch(channelType){
			case 1:
				reSizeHeight = 155;
				chatpanel.visible = true;
				this.swapBtn.toolTip=MultiLang.msg("chat.resizeBtnTip.expand");
				break;
			case 2:
				reSizeHeight = 355;
				chatpanel.visible = true;
				this.swapBtn.toolTip=MultiLang.msg("chat.resizeBtnTip.maximal");
				break;
			case 3:
				reSizeHeight = 555;
				chatpanel.visible = true;
				this.swapBtn.toolTip=MultiLang.msg("chat.resizeBtnTip.revert");
				break;
			default:
			this.updateDisplayList(485,155);
		}
		this.y += this.height-reSizeHeight;
		this.height = reSizeHeight;
		this.updateDisplayList(485,reSizeHeight);
		MainContainer.instance.reFreshRollTextLocation();
	}
	
	private function onStageClick(event:MouseEvent):void{
		if(chatPopupBox.hitTestPoint(event.stageX,event.stageY)){
			expressionBox.visible = false;
			return;
		}
		else{
			chatPopupBox.remove();
			expressionBox.visible = false;
		}
		stage.removeEventListener(MouseEvent.MOUSE_DOWN,onStageClick);
	}
	
	private function showExpressionBox():void{
		expressionBox.visible = !(expressionBox.visible);
		if(expressionBox.visible){
		expressionBox.show(getExpFun);
		stage.addEventListener(MouseEvent.MOUSE_DOWN,onStageClick);}
	}
	
 	private function getExpFun(obj:Object):void{
 		if(obj != null)
		chatTextInput.htmlText += ExpressionBean(obj).name;
	}   
	
	private function callBackChatPopupBox(str:String):void{
		this.chatTextInput.text = "";
		this.chatTextInput.text = "/"+str+" ";
		
		 var l:int = chatTextInput.text.length;

    	 chatTextInput.setSelection(l,l);
    	 this.focusManager.setFocus(chatTextInput);
	}
	
	private function privateChatHandle(event:PrivateChatEvent):void{
		callBackChatPopupBox(event.playerName);
	}
	
	private function onValueChange(event:FlexEvent):void{
		if(!isStay){
			TextArea(event.target).verticalScrollPosition = TextArea(event.target).maxVerticalScrollPosition;
			return;
			}
		
		if(curVerticalPosition +2>=TextArea(event.target).maxVerticalScrollPosition){
			curVerticalPosition = TextArea(event.target).maxVerticalScrollPosition;
		}
		TextArea(event.target).verticalScrollPosition = curVerticalPosition;
	}
	
	private var curVerticalPosition:Number = 0;
	private var isStay:Boolean = false;
	private function onTextScoll(e:ScrollEvent):void{
		if(e.position >0 && e.position<TextArea(e.target).maxVerticalScrollPosition -1){
			isStay = true;
			curVerticalPosition = chat_text.verticalScrollPosition;
			}
		else if(e.position >0 && e.position>=TextArea(e.target).maxVerticalScrollPosition -1){
			isStay = false;
			curVerticalPosition = TextArea(e.target).maxVerticalScrollPosition;
		}
	}
	
	/** 最后一次免费说话的时间  */
	private function onFreeCentenceTime(event:PublicEvent):void{
		this.lastTime = FreeSentenceTimeUpdate(event.evtData).lastFreeSentenceTime;
		this.freeTimer.start();
	}
	
	/**
	 * 有新的系统信息
	 */
	private function onNewSystemMsg(event:MsgEvent):void {
    	var msg:String = StringUtil.trim(String(event.data));
    	if (msg.length>0) {
	    	var str:String;
    		if (msg.indexOf("</font>")>0) {
    			str = msg;
    		} else {
    			str = "<b><font color='#d60000'>" + msg+"</font></b>";
    		}
    		
			this.secretChatList.addItem(str);
			this.allianceChatList.addItem(str);
			this.systemList.addItem(str);
			this.publicChatList.addItem(str);
    	} else {
    		trace("系统发送的消息为空");
    	}
	}
	
	private function onShowText(event:TimerEvent):void{
		this.limitCount ++;
		if(limitCount >= 60){limitCount = LIMIT_TIME_NUM*1000/500;}
		var arr:ArrayCollection = new ArrayCollection();
		switch(curChannel){
    		case ChatConstant.TYPE_ALLIANCE_CHAT:
    			arr = allianceChatList;
    			break;
    		case ChatConstant.TYPE_FRESHMAN_CHAT:
    			arr = beginnerChatList;
    			break;
    		case ChatConstant.TYPE_PRIVATE_CHAT:
    			arr = secretChatList;
    			break;
    		case ChatConstant.TYPE_WORLD_CHAT:
    			arr = publicChatList;
    			break;
    		case ChatConstant.TYPE_DEAL_CHAT:
    			arr = dealChatList;
    			break;
    		case ChatConstant.TYPE_ZONE_CHAT:
    			arr = zoneChatList;
	    		break;
    		case ChatConstant.TYPE_SYSTEM_CHAT:
    			arr = systemList;
    			break;
    	}
    	if(arr.length<=1)return;
    	if(arr.length == wordListLength)return;  
		showChatMsg();
	}
	
	private function onFreeTime(event:TimerEvent):void{
		var now:Number = new Date().valueOf();
		var diff:Number = GameContext.instance.getTimeDis();
		remainTime = now - lastTime - diff;
		if(remainTime >= 1000*60*5){
			remainTime = 1000*60*5;
		}else if(remainTime <=0){
			remainTime = 0;
		}
		var remain:Number = (now - lastTime - diff )/(1000*60);
		if(remain >=PlayerConstant.FREE_SENTENCE_INTERVAL_MINS){
			canChatFree = true;
			this.freeTimer.stop();
		}
		timePercentShape.scaleX = 1-remainTime/(1000*60*5);
	}
	
	private function onInputFocusIn():void{
		if(chat_type==TYPE_WORLD_CHAT){
			showSpeakerView.visible = true;
			speakerCount = itemManager.getMaterialBeanById(ChatConstant.WORLD_CHAT_ITEM)==null?0:itemManager.getMaterialBeanById(ChatConstant.WORLD_CHAT_ITEM).count;
		}

	}
	
	private function onInputFocusOut():void{
		showSpeakerView.visible = false;
	}
	
	private function onBuySpeaker():void{
		var rule:ItemRule = GameRuleHelper.instance.getItemRuleById("speaker");
		EvtDispacther.instance.eventDispatch(Shop.WINDOW_SHOW,rule);
	}
	
	private function onCancelShow():void{
		isShowFreeSpeakTips = false; 
	}
	
	private function onChatMouseWheel(e:MouseEvent):void{
		var compAtFocus: IFocusManagerComponent = this.focusManager.getFocus();
		if(compAtFocus is TextArea)  
		e.delta = 3;
	}
	//限制输入部分文字,并判断是否超过512个字符
	private var textInputLength:int = 0;
	private var chatLength:int = 0;
	private function textInputChange(e:Event):void{
		if(e.target.text.length<=ChatConstant.MAX_MSG_SIZE/2){
			textInputLength = 0;
			return;
		}
		else{
			if(textInputLength <= 0){
				textInputLength = InputTextHelper.getByteLength(e.target.text);
				chatLength = InputTextHelper.getChatLength(e.target.text,ChatConstant.MAX_MSG_SIZE);
			}else{
				if(InputTextHelper.isDoubleByte(String(e.target.text).substr(-1,1))){
					textInputLength += 2;
				}else{
					textInputLength ++;
				}
				chatLength ++;
			}
			if(textInputLength >= ChatConstant.MAX_MSG_SIZE){
				chatLength = InputTextHelper.getChatLength(e.target.text,ChatConstant.MAX_MSG_SIZE);
				e.target.text = String(e.target.text).slice(0,chatLength);
				textInputLength = InputTextHelper.getByteLength(e.target.text);
			}
		}
	}

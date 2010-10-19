// 任务脚本
			import flash.events.Event;
			import flash.net.SharedObject;
			
			import mx.collections.ArrayCollection;
			import mx.controls.Text;
			import mx.events.FlexEvent;
			import mx.events.ItemClickEvent;
			import mx.events.ListEvent;
			import mx.logging.ILogger;
			import mx.logging.Log;
			
			import roma.common.action.ControllerFactory;
			import roma.common.constants.QuestConstant;
			import roma.common.controller.CommonResponse;
			import roma.common.controller.quest.QuestCategoryResponse;
			import roma.common.controller.quest.TaskListResponse;
			import roma.common.valueObject.QuestCategoryBean;
			import roma.common.valueObject.TaskBean;
			import roma.common.valueObject.TaskTargetBean;
			import roma.logic.CaesaryConfig;
			import roma.logic.GameContext;
			import roma.logic.object.player.ItemResManager;
			import roma.logic.object.task.TaskManager;
			import roma.logic.rule.GameRuleHelper;
			import roma.logic.rule.QuestRule;
			import roma.logic.rule.QuestTypeRule;
			import roma.message.EvtDispacther;
			import roma.message.events.QuestEvent;
			import roma.util.CompCache;
			import roma.util.JavaScriptHelper;
			import roma.util.MultiLang;
			
			import views.BeginnerGuide;
			import views.MainContainer;
			import views.mainFrame.CastleFrame;
			import views.spreadUI.MyAlert;
			import views.spreadUI.speedUp.ItemSelectSpeedUpWin;
			import views.windows.functionWins.playInfo.KingInfoWin;
			import views.windows.functionWins.task.MulAnswerUI;
			import views.windows.functionWins.task.SingleAnswerUI;
			import views.windows.functionWins.task.TaskConstant;
			
			public static const WINDOW_SHOW:String = "taskWin.show";
			public static const MODIFY_PLAYERNAME:String = "modifyPlayerName";
			private static var log:ILogger = Log.getLogger("views.windows.functionWins.task.TaskWin");
			
			private var cityId:int ;
			[Bindable]
			private var questTypeRuleArray:ArrayCollection = new ArrayCollection();
			[Bindable]
			private var questRuleArray:ArrayCollection = new ArrayCollection();
			[Bindable]
			private var questTargetArray:ArrayCollection = new ArrayCollection();
			
			[Bindable]
			private var curQuestTypeRule:QuestTypeRule;	
			[Bindable]
			private var curQuestRule:QuestRule;
			
			[Bindable]
			private var curQuestTypeStr:String = "";
			[Bindable]
			public var curQuestTypeSelectId:int = 0;
			[Bindable]
			public var curQuestSelectId:int = 0;
			private var curResultStr:String = "";
			private var taskCount:int = 0;
			
			private var singleAnswerCache:CompCache = new CompCache(5);
			private var mulAnswerCache:CompCache = new CompCache(5);
			[Bindable]
			private var noTaskTip:String;
			
			/**
			 *每次界面弹出调用，刷新数据
			 */ 
			override public function refresh():void{
				log.debug("TaskWin.refresh()");
				this.cityId = GameContext.instance.getPlayerObj().getCurCastleObj().cityId;
				if(this.initialized){
					if(questTB.selectedIndex == 0){
						ControllerFactory.getInstance().getTaskController().getQuestTypeList(cityId,QuestConstant.QUEST_TYPE_GROWTH,onGetQuestTypeListResponse,false);
						myViewstack.selectedIndex = 0;
					}else if(questTB.selectedIndex == 1){
						ControllerFactory.getInstance().getTaskController().getQuestTypeList(cityId,QuestConstant.QUEST_TYPE_DAILY,onGetQuestTypeListResponse,false);
					}else if(questTB.selectedIndex == 2){
						ControllerFactory.getInstance().getTaskController().getQuestTypeList(cityId,QuestConstant.QUEST_TYPE_CHANGE,onGetQuestTypeListResponse,false);
					}
				}
			}
			
			/**
			 * 界面隐藏调用，停止当前窗体一切相关动画等
			 */ 
			override public function destroy():void{
				log.debug("TaskWin.destroy()");	
				CastleFrame.instance.newTaskHandle(false);
			}
			
			private function init():void {
				this.refresh();
				EvtDispacther.instance.addEventListener(QuestEvent.QUEST_REFRESH,onQuestRefresh);
				
				//新手引导调用,领取任务
				EvtDispacther.instance.addEventListener(BeginnerGuide.AWARD_QUEST,onAwardQuest);
				//新手指引，使用建筑排程
				EvtDispacther.instance.addEventListener(BeginnerGuide.USE_INCBUILDFORMATION60H_ITEM,onUseBuildProcessItem)			
			}
			
			/**
			 * 刷新任务列表
			 */ 
			private function onQuestRefresh(event:QuestEvent):void{
				if(this.isPopUp){
					this.refresh();
				}
			}
			
			/**
			 * 获得任务父目录的列表响应
			 */ 
			private function onGetQuestTypeListResponse(event:QuestCategoryResponse):void{
				var qTArray:ArrayCollection = event.typesArray;
				questTypeRuleArray.removeAll();
				for each(var q:QuestCategoryBean in qTArray){
					var rt:QuestTypeRule = GameRuleHelper.instance.getTaskTypeRule(q.categoryId);
					if(rt != null){
						rt.isFinish = q.finish;
						questTypeRuleArray.addItem(rt);
					}
					else{
						log.error("quest type is null in "+q.categoryId);
					}
				}
				if (questTypeRuleArray.length>0) {
					for each(var qq:QuestTypeRule in questTypeRuleArray){
						if(qq.isFinish){
							curQuestTypeRule = qq;
							curQuestTypeSelectId = this.curQuestTypeRule.questTypeId;
							refreshQuestListHandle();
							TaskManager.instance.getFinishedQuestCount();
							return;
						}
					} 
					if(curQuestTypeRule == null){
						curQuestTypeRule = questTypeRuleArray[0] as QuestTypeRule;
						subQuestDataGrid.selectedIndex = 0;
						myViewstack.selectedIndex = 0;
					}
					else {
						var found:Boolean = false;
						for(var i:int=0;i<questTypeRuleArray.length;i++) {
							 var bean:QuestTypeRule = questTypeRuleArray[i] as QuestTypeRule;
							if(bean.questTypeId == this.curQuestTypeRule.questTypeId) {
								questDg.verticalScrollPosition = i*questDg.rowHeight;
								found = true;
								break;
							}
						}
						if (!found) {
							curQuestTypeRule = questTypeRuleArray[0] as QuestTypeRule;
							subQuestDataGrid.selectedIndex = 0;
							myViewstack.selectedIndex= 0;
						}
					}
					curQuestTypeSelectId = this.curQuestTypeRule.questTypeId;
					refreshQuestListHandle();
				}else{
					curQuestTypeStr = "";
					questRuleArray = null;
					myViewstack.selectedIndex = 1;
					if(questTB.selectedIndex == 0){
						noTaskTip="";
					}else if(questTB.selectedIndex == 1){
						noTaskTip=MultiLang.msg("task.tip.onCommonTask");
					}
				}
				
				TaskManager.instance.getFinishedQuestCount();
				
			}
			
			/**
			 * 获得任务子目录的列表响应
			 */ 
	 		private function onQuestListHandle(event:TaskListResponse):void {
	 			questRuleArray = new ArrayCollection();
				var qArray:ArrayCollection = event.tasksArray;
				if(qArray.length<=0){
					myViewstack.selectedIndex = 1;
					return;
				}
				for each(var q:TaskBean in qArray){
					var rq:QuestRule = GameRuleHelper.instance.getTaskRule(q.id);
					if(rq != null){
						if(rq.taskId == TaskConstant.QUEST_ADDCOLLECT){
							// 对收藏功能的特殊处理
							rq.isFinish = TaskManager.instance.isFromFavorite;
						}else if(rq.taskId == TaskConstant.QUEST_FROMCOLLECT){
							// 对收藏工资的特殊处理
							rq.isFinish = TaskManager.instance.isFromFavorite;
						}else if(rq.taskId == TaskConstant.QUEST_GOTOBHMT){
							// 连接到巴哈姆特
							rq.isFinish = TaskManager.isGoToBHMT;
						}else if(rq.taskId == TaskConstant.QUEST_GOTOGULE){
							// 连接到nakuz
							rq.isFinish = TaskManager.isGotoGULE;
						}else if(rq.taskId == TaskConstant.QUEST_FAILCALL){
							rq.isFinish = TaskManager.isGotoFailForum;
						}
						else{
							rq.isFinish = q.finish;
						}
						rq.targetBeanList = q.targetsArray; 
						this.questRuleArray.addItem(rq);
					}else{
						log.error("quest is null in "+q.id);
					}
				}
				// 遍历任务，跳转到完成的任务（不过假如是在新手引导，就不需要跳转了）
				for(var i:int=0;i< questRuleArray.length;i++){
					var qq:QuestRule = questRuleArray[i] as QuestRule;
					if(qq.isFinish){
						this.curQuestRule = qq;
						this.curQuestSelectId = curQuestRule.taskId;
						break;
					}else{
						if(i>=questRuleArray.length-1){
							this.curQuestRule = questRuleArray[0] as QuestRule;
							this.curQuestSelectId = curQuestRule.taskId;
							break;
						}
					}
				}
				myViewstack.selectedIndex = 0;
				if(curQuestRule != null){
					getTargetList();
					setAnswers();
				}
				
			} 
			
			/**
			 * 领取已经完成的任务响应
			 */ 
			private function onAwardResponse(event:CommonResponse):void {
				if (event.isSuccess()) {
					this.refresh();
					MainContainer.instance.risePlay(curQuestRule.getAwardStr);
				} else {
					MyAlert.showError(event);
				}
			}
			
			private var answerDic:Dictionary = new Dictionary();
			private function setAnswers():void{
				if(curQuestRule.questionList.length <= 0){
					return;
				}
				answerDic = new Dictionary();
				answers.removeAllChildren();
				for each(var bean:QuestionBean in curQuestRule.questionList){
					if(!bean.isMul){
						var tempSingleAnswer:SingleAnswerUI = singleAnswerCache.getUI(SingleAnswerUI) as SingleAnswerUI;
						tempSingleAnswer.setAnswerBean(bean);
						answers.addChild(tempSingleAnswer);
						answerDic[bean.subject] = tempSingleAnswer;
					}
					else if(bean.isMul){
						var tempMulAnswer:MulAnswerUI = mulAnswerCache.getUI(MulAnswerUI) as MulAnswerUI;
						tempMulAnswer.setAnswerBean(bean);
						answers.addChild(tempMulAnswer);
						answerDic[bean.subject] = tempMulAnswer;
					}
				}
			}
			
			private function getTargetList():void{
				questTargetArray.removeAll();
				for(var i:int=0;i<curQuestRule.targetList.length;i++) {
					try{
						if(curQuestRule.taskId == TaskConstant.QUEST_FROMCOLLECT){
							questTargetArray.addItem(new TargetBean(curQuestRule.targetList[i],TaskManager.instance.isFromFavorite));
						}else{
						questTargetArray.addItem(new TargetBean(curQuestRule.targetList[i],TaskTargetBean(curQuestRule.targetBeanList[i]).finished));}
					}
					catch(e:Error){
						log.error(e.message);
						log.error("curQuestRule.getTargetList != curQuestRule.targetBeanList in i = "+i);
					}
				}
			}
			
			private function rightOrNot():Boolean{
 				var isTrue:Boolean = true;
 				curResultStr = "";
 				for(var s:String in answerDic){
 					if(answerDic[s] is MulAnswerUI){
 						curResultStr += MulAnswerUI(answerDic[s]).resultStr;
 						if(!MulAnswerUI(answerDic[s]).checkResult())
 						{isTrue = false;
 						break;}
 					}
 					else if(answerDic[s] is SingleAnswerUI){
 						curResultStr += SingleAnswerUI(answerDic[s]).resultId;
						if(!SingleAnswerUI(answerDic[s]).checkResult())
 						{isTrue = false;
 						break;}
 					}
				}
				return isTrue;
			}
			
			private function refreshQuestListHandle():void {
				cityId = GameContext.instance.getPlayerObj().getCurCastleObj().cityId;
				if (this.curQuestTypeRule!=null) {
					ControllerFactory.getInstance().getTaskController().getTaskList(cityId, curQuestTypeRule.questTypeId,onQuestListHandle);
				}
				else{
				}
			}
			
			public function onChangeQuestType(event:ListEvent):void {
				this.curQuestTypeRule = event.itemRenderer.data as QuestTypeRule;
				this.refreshQuestListHandle();
				this.curQuestTypeSelectId = curQuestTypeRule.questTypeId; 
			}
		
			public function onQuestChange(event:ListEvent):void {
				this.curQuestRule = event.itemRenderer.data as QuestRule;
				this.curQuestSelectId = curQuestRule.taskId;
				getTargetList();
				setAnswers();
			}
			
			private function onAwardQuest(event:Event):void{
				getAward();
			}
			
			private function getAward():void{
				cityId = GameContext.instance.getPlayerObj().getCurCastleObj().cityId;
				if(curQuestRule.questionList.length >0){
					if(rightOrNot()){
						ControllerFactory.getInstance().getTaskController().getAward(cityId,curQuestRule.taskId,curResultStr,onAwardResponse);
					}else{
						MyAlert.show(MultiLang.msg('quest.answer.isWrong'));
					}
				}
				else{
					ControllerFactory.getInstance().getTaskController().getAward(cityId,curQuestRule.taskId,curResultStr,onAwardResponse);
				}
			}
			
			private function onTBClick(event:ItemClickEvent):void{
				cityId = GameContext.instance.getPlayerObj().getCurCastleObj().cityId;
				if(event.index == 0){
					ControllerFactory.getInstance().getTaskController().getQuestTypeList(cityId,QuestConstant.QUEST_TYPE_GROWTH,onGetQuestTypeListResponse,false);
				}else if(event.index ==1){
					ControllerFactory.getInstance().getTaskController().getQuestTypeList(cityId,QuestConstant.QUEST_TYPE_DAILY,onGetQuestTypeListResponse,false);
				}else if(event.index == 2){
					ControllerFactory.getInstance().getTaskController().getQuestTypeList(cityId,QuestConstant.QUEST_TYPE_CHANGE,onGetQuestTypeListResponse,false);
				}
			}
			
			/**
			 * 调出收藏夹
			 */ 
			private var shareObj:SharedObject = SharedObject.getLocal(TaskManager.CEASARY_STR);
			private function addFavorite():void{
				JavaScriptHelper.instance.addFavorite();
				var rq:QuestRule = GameRuleHelper.instance.getTaskRule(TaskConstant.QUEST_ADDCOLLECT);
				shareObj.data.addFavorite = GameContext.instance.getPlayerObj().getPlayerInfo().accountName;
				shareObj.flush();
				TaskManager.instance.isFromFavorite = true;
				this.refresh();
			}
			
			/**
			 * 通过url?&rune=1...进入游戏
			 */ 
			private function linkFromFavorite():void{
				JavaScriptHelper.instance.addFavorite();
				var rq:QuestRule = GameRuleHelper.instance.getTaskRule(TaskConstant.QUEST_FROMCOLLECT);
				shareObj.data.addFavorite = GameContext.instance.getPlayerObj().getPlayerInfo().accountName;
				shareObj.flush();
				TaskManager.instance.isFromFavorite = true;
				this.refresh();
			}
			
			private function onManualUpdate(e:FlexEvent):void{
				var str:String = Text(e.target).htmlText;
				if(str.indexOf("<img") >= 0 || str.indexOf("<IMG")>=0){
					this.manualText.height = 112+this.manualText.textHeight+14;
				}
				else{
					this.manualText.height = 14+this.manualText.textHeight;
				}
			}
			
			/**
			 * 使用建筑排程
			 */ 
			private function useIncreaseBuildingLimit():void{
				ItemSelectSpeedUpWin.show(ItemResManager.prolongBuildingProcessItemArrayCollection,null,null,null,awardItemCallBack);
 				function awardItemCallBack():void{
 					refresh();
 				}
			}
			
			/**
			 * 修改玩家名
			 */ 
			private function modifyPlayerName():void{
				EvtDispacther.instance.eventDispatch(KingInfoWin.WINDOW_SHOW,MODIFY_PLAYERNAME);
			}
			
			/**
			 * 跳转页面
			 */ 
			private function onGotoUrl(id:int):void{
				if(id == TaskConstant.QUEST_GOTOBHMT){
					JavaScriptHelper.instance.getURL(CaesaryConfig.instance.baHaUrl);
					TaskManager.isGoToBHMT = true;
				}else if(id == TaskConstant.QUEST_GOTOGULE){
					JavaScriptHelper.instance.getURL(CaesaryConfig.instance.leGuUrl);
					TaskManager.isGotoGULE = true;
				}else if(id == TaskConstant.QUEST_FAILCALL){
					JavaScriptHelper.instance.getURL(CaesaryConfig.instance.failForumUrl);
					TaskManager.isGotoFailForum = true;
				}
				this.refresh();
			}
			
			private function onUseBuildProcessItem(event:Event):void{
				refresh();
			}
			
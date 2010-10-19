package roma.logic.object.task
{
	import flash.net.SharedObject;
	
	import roma.common.action.ControllerFactory;
	import roma.common.controller.quest.FinishedQuestCountResponse;
	import roma.logic.GameContext;
	import roma.message.EvtDispacther;
	import roma.message.events.QuestEvent;
	
	[Bindable]
	public class TaskManager
	{
		public static const CEASARY_STR:String = "ceasary";
		
		public static var instance:TaskManager = new TaskManager();
		public static var taskCount:int = 0;
		public static var changeCount:int = 0;
		public static var dailyCount:int = 0;
		public static var growthCount:int = 0;
		
		/** 港服中要求连接到巴哈姆特 **/
		public static var isGoToBHMT:Boolean = false;
		/** 港服中要求连接到Nakuz **/
		public static var isGotoGULE:Boolean = false;
		
		public static var isGotoFailForum:Boolean = false;
		/** 是否从收藏夹里面进去的 **/
		public var isFromFavorite:Boolean = false;
		
		private var sharedObj:SharedObject = SharedObject.getLocal(CEASARY_STR);
		
		public function TaskManager()
		{
			isFromFavorite = sharedObj != null && sharedObj.data.addFavorite != null && sharedObj.data.addFavorite == GameContext.instance.getPlayerObj().getPlayerInfo().accountName;
			EvtDispacther.instance.addEventListener(QuestEvent.HAS_EVENT_FINISHED,onHasEventFinished);
		}
		
		public function getFinishedQuestCount():void{
			var cityId:int = GameContext.instance.getPlayerObj().getCurCastleObj().cityId;
			ControllerFactory.getInstance().getTaskController().finishedQuestCount(cityId,onFinishedQuestCount,false);
			function onFinishedQuestCount(event:FinishedQuestCountResponse):void{
				if(event.isSuccess()){
					if(event.finishedQuestCount != taskCount && event.finishedQuestCount>=0){
						EvtDispacther.instance.dispatchEvent(new QuestEvent(QuestEvent.QUESTCOUNT_CHANGE,event.finishedQuestCount));
					}
					taskCount = event.finishedQuestCount;
					changeCount = event.changeCount;
					dailyCount = event.dailyCount;
					growthCount = event.growthCount;
				}else{
				}
			}
		} 
		
		private function onHasEventFinished(event:QuestEvent):void{
			getFinishedQuestCount();
			EvtDispacther.instance.dispatchEvent(new QuestEvent(QuestEvent.QUEST_REFRESH,true));
		}
		
	}
}
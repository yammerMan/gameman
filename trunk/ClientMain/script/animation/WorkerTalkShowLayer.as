package animation
{
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import mx.core.UIComponent;
	
	import roma.common.constants.WorkerConstant;
	import roma.logic.GameContext;
	import roma.logic.object.castle.CastleResourceManager;
	import roma.message.EvtDispacther;
	import roma.message.events.MsgEvent;
	import roma.util.MultiLang;
	
	import views.spreadUI.tech.WorkerHelper;

	public class WorkerTalkShowLayer extends UIComponent
	{
		private static var SUPPORT_LOW:int =30;
		private static var SUPPORT_HEIGHT:int =90; 

		private static var _fWTalkFrame:TalkFrame = new TalkFrame();
		private static var _wWTalkFrame:TalkFrame = new TalkFrame();
		private static var _sWTalkFrame:TalkFrame = new TalkFrame();
		private static var _iWTalkFrame:TalkFrame = new TalkFrame();
		
		private var _maximMap:Dictionary = new Dictionary();
		
		private var _aniLayer:RoleWalkingAniLayer ;
		
		private var  _clickCount:int =1;
		
		private var _frameAry:Array= new Array(_fWTalkFrame,_wWTalkFrame,_sWTalkFrame,_iWTalkFrame);
		
		public static var instance:WorkerTalkShowLayer;
						
		public function WorkerTalkShowLayer()
		{
			super();
			
			instance = this;
			
			_aniLayer = RoleWalkingAniLayer.getInstance();
			
			for(var i:int =0;i<_frameAry.length;i++){
				var frame:TalkFrame = _frameAry[i] as TalkFrame;
				this.addChild(frame);
			}
			
			for(var j:int =1;j<11;j++){
				_maximMap["maxim"+j] = MultiLang.msg("maxim."+j);
			}
						
			EvtDispacther.instance.addEventListener(EvtDispacther.WALKING_ROLE_CLICK,evtHandler);
		}

		public function initFrame():void{
			for(var j:int =0;j<_frameAry.length;j++){
				var frame:TalkFrame = _frameAry[j] as TalkFrame;
				if(frame.visible){
					frame.initProp();
				}
			}
		}
		
		private function evtHandler(event:MsgEvent):void{
			if(_clickCount >10)	_clickCount = 1; 
			var str:String = _maximMap["maxim"+_clickCount];
			
			switch(event.data as RoleContainer){
				case _aniLayer.getFoodWkCt():
					setFrameValue(_fWTalkFrame,str,_aniLayer.getFoodWkCt());										
					break;
				case _aniLayer.getWoodsWkCt():
					setFrameValue(_wWTalkFrame,str,_aniLayer.getWoodsWkCt());										
					break;
				case _aniLayer.getIronsWkCt():
					setFrameValue(_iWTalkFrame,str,_aniLayer.getIronsWkCt());										
					break;
				case _aniLayer.getStonesWkCt():
					setFrameValue(_sWTalkFrame,str,_aniLayer.getStonesWkCt());										
					break;
			}
			_clickCount ++;
		}
		
		private function setFrameValue($frame:TalkFrame,$talk:String,$container:RoleContainer,$isMove:Boolean =true):void{
			$frame.start = getTimer();
			$frame.visible = true;
			$frame.isMove = $isMove;
			$frame.x = $container.x;
			$frame.y = $container.y-25;
			$frame.setValue($talk); 
		}
		
		public function moveFrame():void{
			checkFramShow();
			if(_aniLayer!=null){
				moveTalkFrame(_fWTalkFrame,_aniLayer.getFoodWkCt());
				moveTalkFrame(_wWTalkFrame,_aniLayer.getWoodsWkCt());
				moveTalkFrame(_sWTalkFrame,_aniLayer.getStonesWkCt());
				moveTalkFrame(_iWTalkFrame,_aniLayer.getIronsWkCt());
			}
		}
		
		private function moveTalkFrame(frame:TalkFrame,container:RoleContainer):void{
			if(frame.isMove){
				if(!frame.isTimeOver()){
					frame.x += container.getXSpeed();
					frame.y += container.getYSpeed();
				}else{
					frame.isMove = false;
					frame.visible = false;
					frame.x = -100;
					frame.y = -100;
				}
			}
		} 
		
		private function checkFramShow():void{
			for(var i:int =0;i<_frameAry.length;i++){
				var frame:TalkFrame = _frameAry[i] as TalkFrame;
				frame.isIntervalTimeOver();
			}
			
			var res:CastleResourceManager = GameContext.instance.getPlayerObj().getCurCastleObj().resourceManager;
			//当前数量低于容量10%
			if(res.curPopulation<res.food.capUpperlimit*10/100 && !_fWTalkFrame.isResStLowShow){
				_fWTalkFrame.isResStLowShow = true;
				_fWTalkFrame.resStLowStart = getTimer();
				setFrameValue(_fWTalkFrame,MultiLang.msg('worker.lack',WorkerHelper.instance.getWorkerName(WorkerConstant.FARMER_WORKER_TYPE)),_aniLayer.getFoodWkCt());									
			}
			if(res.wood.curAmount<res.wood.capUpperlimit*10/100 && !_wWTalkFrame.isResStLowShow){
				_wWTalkFrame.isResStLowShow = true;
				_wWTalkFrame.resStLowStart = getTimer();
				setFrameValue(_wWTalkFrame,MultiLang.msg('worker.lack',WorkerHelper.instance.getWorkerName(WorkerConstant.WOODCUTTER_WORKER_TYPE)),_aniLayer.getWoodsWkCt());									
			}
			if(res.stone.curAmount<res.stone.capUpperlimit*10/100 && !_sWTalkFrame.isResStLowShow ){
				_sWTalkFrame.isResStLowShow = true;
				_sWTalkFrame.resStLowStart = getTimer();
				setFrameValue(_sWTalkFrame,MultiLang.msg('worker.lack',WorkerHelper.instance.getWorkerName(WorkerConstant.STONEMASON_WORKER_TYPE)),_aniLayer.getStonesWkCt());									
			}
			if(res.iron.curAmount<res.iron.capUpperlimit*10/100 && ! _iWTalkFrame.isResStLowShow){
				_iWTalkFrame.isResStLowShow = true;
				_iWTalkFrame.resStLowStart = getTimer();
				setFrameValue(_iWTalkFrame,MultiLang.msg('worker.lack',WorkerHelper.instance.getWorkerName(WorkerConstant.MINER_WORKER_TYPE)),_aniLayer.getIronsWkCt());									
			}
			
			//当前数量超过容量上限
			if(res.food.isCapacityFull() && !_fWTalkFrame.isResExcessShow){
				_fWTalkFrame.isResExcessShow = true;
				_fWTalkFrame.resExcessStart = getTimer();
				setFrameValue(_fWTalkFrame,MultiLang.msg('resource.full',MultiLang.msg("label.food")),_aniLayer.getFoodWkCt());									
			}
			if(res.wood.isCapacityFull() && !_wWTalkFrame.isResExcessShow){
				_wWTalkFrame.isResExcessShow = true;
				_wWTalkFrame.resExcessStart = getTimer();
				setFrameValue(_wWTalkFrame,MultiLang.msg('resource.full',MultiLang.msg("label.wood")),_aniLayer.getWoodsWkCt());									
			}
			if(res.stone.isCapacityFull()  && !_sWTalkFrame.isResExcessShow){
				_sWTalkFrame.isResExcessShow = true;
				_sWTalkFrame.resExcessStart = getTimer();
				setFrameValue(_sWTalkFrame,MultiLang.msg('resource.full',MultiLang.msg("label.stone")),_aniLayer.getStonesWkCt());									
			}
			if(res.iron.isCapacityFull() && !_iWTalkFrame.isResExcessShow){
				_iWTalkFrame.isResExcessShow = true;
				_iWTalkFrame.resExcessStart = getTimer();
				setFrameValue(_iWTalkFrame,MultiLang.msg('resource.full',MultiLang.msg("label.iron")),_aniLayer.getIronsWkCt());									
			}
			//粮食是负增长
			if(res.food.totalProduce<0 && !_fWTalkFrame.isResLackShow ){
				_fWTalkFrame.isResLackShow = true;
				_fWTalkFrame.resLackStart= getTimer();
				setFrameValue(_fWTalkFrame,MultiLang.msg('food.minus.increase'),_aniLayer.getFoodWkCt());									
			}
			//明心小于30时
			if(res.support<SUPPORT_LOW && !_fWTalkFrame.isSupportLowShow){
				_fWTalkFrame.isSupportLowShow = true;
				_fWTalkFrame.supportLowStart = getTimer();
				setFrameValue(_fWTalkFrame,MultiLang.msg('support.low'),_aniLayer.getFoodWkCt());									
			}
			//明心大于90时
			if(res.support>SUPPORT_HEIGHT && !_fWTalkFrame.isSupportHightShow){
				var kingName:String = GameContext.instance.getPlayerObj().getPlayerInfo().playerName;
				_fWTalkFrame.isSupportHightShow = true;
				_fWTalkFrame.supportHightStart = getTimer();
				setFrameValue(_fWTalkFrame,MultiLang.msg('support.height',kingName),_aniLayer.getFoodWkCt());									
			}
			//别攻打时候
			//TODO
		}
	}
}
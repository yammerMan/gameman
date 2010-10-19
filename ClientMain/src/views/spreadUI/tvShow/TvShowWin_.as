		// 脚本
		import flash.events.TimerEvent;
		import flash.utils.Timer;
		
		import roma.logic.GameContext;
		import roma.message.EvtDispacther;
		import roma.message.events.MsgEvent;
		
		import views.mainFrame.ChatPanel;
		import views.windows.functionWins.turntable.RaffleUtil;

		[Bindable]
		private var tvContent:String;
		
		private var timeLimit:int=5;
		private var timeInit:int=5;
		private var playerName:String;
		private var itemName:String;
		private var itemCount:int;
		private var itemValue:int;
		
		private var showTime:Timer=new Timer(1000);

		private function init():void{
			showTime.addEventListener(TimerEvent.TIMER,timerHandle);
			EvtDispacther.instance.addEventListener(EvtDispacther.TURNTABLE_RAFFLE_NOTICE,onNewAnnounceUpDate);
		}
		
		private function timerHandle(event:TimerEvent):void {
			timeLimit--;
			if(timeLimit==0){
				timeLimit=timeInit;
				showTime.stop();
				this.visible=false;
			}
		}
		
		private function onNewAnnounceUpDate(event:MsgEvent):void{
			this.tvContent=  RaffleUtil.analyzeRaffleXml(String(event.data));
			
			if(XML(event.data).@playerName != GameContext.instance.getPlayerObj().getPlayerInfo().playerName){
				ChatPanel.instance.addotherRaffleAnnounce(RaffleUtil.analyzeRaffleXml(String(event.data),false));
			}
			
			if(showTime.running){
				timeLimit=timeInit;
			}else{
				showTime.start();
			}
			this.visible=true;
		}

// ActionScript file
	import mx.events.ItemClickEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.constants.LetterConstant;
	
	import views.PopupWindows;
	import views.windows.functionWins.mail.Mail;
	import views.windows.functionWins.mail.NewMailData;
	
	public static const WINDOW_SHOW:String = "MailWin.show";
	public static var instance:Mail = new Mail();
	private static var log:ILogger = Log.getLogger("views.sprendUI.MailWin");

	private var selectedTab:int = 0;
	
	public static function writeMailToPlayer(name:String, title:String="",b:Boolean= false):void {
		var e:NewMailData = new NewMailData();
		e.targetname = name;
		e.mailTitle = title;
		
		PopupWindows.openFuncWin(Mail.WINDOW_SHOW,e,b);
	}
	
	override public function refresh():void {
		log.debug(this.className + " refresh()");
		
		if (this.winData !=null ) {
			var ed:NewMailData = winData as NewMailData;
			//事件是发邮件
			this.switchToWriteMail(ed.mailTitle , ed.targetname);
			this.winData = null;
		} else {
			this.buttonBar.selectedIndex = selectedTab;
			this.switchVs();
		}
	}
	
	private function switchVs():void {
		switch (this.selectedTab) {
			case 0:
				this.normalMailCanvas.refresh(LetterConstant.LETTER_RECEIVE,tbSwitch);
				this.viewStach.selectedChild = this.normalMailCanvas;
				break;
			case 1:
				//战报
				this.systemMailCanvas.refresh(LetterConstant.MAIL_BATTLE_REPORT,tbSwitch);
				this.viewStach.selectedChild =  this.systemMailCanvas;
				break;
			case 2:
				//系统邮件，需要把回复按钮隐藏
				//战报
				this.systemMailCanvas.refresh(LetterConstant.LETTER_SYSTEM,tbSwitch);
				this.viewStach.selectedChild =  this.systemMailCanvas;
				break;
			case 3:
				//发件箱，回复的操作特别
				this.normalMailCanvas.refresh(LetterConstant.LETTER_SEND,tbSwitch);
				this.viewStach.selectedChild = this.normalMailCanvas;
				break;
		}
	}
	
	private function switchToWriteMail(title:String,target:String):void {
		this.writeMailCanvas.refresh(title,target);
		this.viewStach.selectedChild = this.writeMailCanvas;
		this.buttonBar.selectedIndex = 4;
	}
	
	/**
	 * 0:inbox
	 * 1:system
	 * 2:outBox
	 * 3:write
	 */
	private function tbClick(event:ItemClickEvent):void {
		if (event.index == 4) {
			this.switchToWriteMail("","");
		} else {
			this.selectedTab = event.index;
			this.switchVs();
		}
    }

    private function tbSwitch(t:int):void{
    	switch(t){
    		case LetterConstant.LETTER_RECEIVE:
    		this.selectedTab = 0;
    		break;
    		case LetterConstant.MAIL_BATTLE_REPORT:
    		this.selectedTab = 1;
    		break;
    		case LetterConstant.LETTER_SYSTEM:
    		this.selectedTab = 2;
    		break;
    		case LetterConstant.LETTER_SEND:
    		this.selectedTab = 3;
    		break;
    	}
    }
    

	import roma.common.constants.LetterConstant;
	import roma.common.controller.mail.LetterListResponse;
	import roma.common.controller.mail.LetterResponse;
	import roma.common.valueObject.LetterBean;
	import roma.logic.CaesaryConfig;
	import roma.util.InputTextHelper;
	import roma.util.MultiLang;
	
	import views.windows.functionWins.mail.Mail;
		
	[Bindable]
	private var titleStr:String;
	[Bindable]
	public var systemMailTitle:String=MultiLang.msg("mail.systemMailTitle");
	[Bindable]
	public var underwrite:String=MultiLang.msg("mail.system.underwrite");
	[Bindable]
	private var reviseContent:String;

	override protected function getMailFromServer():void {
    	if (this.curMailIndex == LetterConstant.LETTER_SEND) {
    		this.titleStr = MultiLang.msg("mail.label.recipients");
    	} else {
    		this.titleStr = MultiLang.msg("mail.label.senter");
    	}
    	super.getMailFromServer();
	}

	override protected function onReceiveMail(event:LetterListResponse):void{
		super.onReceiveMail(event);		
    	if (this.curMailIndex == LetterConstant.LETTER_SEND) {
    		for each(var m:LetterBean in event.lettersArray) {
    			m.sender = m.receiver;
    		}
    	}
	}
	
	public function writeReback():void {
		var mailTitle:String = MultiLang.msg('mail.button.reply')+":" + this.curLetterBean.title; 
		Mail.writeMailToPlayer(this.curLetterBean.sender , mailTitle);
	}
	
	override protected function onReadMail(event:LetterResponse):void{
		this.curLetterBean.content =event.mailBean.content;
		this.reviseContent=CaesaryConfig.instance.isEnVersion==true?InputTextHelper.reviseEmailContentHandle(this.curLetterBean.content):this.curLetterBean.content;
//		this.reviseContent=this.curLetterBean.contents;
	}
		
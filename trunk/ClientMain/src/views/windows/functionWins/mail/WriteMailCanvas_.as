	// ActionScript file
	import mx.controls.TextArea;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.LetterConstant;
	import roma.common.controller.CommonResponse;
	import roma.util.InputTextHelper;
	import roma.util.MultiLang;
	
	import views.MainContainer;
	import views.PopupWindows;
	import views.spreadUI.MyAlert;
	import views.windows.functionWins.mail.Mail;

	[Bindable]
	private var mailTitle:String;
	
	[Bindable]
	private var replyName:String;
	
	public function refresh(title:String,target:String):void {
		this.mailTitle = title;
		this.replyName = target;
		if(this.initialized){
			receiveNameText.text=this.replyName;
		}
	}
	
	private function sendLetterToServer():void{
		if(sendTitleInput.text == ""){
			MyAlert.show(MultiLang.msg("mail.msg.noSubject"));
			return;
		}
		else if(this.receiveNameText.text == ""){
			MyAlert.show(MultiLang.msg("mail.msg.noRecipients"));
			return;
		}else if(sendContentText.text==""){
			MyAlert.show(MultiLang.msg("mail.msg.contentsEmpty"));
			return;
		}
		ControllerFactory.getInstance().getLetterController().sendLetter(receiveNameText.text,sendTitleInput.text,sendContentText.text,onSendMail);
		this.receiveNameText.text = "";
		this.sendTitleInput.text = "";
		this.sendContentText.text = "";
	}

	/**
	 * 发送信件返回
	 */ 
	private function onSendMail(event:CommonResponse):void{
		if(event.isSuccess()){
			MainContainer.instance.risePlay(MultiLang.msg("mail.msg.success"));
		} else {
			MyAlert.showError(event);
		}
	}
	
	private function backToMainWin():void {
		PopupWindows.openFuncWin(Mail.WINDOW_SHOW);
	}
	
	//标题输入限制
	private function titleInputChange(event:Event):void{
 		var c:int = 0;
 		TextInput(event.currentTarget).maxChars = LetterConstant.TITLE_LENGTH_LIMIT;
		for (var i:int=0;i<event.target.text.length;i++){
			var str:String = event.target.text.substr(i,1);
			if(InputTextHelper.isDoubleByte(str)){
				c +=2;
			} else {
				c +=1;
			}
			if (event.currentTarget == sendTitleInput && c>LetterConstant.TITLE_LENGTH_LIMIT) { 
				sendTitleInput.text = sendTitleInput.text.substring(0,i);
				break;
			}
		}
	} 
	//内容输入限制  
	private function contentsInputChange(event:Event):void{
 		var c:int = 0;
 		TextArea(event.currentTarget).maxChars = LetterConstant.CONTENT_LIMIT_LENGTH;
		for (var i:int=0;i<event.target.text.length;i++){
			var str:String = event.target.text.substr(i,1);
			if(InputTextHelper.isDoubleByte(str)){
				c +=2;
			} else {
				c +=1;
			}
			if (event.currentTarget == this.sendContentText && c>LetterConstant.CONTENT_LIMIT_LENGTH) { 
				this.sendContentText.text = this.sendContentText.text.substring(0,i);
				break;
			}					
		}
	} 
	
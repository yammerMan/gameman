
	import flash.xml.XMLDocument;
	
	import mx.rpc.xml.SimpleXMLDecoder;
	import mx.utils.XMLUtil;
	
	import roma.common.action.ControllerFactory;
	import roma.common.controller.mail.LetterListResponse;
	import roma.common.controller.mail.LetterResponse;
	import roma.common.valueObject.LetterBean;
	import roma.util.JavaScriptHelper;
	
	import views.windows.functionWins.mail.ReportUi.ReportManager;
	
	[Bindable]
	private var xmlObj:Object = {};
	
	override protected function onReceiveMail(event:LetterListResponse):void{
		super.onReceiveMail(event);
	}
	
	override public function onSeeAbout(bean:LetterBean):void{
//		super.onSeeAbout(mailBean);
		this.curLetterBean = bean;
		ControllerFactory.getInstance().getLetterController().readLetter(bean.mailId,false,onReadMail);
	}
	
	override protected function onReadMail(event:LetterResponse):void{
		if(event.mailBean.content == ""){
			// 信件内容为空
			this.curLetterBean.content = event.mailBean.content;
			this.viewSelectedIndex = 2;
			return;
		}

		var xmlDoc:XMLDocument = XMLUtil.createXMLDocument(event.mailBean.content);
		var decoder:SimpleXMLDecoder = new SimpleXMLDecoder(true);
        xmlObj = decoder.decodeXML(xmlDoc);
		if(xmlObj.hasOwnProperty('reportData')){
			this.viewSelectedIndex = 1;
		}else{
			this.curLetterBean.content = event.mailBean.content;
			this.viewSelectedIndex = 2;
		}
	}
	
	/**
	 * 直接进入战报过程
	 */ 
	public function onSeeProcess(data:Object):void{
		ControllerFactory.getInstance().getLetterController().readLetter(data.id,false,onRead);
		function onRead(event:LetterResponse):void{
			var obj:Object = {};
			var xmlD:XMLDocument = XMLUtil.createXMLDocument(event.mailBean.content);
			var decoder:SimpleXMLDecoder = new SimpleXMLDecoder(true);
	        obj = decoder.decodeXML(xmlD);
			var str:String = ReportManager.getBattleUrl(obj.reportData.url);
			JavaScriptHelper.instance.getURL(str);
		}
		
	}
	
	public function isShowProcess(data:Object):Boolean{
		var xml:XML = XML(data.title);
		if(xml.hasOwnProperty('battle')){
			// 这里无法对是否是攻击方并且胜利的判断
//			if(Object(xml.battle).hasOwnProperty('@round') && xml.battle.@round>1)
			return true;
			/* else
			return false; */
		}else{
			return false;
		}
	}

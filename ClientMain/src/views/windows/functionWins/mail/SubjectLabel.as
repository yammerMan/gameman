package views.windows.functionWins.mail
{
	import mx.controls.Label;
	
	import roma.common.constants.LetterConstant;
	import roma.common.valueObject.LetterBean;
	
	import views.windows.functionWins.mail.ReportUi.ReportManager;

	public class SubjectLabel extends Label
	{
		public function SubjectLabel()
		{
			super();
		}
		
		public function set myLabelStyle(type:int):void{
			if(type == LetterConstant.HAS_READ){
				setStyle("fontWeight","normal");		
			}
			else if(type == LetterConstant.HASNT_READ){
				setStyle("fontWeight","bold");
			}
		}
		
		public function set subjectText(m:Object):void{
			var mail:LetterBean = LetterBean(m);
			text = ReportManager.parseTitleStr(m.title);
			ReportManager.instance.reportTitleDic[mail.mailId] = text;
			setLabelStyle(m.title);
		}
		
		public function setLabelStyle(tStr:String):void{
			var typeStr:String = ReportManager.getReportType(tStr);
			
			switch(typeStr){
				case "scoutReport":
					this.styleName = "scoutReport";
				break;
				default:
					this.styleName = "";
			}
		}
		
	}
}
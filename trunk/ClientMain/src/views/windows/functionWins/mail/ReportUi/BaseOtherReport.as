package views.windows.functionWins.mail.ReportUi
{
	import mx.containers.Canvas;
	import mx.utils.ObjectProxy;
	
	public class BaseOtherReport extends Canvas
	{
		[Bindable]
		public var reportDesc:String = "";
		[Bindable]
		public var reportObj:ObjectProxy = new ObjectProxy();
		
		public function BaseOtherReport()
		{
		}

		public function setReportObj(o:ObjectProxy):void{
			
		}
	}
}
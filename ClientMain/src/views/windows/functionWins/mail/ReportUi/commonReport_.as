/** commonReport as代码 */
	import mx.utils.ObjectProxy;
	
	import roma.logic.GameContext;
	
	import views.windows.functionWins.mail.ReportUi.BaseOtherReport;
	import views.windows.functionWins.mail.ReportUi.ReportManager;
	
	[Bindable]
	private var timeStr:String = "";
	[Bindable]
	private var reportTitle:String = "";
	[Bindable]
	private var typeObj:ObjectProxy = new ObjectProxy();
	
	private var curViewIndex:int = 0;
	
	public function set reportObj(o:ObjectProxy):void{
		timeStr = GameContext.toLocalTimeStr(ReportManager.instance.receiveTime);
		reportTitle = ReportManager.instance.reportTitle;
		typeObj = null;
		if(o.hasOwnProperty('tradeReport')){
			// 市场贸易
			typeObj = o.tradeReport;
			curViewIndex = 0;
		}else if(o.hasOwnProperty('transportReport')){
			// 市场运输
			typeObj = o.transportReport;
			curViewIndex = 1;
		}else if(o.hasOwnProperty('uprisingReport')){
			// 民众暴乱
			typeObj = o.uprisingReport;
			curViewIndex = 2;
		}else if(o.hasOwnProperty('heroEscapeReport')){
			// 英雄叛逃
			typeObj = o.heroEscapeReport;
			curViewIndex = 3;
		}else if(o.hasOwnProperty('troopDieReport')){
			// 军队叛逃
			typeObj = o.troopDieReport;
			curViewIndex = 4;
		}
		else if(o.hasOwnProperty('troopMovement')){
			// 军队动态
			typeObj = o.troopMovement;
			curViewIndex = 5;
		}else if(o.hasOwnProperty('aniScout')){
			// 反侦察
			typeObj = o.aniScout;
			curViewIndex = 6;
		}else if(o.hasOwnProperty('heroGrowthReport')){
			// 英雄历练报告
			typeObj = o.heroGrowthReport;
			curViewIndex = 7;
		}else if(o.hasOwnProperty('conquestedReport')){
			// 征服报告
			typeObj = o.conquestedReport;
			curViewIndex = 8;
		}
		refreshClass();
	}
	
	private function refreshClass():void{
		if(this.initialized){
			if(typeObj == null)return;
			commonReportVS.selectedIndex = curViewIndex;
			BaseOtherReport(commonReportVS.selectedChild).setReportObj(typeObj);
		}
	}

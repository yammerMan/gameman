package views.windows.functionWins
{
	import mx.events.FlexEvent;
	
	import views.PopupWindows;
	import views.windows.BaseWin;
	import views.windows.WindowTitle;

	public class BaseFunctionWindow extends BaseWin
	{
		private var windowTitle:WindowTitle;
		
		protected function onCloseBtnClick():void {
			PopupWindows.closeAll();
		}
		
		protected function back():void{
			var win:BaseWin = PopupWindows.instance.prevWin;
			if(win !=null){
				PopupWindows.openFuncWin(win.winId,win.winData);		
			}
		}
			
		public function set title(str:String):void {
			this.windowTitle.winTitle = str;
		}
		
		override public function set bShow(b:Boolean):void{
			windowTitle.show = b;
		}
		
		public function BaseFunctionWindow()
		{
			super();
			windowTitle = new WindowTitle();
			windowTitle.callBack = back;
			windowTitle.onCloseFun = onCloseBtnClick;
			this.styleName = "BaseFunctionWindow";
		}
	
		override protected function onCreationComplete(event:FlexEvent):void {
			this.addChild(windowTitle);
			super.onCreationComplete(event);
		}
	}
}
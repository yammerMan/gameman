package views.windows.functionWins
{
	import mx.events.FlexEvent;
	
	import views.PopupWindows;
	import views.windows.BaseWin;
	import views.windows.WindowTitle1;

	public class BaseFunctionWindow2 extends BaseWin
	{
		private var windowTitle:WindowTitle1;
		
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
			this.windowTitle.title = str;
		}
		
		override public function set bShow(b:Boolean):void{
			windowTitle.show = b;
		}
		
		public function BaseFunctionWindow2()
		{
			super();
			windowTitle = new WindowTitle1();
			windowTitle.callBack = back;
			windowTitle.onCloseFun = onCloseBtnClick;
			this.styleName = "shopBG";
		}
	
		override protected function onCreationComplete(event:FlexEvent):void {
			this.addChild(windowTitle);
			super.onCreationComplete(event);
		}
	}
}
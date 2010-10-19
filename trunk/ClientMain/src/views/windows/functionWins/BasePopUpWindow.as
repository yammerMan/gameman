package views.windows.functionWins
{
	import mx.events.FlexEvent;
	
	import roma.util.PopupWinManager;
	
	import views.windows.BaseWin;
	import views.windows.WindowTitle;

	public class BasePopUpWindow extends BaseWin
	{
		private var windowTitle:WindowTitle;
		private var isPopUpWin:Boolean=true;
		
		protected function onCloseBtnClick():void {
			if(isPopUpWin){
				PopupWinManager.instance.removePopup();
			}else{
				this.visible=false;
			}
			
		}
		
		public function set setPopUp(boo:Boolean):void{
			this.isPopUpWin=boo;
		}
			
		public function set title(str:String):void {
			this.windowTitle.winTitle = str;
			this.windowTitle.y=1;
		}
		
		public function BasePopUpWindow()
		{
			super();
			windowTitle = new WindowTitle();
			windowTitle.onCloseFun = onCloseBtnClick;
			this.styleName = "popUpWinBG";
		}
	
		override protected function onCreationComplete(event:FlexEvent):void {
			this.addChild(windowTitle);
			super.onCreationComplete(event);
		}
	}
}
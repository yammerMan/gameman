package views.windows.functionWins
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import mx.controls.Button;
	import mx.events.FlexEvent;
	
	import roma.util.PopupWinManager;
	
	import views.windows.BaseWin;
	
	
	public class BaseFunctionWindow3 extends BaseWin
	{
		private var closeBtn:Button=new Button();
		protected function onCloseBtnClick():void {
			PopupWinManager.instance.removePopup(this);
		}
		
		public function BaseFunctionWindow3()
		{
			super();
			this.styleName = "baseTooltip";
			this.addEventListener(KeyboardEvent.KEY_DOWN,downHandler);
		}
	
		override protected function onCreationComplete(event:FlexEvent):void {
			closeBtn.styleName="dakCancleBtn";
			closeBtn.x=this.width-this.closeBtn.width+25;
			this.width = this.closeBtn.x + this.closeBtn.width+26;
			closeBtn.y=7;
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandle);
			this.addChild(closeBtn);
			super.onCreationComplete(event);
		}
		
		private function closeHandle(event:MouseEvent):void{
			this.onCloseBtnClick();
		}
		
		private function downHandler(event:KeyboardEvent):void{
			if(event.keyCode == Keyboard.ENTER){
				onSubmit();
			}
		}
		
		protected function onSubmit():void{
		}
	}
}
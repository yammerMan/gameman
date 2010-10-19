package views.spreadUI.castleStatus
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	import roma.resource.ImgManager;
	import roma.util.MultiLang;
	
//	import views.spreadUI.tips.CommonTooltip;
//	import views.spreadUI.tips.ToolTipContainer;
	
	public class SpeedUpButton extends UIComponent
	{
		private var speedUpBtn:MovieClip;
//		private var commonTip:CommonTooltip=ToolTipContainer.instance.commonTooltip;
		private static var speedUpMc:Class=ImgManager.clazz('buttonMc.speedUpBtn');
		public function SpeedUpButton() 
		{
//			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOverTip);
//			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutTip);
			this.speedUpBtn= new speedUpMc() as MovieClip;
			this.speedUpBtn.play();
			this.addChild(this.speedUpBtn);
			this.toolTip=MultiLang.msg('public.label.speed');
		}
		
//		private function onMouseOutTip(event:MouseEvent):void {
//			this.commonTip.onMouseOut();
//		}
//			
//		private function onMouseOverTip(event:MouseEvent):void {
//			this.commonTip.setTip(Lang.msg('public.label.speed'));
//			this.commonTip.onMouseOver(event);
//		}

	}
}
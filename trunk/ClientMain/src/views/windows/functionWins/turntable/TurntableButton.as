package views.windows.functionWins.turntable
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	import roma.resource.ImgManager;
	import roma.util.MultiLang;
	
	import views.spreadUI.tips.CommonTooltip;
	import views.spreadUI.tips.ToolTipContainer;
	import views.windows.functionWins.turntable.Turntable;

	public class TurntableButton extends UIComponent
	{
		private var turntableMc:MovieClip;
		public static var instance:TurntableButton;
		private var commonTip:CommonTooltip=ToolTipContainer.instance.commonTooltip;
		
		public function TurntableButton()
		{
			instance = this;
			addTurntableBtn();
		}
		
		/**
		 *添加打开轮盘按钮 
		 */		
		private function addTurntableBtn():void{
			var cl:Class = ImgManager.clazz('turntable.openButton');
			this.turntableMc = new cl() as MovieClip;
			this.turntableMc.buttonMode = true;
			this.turntableMc.useHandCursor = true;
			this.turntableMc.gotoAndStop(2);
			/* this.turntableMc.x = 182;
			this.turntableMc.y = 365; */
			this.addChild(this.turntableMc);
			
			var maskSprite:Sprite = new Sprite();
			maskSprite.graphics.beginFill(0x0,1);
			maskSprite.graphics.drawRect(0,0,85,35);
			this.addChild(maskSprite);
			
			turntableMc.mask = maskSprite;
			
			turntableMc.addEventListener(MouseEvent.MOUSE_DOWN,openTurntable);
			turntableMc.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			turntableMc.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
		}
		
		public function getTurntableMc():MovieClip{
			return this.turntableMc;
		}
		
		public function showTurntalbleMc():void{
			this.turntableMc.visible = true;
		}
		
		private function onMouseOver(event:MouseEvent):void{
			this.turntableMc.alpha = 0.7;
			this.commonTip.setTip(MultiLang.msg("turntable.desc"));
			this.commonTip.onMouseOver(event);
		}
		
		private function onMouseOut(event:MouseEvent):void{
			this.turntableMc.alpha = 1.0;
			this.commonTip.onMouseOut();
		}
		
		private function openTurntable(event:MouseEvent):void{
			Turntable.getInstance().show();
			this.turntableMc.visible = false;
		}
	}
}
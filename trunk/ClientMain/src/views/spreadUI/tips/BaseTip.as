package views.spreadUI.tips
{
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.containers.Canvas;
	import mx.core.Application;
	import mx.events.ResizeEvent;

	public class BaseTip extends Canvas
	{
		
		private var isShow:Boolean = false;
		private var timer:Timer = new Timer(1);
		private var showType:int = 0;
		private var _evt:MouseEvent;
		
		public function BaseTip()
		{
			super();
			
			this.timer.addEventListener(TimerEvent.TIMER , timerHandler);
			this.addEventListener(ResizeEvent.RESIZE,resizeHandler);
			
			this.styleName="baseTooltip";
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
			this.horizontalScrollPolicy = "off";
			this.verticalScrollPolicy = "off";
		}
		
		private function resizeHandler(evt:ResizeEvent):void{
			resetCoordinate();
		}
		
		private function timerHandler(evt:TimerEvent):void {
			this.visible = this.isShow;
			this.timer.stop()
			if (!this.visible) {
				this.x = 0;
				this.y = 0;
			}
		}
		
		private function show(v:Boolean):void {
			if (this.timer.running) {
				this.timer.stop();
			}
			this.isShow = v;
			if (v) {
				this.visible = true;
			} else {
				this.timer.start();
			}
		}
		
		override public function set visible(v:Boolean):void {
			super.visible = v;
			//trace(this.className + ".visable = " + v );
		} 

		public function onMouseOver(event:MouseEvent,showType:int=0):void {
			this.refresh();
			this.showType = showType;
			if (showType ==1) {
				this.x = 1000-this.width-13;
				this.y = 600-this.height-190;
			} else {
				this.onMouseMove(event);
			}
			this.show(true);
		} 
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			if (this.showType == 1 ) {
				this.x = 1000 - unscaledWidth - 13;
				this.y = 600 - unscaledHeight - 190;
			}
		}

		public function onMouseMove(event:MouseEvent):void {
			this.x= event.stageX+10;
			this.y= event.stageY+20;
			
			_evt = event;
			
			resetCoordinate();
		}
		
		private function resetCoordinate():void{
			var maxX:int = Application.application.width;
			var maxY:int = Application.application.height;
			
			if ((this.x + this.width) > maxX) {
				this.x = maxX - this.width;
			} 
			
			if ((this.y + this.height) > maxY) {
				this.y = maxY - this.height;
			}

			if (this.x == (maxX - this.width) && this.y == (maxY - this.height)) {
				this.x = _evt.stageX - this.width - 10;
			}  
		}
		
		public function onMouseOut():void {
			this.show(false);
//		    this.visible = false;
//			this.timer.stop();
		}
		
		public function refresh():void {
			
		}
		
		public function getVisible():Boolean{
			return this.visible;
		}
	}
}
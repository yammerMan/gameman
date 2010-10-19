package roma.war.ui
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;

	public class ProgressLine extends Sprite
	{
		public static const STATE_CHANGE:String = "play_progress_change";
		
		public function ProgressLine()
		{
			super();
			
			maxX = areaMc.width - progressBtn.width;
			if(this.stage){
				init()
			}else{
				addEventListener(Event.ADDED_TO_STAGE,init);
			}
		}
		private function init(event:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			progressBtn.addEventListener(MouseEvent.MOUSE_DOWN,progressDargHandler);
			progressBtn.addEventListener(MouseEvent.MOUSE_UP,onProgressBtnUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,progressDargHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP,progressDargHandler);
			
			areaMc.addEventListener(MouseEvent.CLICK,barClickHanlder);
		}
		
		public var position:Number = 0;
		public var isDrag:Boolean = false;
		
		private var maxX:Number;
		private var inBtnMouseX:Number = 0;
		private function progressDargHandler(event:MouseEvent):void{
			switch(event.type){
				case MouseEvent.MOUSE_DOWN:
					if(!isDrag){
						isDrag = true;
						inBtnMouseX = progressBtn.mouseX * progressBtn.scaleX;
					}
				break;
				case MouseEvent.MOUSE_MOVE:
					if(isDrag){
						var mx:Number = areaMc.mouseX * areaMc.scaleX - inBtnMouseX;
						if(mx < 0){
							progressBtn.x = areaMc.x;
						}else if(mx > maxX){
							progressBtn.x = areaMc.x + maxX;
						}else{
							progressBtn.x = areaMc.x + mx;
						}
					}
				break;
				case MouseEvent.MOUSE_UP:
					if(isDrag)
						isDrag = false;
				break;
			}
		}
		
		private function onProgressBtnUp(e:MouseEvent):void{
			if(isDrag)isDrag = false;
			var p:Number = Math.max((progressBtn.x - areaMc.x)/maxX,.01);
			if(position != p){
				position = p;
				value = position * max;
				updateBar(true);
				dispatchEvent(new Event(STATE_CHANGE,true));
			}
		}
		
		private function barClickHanlder(event:MouseEvent):void{
			var p:Number = areaMc.mouseX * areaMc.scaleX/areaMc.width;
			if(position != p){
				position = p;
				value = position * max;
				updateBar(true);
				dispatchEvent(new Event(STATE_CHANGE,true));
			}			
		}
		
		private function updateBar(real:Boolean = false):void{
			position = value/max;
			progressBar.setProgress(value,max,false);
			if(real){
				progressBar.currentNumber = progressBar.targetNumberber;
				progressBar.update();
			}
		}
		
		private var value:Number;
		private var max:Number;
		public function setProgress(value:Number,max:Number):void{
			this.value = value;
			this.max = max;
			updateBar();
		}
		
		public function update():void{
			progressBar.update();
			if(!isDrag)progressBtn.x = areaMc.x + progressBar.currentNumber/progressBar.totalNumber * maxX;
		}
		
		public function get progressBtn():SimpleButton{
			return this["progress_btn"];
		}
		public function get progressBar():LineHP{
			return this["bar_mc"];
		}
		public function get areaMc():Sprite{
			return this["area_mc"];
		}
		
	}
}
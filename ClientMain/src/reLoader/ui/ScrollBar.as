package reLoader.ui
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ScrollBar extends Sprite
	{
		public function ScrollBar()
		{
			super();
			
			
			maxY = areaMc.height - rollBtn.height;
			if(this.stage){
				init()
			}else{
				addEventListener(Event.ADDED_TO_STAGE,init);
			}
		}
		private function init(event:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			rollBtn.addEventListener(MouseEvent.MOUSE_DOWN,rollDargHandler);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,rollDargHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP,rollDargHandler);
			
			if(upBtn){
				upBtn.addEventListener(MouseEvent.CLICK,upDownButtonHandler);
			}
			if(downBtn){
				downBtn.addEventListener(MouseEvent.CLICK,upDownButtonHandler);
			}
		}
		
		public var position:Number = 0;
		public var isDrag:Boolean = false;
		
		private var inBtnMouseY:Number = 0;
		private function rollDargHandler(event:MouseEvent):void{
			switch(event.type){
				case MouseEvent.MOUSE_DOWN:
					if(!isDrag){
						isDrag = true;
						inBtnMouseY = rollBtn.mouseY * rollBtn.scaleY;
					}
				break;
				case MouseEvent.MOUSE_MOVE:
					if(isDrag){
						var my:Number = areaMc.mouseY * areaMc.scaleY - inBtnMouseY;
						if(my < 0){
							rollBtn.y = areaMc.y;
						}else if(my > maxY){
							rollBtn.y = areaMc.y+maxY;
						}else{
							rollBtn.y = areaMc.y + my;
						}
						
						var p:Number = Math.ceil((rollBtn.y - areaMc.y)/maxY*100)/100;
						if(position != p){
							position = p;
							value = Math.ceil(position * max);
							//updateBar();
							dispatchEvent(new Event(Event.SCROLL));
						}
					}
				break;
				case MouseEvent.MOUSE_UP:
					if(isDrag){
						isDrag = false;
					}
				break;
			}
		}
		
		private var value:Number;
		private var max:Number;
		private var maxY:Number;
		public function scrollTo(value:Number,max:Number):void{
			if(!isDrag){
				this.value = value;
				this.max = max;
				updateBar();
			}
		}
		
		private function upDownButtonHandler(event:MouseEvent):void{
			var v:Number = value;
			switch(event.target.name){
				case "up_btn":
					if(v>0)v-=2;
					else v = 0;
				break;
				case "down_btn":
					if(v<max)v+=2;
					else v = max;
				break;
			}
			if(v != value){
				value = v;
				updateBar();
				dispatchEvent(new Event(Event.SCROLL));
			}
		}
		private function updateBar():void{
				position = value/max;
				rollBtn.y = areaMc.y + position * maxY;
		}
		
		public function get upBtn():SimpleButton{
			return this["up_btn"];
		}
		public function get downBtn():SimpleButton{
			return this["down_btn"];
		}
		public function get rollBtn():SimpleButton{
			return this["roll_btn"];
		}
		public function get areaMc():Sprite{
			return this["area_mc"];
		}
		
	}
}
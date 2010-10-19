package roma.war.ui
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class WindowStateBtn extends Sprite
	{
		public static const STATE_MAXIMIZE:String = "state_maximize";
		public static const STATE_MINIMIZE:String = "state_minimize";
		
		public function WindowStateBtn()
		{
			super();
			minBtn.addEventListener(MouseEvent.CLICK,changeStateHandler);
			maxBtn.addEventListener(MouseEvent.CLICK,changeStateHandler);
			changeState(STATE_MINIMIZE);
		}
		
		private var _state:String;
		public function set state(s:String):void{
			if(s!=_state){
				_state = s;
				changeState(_state);
			}
		}
		public function get state():String{
			return _state;
		}
		public function get minBtn():SimpleButton{
			return this["min_btn"];
		}
		public function get maxBtn():SimpleButton{
			return this["max_btn"];
		}
		
		private function changeState(s:String):void{
			switch(s){
				case STATE_MAXIMIZE:
					minBtn.visible = true;
					maxBtn.visible = false;
				break;
				case STATE_MINIMIZE:
					minBtn.visible = false;
					maxBtn.visible = true;
				break;
			}
			dispatchEvent(new Event(s,true));
		}
		private function changeStateHandler(event:MouseEvent):void{
			switch(event.target.name){
				case "max_btn":
					changeState(STATE_MAXIMIZE);
				break;
				case "min_btn":
					changeState(STATE_MINIMIZE);
				break;
			}
		}
	}
}
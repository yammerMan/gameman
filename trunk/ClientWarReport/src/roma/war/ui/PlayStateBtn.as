package roma.war.ui
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;

	public class PlayStateBtn extends Sprite
	{
		public static const STATE_NEXT:String = "play_state_next";
		public static const STATE_PREVIOUS:String = "play_state_previous";
		public static const STATE_PAUSE:String = "play_state_pause";
		public static const STATE_PLAY:String = "play_state_play";
		
		
		public function PlayStateBtn()
		{
			super();
			addButtonEvent(prevBtn);
			addButtonEvent(nextBtn);
			addButtonEvent(pauseBtn);
			addButtonEvent(playBtn);
			isPlaying = false;
			isPlaying = true;
		}
		
		private var _isPlaying:Boolean = true;
		public function set isPlaying(b:Boolean):void{
			if(b != _isPlaying){
				_isPlaying = b;
				pauseBtn.visible = _isPlaying;
				playBtn.visible = !_isPlaying;
			}
		}
		public function get isPlaying():Boolean{
			return _isPlaying;
		}
		
		public function get prevBtn():SimpleButton{
			return this["prev_btn"];
		}
		public function get nextBtn():SimpleButton{
			return this["next_btn"];
		}
		public function get pauseBtn():SimpleButton{
			return this["pause_btn"];
		}
		public function get playBtn():SimpleButton{
			return this["play_btn"];
		}
		
		private function addButtonEvent(ied:IEventDispatcher):void{
			ied.addEventListener(MouseEvent.CLICK,buttonsEventHandler);
		}
		
		private function buttonsEventHandler(event:MouseEvent):void{
			switch(event.target.name){
				case "prev_btn":
					dispatchEvent(new Event(STATE_PREVIOUS,true));
				break;
				case "next_btn":
					dispatchEvent(new Event(STATE_NEXT,true));
				break;
				case "pause_btn":
					isPlaying = false;
					dispatchEvent(new Event(STATE_PAUSE,true));
				break;
				case "play_btn":
					isPlaying = true;
					dispatchEvent(new Event(STATE_PLAY,true));
				break;
			}
		}
		
	}
}